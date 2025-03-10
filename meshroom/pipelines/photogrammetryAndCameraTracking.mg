{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2023.2.0",
        "fileVersion": "1.1",
        "template": true,
        "nodesVersions": {
            "MeshDecimate": "1.0",
            "DepthMap": "4.0",
            "MeshFiltering": "3.0",
            "ApplyCalibration": "1.0",
            "CameraInit": "9.0",
            "ScenePreview": "1.0",
            "StructureFromMotion": "3.1",
            "PrepareDenseScene": "3.0",
            "Publish": "1.3",
            "ExportAnimatedCamera": "2.0",
            "Texturing": "6.0",
            "DepthMapFilter": "3.0",
            "ImageMatchingMultiSfM": "1.0",
            "CheckerboardDetection": "1.0",
            "ExportDistortion": "1.0",
            "FeatureMatching": "2.0",
            "ImageMatching": "2.0",
            "ConvertSfMFormat": "2.0",
            "FeatureExtraction": "1.2",
            "KeyframeSelection": "4.1",
            "Meshing": "7.0",
            "DistortionCalibration": "3.0"
        }
    },
    "graph": {
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                -200,
                0
            ],
            "inputs": {},
            "internalInputs": {
                "label": "InitShot"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                200,
                200
            ],
            "inputs": {
                "input": "{ApplyCalibration_1.output}"
            }
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                600,
                0
            ],
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}"
            },
            "internalInputs": {
                "label": "FeatureMatchingKeyframes"
            }
        },
        "ImageMatchingMultiSfM_1": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                1000,
                200
            ],
            "inputs": {
                "input": "{KeyframeSelection_1.outputSfMDataFrames}",
                "inputB": "{StructureFromMotion_2.output}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "VocabularyTree",
                "matchingMode": "a/b",
                "nbMatches": 20
            }
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                400,
                0
            ],
            "inputs": {
                "input": "{KeyframeSelection_1.outputSfMDataKeyframes}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "Exhaustive"
            },
            "internalInputs": {
                "label": "ImageMatchingKeyframes"
            }
        },
        "KeyframeSelection_1": {
            "nodeType": "KeyframeSelection",
            "position": [
                200,
                0
            ],
            "inputs": {
                "inputPaths": [
                    "{ApplyCalibration_1.output}"
                ]
            }
        },
        "MeshDecimate_1": {
            "nodeType": "MeshDecimate",
            "position": [
                1947,
                123
            ],
            "inputs": {
                "input": "{MeshFiltering_2.outputMesh}",
                "simplificationFactor": 0.05
            }
        },
        "Publish_1": {
            "nodeType": "Publish",
            "position": [
                2362,
                -139
            ],
            "inputs": {
                "inputFiles": [
                    "{ExportAnimatedCamera_1.output}",
                    "{ScenePreview_1.output}",
                    "{ExportDistortion_1.output}",
                    "{Texturing_2.output}"
                ]
            }
        },
        "ExportAnimatedCamera_1": {
            "nodeType": "ExportAnimatedCamera",
            "position": [
                1600,
                200
            ],
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "sfmDataFilter": "{ImageMatchingMultiSfM_2.inputB}",
                "exportUndistortedImages": true
            }
        },
        "CheckerboardDetection_1": {
            "nodeType": "CheckerboardDetection",
            "position": [
                -400,
                -160
            ],
            "inputs": {
                "input": "{CameraInit_2.output}",
                "useNestedGrids": true,
                "exportDebugImages": true
            }
        },
        "DistortionCalibration_1": {
            "nodeType": "DistortionCalibration",
            "position": [
                -200,
                -160
            ],
            "inputs": {
                "input": "{CheckerboardDetection_1.input}",
                "checkerboards": "{CheckerboardDetection_1.output}"
            }
        },
        "ExportDistortion_1": {
            "nodeType": "ExportDistortion",
            "position": [
                0,
                -160
            ],
            "inputs": {
                "input": "{DistortionCalibration_1.output}"
            }
        },
        "ApplyCalibration_1": {
            "nodeType": "ApplyCalibration",
            "position": [
                0,
                0
            ],
            "inputs": {
                "input": "{CameraInit_1.output}",
                "calibration": "{DistortionCalibration_1.output}"
            }
        },
        "ScenePreview_1": {
            "nodeType": "ScenePreview",
            "position": [
                2148,
                211
            ],
            "inputs": {
                "cameras": "{ConvertSfMFormat_1.output}",
                "model": "{MeshDecimate_1.output}",
                "undistortedImages": "{ExportAnimatedCamera_1.outputUndistorted}"
            }
        },
        "ConvertSfMFormat_1": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                1948,
                211
            ],
            "inputs": {
                "input": "{ExportAnimatedCamera_1.input}",
                "fileExt": "sfm",
                "describerTypes": "{StructureFromMotion_1.describerTypes}",
                "structure": false,
                "observations": false
            }
        },
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                1400,
                200
            ],
            "inputs": {
                "input": "{FeatureMatching_3.input}",
                "featuresFolders": "{FeatureMatching_3.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_3.output}",
                    "{FeatureMatching_2.output}"
                ],
                "describerTypes": "{FeatureMatching_3.describerTypes}",
                "nbFirstUnstableCameras": 0,
                "maxImagesPerGroup": 0,
                "bundleAdjustmentMaxOutliers": -1,
                "minInputTrackLength": 5,
                "minNumberOfObservationsForTriangulation": 3,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5
            },
            "internalInputs": {
                "comment": "Estimate cameras parameters for the complete camera tracking sequence."
            }
        },
        "StructureFromMotion_2": {
            "nodeType": "StructureFromMotion",
            "position": [
                800,
                0
            ],
            "inputs": {
                "input": "{FeatureMatching_5.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}",
                    "{FeatureMatching_5.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}",
                "lockScenePreviouslyReconstructed": true
            },
            "internalInputs": {
                "comment": "Solve all keyframes first.",
                "label": "StructureFromMotionKeyframes"
            }
        },
        "FeatureMatching_2": {
            "nodeType": "FeatureMatching",
            "position": [
                1200,
                360
            ],
            "inputs": {
                "input": "{ImageMatching_2.input}",
                "featuresFolders": "{ImageMatching_2.featuresFolders}",
                "imagePairsList": "{ImageMatching_2.output}"
            },
            "internalInputs": {
                "label": "FeatureMatchingAllFrames"
            }
        },
        "ImageMatching_2": {
            "nodeType": "ImageMatching",
            "position": [
                1000,
                360
            ],
            "inputs": {
                "input": "{ApplyCalibration_1.output}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "Sequential",
                "nbNeighbors": 20
            }
        },
        "CameraInit_2": {
            "nodeType": "CameraInit",
            "position": [
                -600,
                -160
            ],
            "inputs": {},
            "internalInputs": {
                "label": "InitLensGrid"
            }
        },
        "Texturing_2": {
            "nodeType": "Texturing",
            "position": [
                1406,
                -584
            ],
            "inputs": {
                "input": "{Meshing_2.output}",
                "imagesFolder": "{DepthMap_2.imagesFolder}",
                "inputMesh": "{MeshFiltering_2.outputMesh}"
            }
        },
        "Meshing_2": {
            "nodeType": "Meshing",
            "position": [
                1006,
                -584
            ],
            "inputs": {
                "input": "{DepthMapFilter_2.input}",
                "depthMapsFolder": "{DepthMapFilter_2.output}"
            }
        },
        "DepthMapFilter_2": {
            "nodeType": "DepthMapFilter",
            "position": [
                806,
                -584
            ],
            "inputs": {
                "input": "{DepthMap_2.input}",
                "depthMapsFolder": "{DepthMap_2.output}"
            }
        },
        "FeatureExtraction_2": {
            "nodeType": "FeatureExtraction",
            "position": [
                -394,
                -584
            ],
            "inputs": {
                "input": "{CameraInit_3.output}"
            }
        },
        "PrepareDenseScene_2": {
            "nodeType": "PrepareDenseScene",
            "position": [
                406,
                -584
            ],
            "inputs": {
                "input": "{StructureFromMotion_3.output}"
            }
        },
        "DepthMap_2": {
            "nodeType": "DepthMap",
            "position": [
                606,
                -584
            ],
            "inputs": {
                "input": "{PrepareDenseScene_2.input}",
                "imagesFolder": "{PrepareDenseScene_2.output}"
            }
        },
        "MeshFiltering_2": {
            "nodeType": "MeshFiltering",
            "position": [
                1206,
                -584
            ],
            "inputs": {
                "inputMesh": "{Meshing_2.outputMesh}"
            }
        },
        "ImageMatchingMultiSfM_2": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                401,
                -299
            ],
            "inputs": {
                "input": "{KeyframeSelection_1.outputSfMDataKeyframes}",
                "inputB": "{StructureFromMotion_3.output}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "VocabularyTree",
                "matchingMode": "a/b"
            }
        },
        "FeatureMatching_3": {
            "nodeType": "FeatureMatching",
            "position": [
                1200,
                200
            ],
            "inputs": {
                "input": "{ImageMatchingMultiSfM_1.outputCombinedSfM}",
                "featuresFolders": "{ImageMatchingMultiSfM_1.featuresFolders}",
                "imagePairsList": "{ImageMatchingMultiSfM_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}"
            },
            "internalInputs": {
                "label": "FeatureMatchingFramesToKeyframes"
            }
        },
        "ImageMatching_3": {
            "nodeType": "ImageMatching",
            "position": [
                -194,
                -584
            ],
            "inputs": {
                "input": "{FeatureExtraction_2.input}",
                "featuresFolders": [
                    "{FeatureExtraction_2.output}"
                ]
            }
        },
        "StructureFromMotion_3": {
            "nodeType": "StructureFromMotion",
            "position": [
                206,
                -584
            ],
            "inputs": {
                "input": "{FeatureMatching_4.input}",
                "featuresFolders": "{FeatureMatching_4.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_4.output}"
                ],
                "describerTypes": "{FeatureMatching_4.describerTypes}"
            }
        },
        "CameraInit_3": {
            "nodeType": "CameraInit",
            "position": [
                -594,
                -584
            ],
            "inputs": {},
            "internalInputs": {
                "label": "InitPhotogrammetry"
            }
        },
        "FeatureMatching_4": {
            "nodeType": "FeatureMatching",
            "position": [
                6,
                -584
            ],
            "inputs": {
                "input": "{ImageMatching_3.input}",
                "featuresFolders": "{ImageMatching_3.featuresFolders}",
                "imagePairsList": "{ImageMatching_3.output}",
                "describerTypes": "{FeatureExtraction_2.describerTypes}"
            }
        },
        "FeatureMatching_5": {
            "nodeType": "FeatureMatching",
            "position": [
                607,
                -300
            ],
            "inputs": {
                "input": "{ImageMatchingMultiSfM_2.outputCombinedSfM}",
                "featuresFolders": "{ImageMatchingMultiSfM_2.featuresFolders}",
                "imagePairsList": "{ImageMatchingMultiSfM_2.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}"
            }
        }
    }
}
