import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import MaterialIcons 2.2
import Controls 1.0
import Utils 1.0

/**
 * CompatibilityManager summarizes and allows to resolve compatibility issues.
*/
MessageDialog {
    id: root

    // the UIGraph instance
    property var uigraph
    // alias to underlying compatibilityNodes model
    readonly property var nodesModel: uigraph ? uigraph.graph.compatibilityNodes : undefined
    // the total number of compatibility issues
    readonly property int issueCount: (nodesModel !== undefined && nodesModel !== null) ? nodesModel.count : 0
    // the number of CompatibilityNodes that can be upgraded
    readonly property int upgradableCount: {
        var count = 0
        for(var i=0; i<issueCount; ++i)
        {
            if(nodesModel.at(i).canUpgrade)
                count++;
        }
        return count
    }

    // override MessageDialog.getAsString to add compatibility report
    function getAsString() {
        var t = asString + "\n"
        t += '-------------------------\n'
        t += "Node | Issue | Upgradable\n"
        t += '-------------------------\n'
        for(var i=0; i<issueCount; ++i)
        {
            var n = nodesModel.at(i)
             t += n.nodeType + " | " + n.issueDetails +  " | " + n.canUpgrade + "\n"
        }
        t += "\n" + questionLabel.text
        return t
    }

    signal upgradeDone()

    title: "Compatibility issues detected"
    text: "This project contains " + issueCount + " node(s) incompatible with the current version of Meshroom."
    detailedText: {
        let releaseVersion = uigraph ? uigraph.graph.fileReleaseVersion : "0.0"
        return "Project was created with Meshroom " + releaseVersion + "."
    }

    helperText: upgradableCount ?
                upgradableCount + " node(s) can be upgraded but this might invalidate already computed data.\n"
                + "This operation is undoable and can also be done manually in the Graph Editor."
                : ""

    ColumnLayout {
        spacing: 16

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.maximumHeight: 300
            implicitHeight: contentHeight
            clip: true
            model: nodesModel
            ScrollBar.vertical: ScrollBar { id: scrollBar }

            spacing: 4
            headerPositioning: ListView.OverlayHeader
            header: Pane {
                z: 2
                width: ListView.view.width
                padding: 6
                background: Rectangle { color: Qt.darker(parent.palette.window, 1.15) }
                RowLayout {
                    width: parent.width
                    Label { text: "Node"; Layout.preferredWidth: 130; font.bold: true }
                    Label { text: "Issue"; Layout.fillWidth: true; font.bold: true }
                    Label { text: "Upgradable"; font.bold: true }
                }
            }

            delegate: RowLayout {
                id: compatibilityNodeDelegate

                property var node: object

                width: ListView.view.width - 12
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    Layout.preferredWidth: 130
                    text: compatibilityNodeDelegate.node ? compatibilityNodeDelegate.node.nodeType : ""
                }
                Label {
                    Layout.fillWidth: true
                    text: compatibilityNodeDelegate.node ? compatibilityNodeDelegate.node.issueDetails : ""
                }
                Label {
                    text: compatibilityNodeDelegate.node && compatibilityNodeDelegate.node.canUpgrade ? MaterialIcons.check : MaterialIcons.clear
                    color: compatibilityNodeDelegate.node && compatibilityNodeDelegate.node.canUpgrade ? "#4CAF50" : "#F44336"
                    font.family: MaterialIcons.fontFamily
                    font.pointSize: 14
                    font.bold: true
                }
            }

        }

        Label {
            id: questionLabel
            text: upgradableCount ? "Upgrade all possible nodes to current version?"
                                  : "Those nodes can't be upgraded, remove them manually if needed."
        }
    }

    standardButtons: upgradableCount ? Dialog.Yes | Dialog.No : Dialog.Ok

    icon {
        text: MaterialIcons.warning
        color: "#FF9800"
    }

    onAccepted: {
        if(upgradableCount)
        {
            uigraph.upgradeAllNodes()
            upgradeDone()
        }
    }

}
