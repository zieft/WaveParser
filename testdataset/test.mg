{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "MeshFiltering": "3.0",
            "CameraInit": "4.0",
            "Texturing": "5.0",
            "ImageMatching": "2.0",
            "FeatureExtraction": "1.1",
            "Meshing": "7.0",
            "FeatureMatching": "2.0",
            "DepthMapFilter": "3.0",
            "PrepareDenseScene": "3.0",
            "StructureFromMotion": "2.0",
            "DepthMap": "2.0"
        }
    },
    "graph": {
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                0,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 12,
                "split": 1
            },
            "uids": {
                "0": "2fbed76d35a8548da5317040cf91dea64422a96d"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 403620519,
                        "poseId": 403620519,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5027.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"332\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"153\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"76\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"28\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"83\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"76\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:51\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:51\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:51\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"4000\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"4000\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"01\", \"Exif:SubsecTimeDigitized\": \"01\", \"Exif:SubsecTimeOriginal\": \"01\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 472110139,
                        "poseId": 472110139,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5026.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"320\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"153\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"71\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"44\", \"Canon:FNumber\": \"248\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"76\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"88\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:46\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:46\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:46\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"3200\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"3200\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"84\", \"Exif:SubsecTimeDigitized\": \"84\", \"Exif:SubsecTimeOriginal\": \"84\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 883995219,
                        "poseId": 883995219,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5024.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"320\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"153\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"76\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"20\", \"Canon:FNumber\": \"240\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"83\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"80\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:34\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:34\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:34\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"3200\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"3200\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"81\", \"Exif:SubsecTimeDigitized\": \"81\", \"Exif:SubsecTimeOriginal\": \"81\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1320859956,
                        "poseId": 1320859956,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5019.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"308\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"152\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"83\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"32\", \"Canon:FNumber\": \"248\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"89\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"100\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:03:59\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:03:59\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:03:59\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"2500\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"2500\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"27\", \"Exif:SubsecTimeDigitized\": \"27\", \"Exif:SubsecTimeOriginal\": \"27\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1518342331,
                        "poseId": 1518342331,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5022.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"300\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"153\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"83\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"32\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"89\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"104\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:24\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:24\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:24\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"2000\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"2000\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"40\", \"Exif:SubsecTimeDigitized\": \"40\", \"Exif:SubsecTimeOriginal\": \"40\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1542081998,
                        "poseId": 1542081998,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5020.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"340\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"152\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"83\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"28\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"89\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"64\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:05\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:05\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:05\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"5000\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"5000\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"53\", \"Exif:SubsecTimeDigitized\": \"53\", \"Exif:SubsecTimeOriginal\": \"53\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1568288791,
                        "poseId": 1568288791,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5018.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"308\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"152\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"83\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"40\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"89\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"96\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:03:53\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:03:53\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:03:53\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"2500\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"2500\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"77\", \"Exif:SubsecTimeDigitized\": \"77\", \"Exif:SubsecTimeOriginal\": \"77\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1723453686,
                        "poseId": 1723453686,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5017.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"340\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"152\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"97\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"8\", \"Canon:FNumber\": \"248\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"107\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"64\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:03:47\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:03:47\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:03:47\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"5000\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"5000\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"90\", \"Exif:SubsecTimeDigitized\": \"90\", \"Exif:SubsecTimeOriginal\": \"90\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1814273515,
                        "poseId": 1814273515,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5023.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"300\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"153\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"71\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"48\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"76\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"104\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:29\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:29\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:29\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"2000\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"2000\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"94\", \"Exif:SubsecTimeDigitized\": \"94\", \"Exif:SubsecTimeOriginal\": \"94\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1968276887,
                        "poseId": 1968276887,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5016.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"332\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"151\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"71\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"0\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"70\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"76\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"76\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"31\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:03:21\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:03:21\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:03:21\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"70\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"4000\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"4000\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"52\", \"Exif:SubsecTimeDigitized\": \"52\", \"Exif:SubsecTimeOriginal\": \"52\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1971951008,
                        "poseId": 1971951008,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5021.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"340\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"153\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"83\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"28\", \"Canon:FNumber\": \"244\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"89\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"64\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:19\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:19\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:19\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"5000\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"5000\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"15\", \"Exif:SubsecTimeDigitized\": \"15\", \"Exif:SubsecTimeOriginal\": \"15\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2097795283,
                        "poseId": 2097795283,
                        "path": "C:/Users/zieft/Desktop/testdataset/313A5025.JPG",
                        "intrinsicId": 1112458593,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:useWhiteBalance\": \"1\", \"Artist\": \"\", \"Canon:AEBBracketValue\": \"1\", \"Canon:AFPoint\": \"0\", \"Canon:AFPointsInFocus\": \"0\", \"Canon:AutoExposureBracketing\": \"0\", \"Canon:AutoISO\": \"0\", \"Canon:AutoRotate\": \"0\", \"Canon:BaseISO\": \"308\", \"Canon:BlackMaskBottomBorder\": \"0\", \"Canon:BlackMaskLeftBorder\": \"0\", \"Canon:BlackMaskRightBorder\": \"0\", \"Canon:BlackMaskTopBorder\": \"0\", \"Canon:BulbDuration\": \"0\", \"Canon:CameraISO\": \"15\", \"Canon:CameraTemperature\": \"153\", \"Canon:CameraType\": \"248\", \"Canon:ColorTone\": \"0\", \"Canon:ContinuousDrive\": \"4\", \"Canon:Contrast\": \"0\", \"Canon:ControlMode\": \"71\", \"Canon:CropInfo\": \"0, 0, 0, 0\", \"Canon:CustomPictureStyleFileName\": \"\", \"Canon:DigitalZoom\": \"0\", \"Canon:DisplayAperture\": \"0\", \"Canon:EasyMode\": \"1\", \"Canon:ExposureComp\": \"0\", \"Canon:ExposureCompensation\": \"-32\", \"Canon:ExposureMode\": \"4\", \"Canon:ExposureTime\": \"44\", \"Canon:FNumber\": \"240\", \"Canon:FirmwareVersion\": \"Firmware Version 1.0.0\", \"Canon:FlashActivity\": \"0\", \"Canon:FlashBits\": \"8\", \"Canon:FlashExposureComp\": \"0\", \"Canon:FlashGuideNumber\": \"0\", \"Canon:FlashMode\": \"0\", \"Canon:FlashOutput\": \"0\", \"Canon:FocalLength\": \"135\", \"Canon:FocalPlaneXSize\": \"55022\", \"Canon:FocalPlaneYSize\": \"13546\", \"Canon:FocalType\": \"2\", \"Canon:FocalUnits\": \"1\", \"Canon:FocusContinuous\": \"0\", \"Canon:FocusDistanceLower\": \"192\", \"Canon:FocusDistanceUpper\": \"76\", \"Canon:FocusMode\": \"1\", \"Canon:FocusRange\": \"1\", \"Canon:ImageSize\": \"0\", \"Canon:ImageStabilization\": \"256\", \"Canon:ImageType\": \"Canon EOS R6m2\", \"Canon:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Canon:LensType\": \"-4354\", \"Canon:MacroMode\": \"2\", \"Canon:ManualFlashOutput\": \"0\", \"Canon:MaxAperture\": \"96\", \"Canon:MaxFocalLength\": \"200\", \"Canon:MeasuredEV\": \"92\", \"Canon:MeasuredEV2\": \"0\", \"Canon:MeteringMode\": \"4\", \"Canon:MinAperture\": \"320\", \"Canon:MinFocalLength\": \"70\", \"Canon:ModelID\": \"2147484801\", \"Canon:NDFilter\": \"0\", \"Canon:OpticalZoomCode\": \"12\", \"Canon:OwnerName\": \"\", \"Canon:Quality\": \"3\", \"Canon:RecordMode\": \"1\", \"Canon:Saturation\": \"0\", \"Canon:SelfTimer\": \"0\", \"Canon:SelfTimer2\": \"-1\", \"Canon:SensorBottomBorder\": \"4107\", \"Canon:SensorHeight\": \"4120\", \"Canon:SensorLeftBorder\": \"168\", \"Canon:SensorRightBorder\": \"6167\", \"Canon:SensorTopBorder\": \"108\", \"Canon:SensorWidth\": \"6188\", \"Canon:SequenceNumber\": \"0\", \"Canon:Sharpness\": \"32767\", \"Canon:SlowShutter\": \"3\", \"Canon:TargetAperture\": \"192\", \"Canon:TargetExposureTime\": \"244\", \"Canon:ThumbnailImageValidArea\": \"0, 159, 6, 113\", \"Canon:WhiteBalance\": \"1\", \"Canon:ZoomSourceWidth\": \"0\", \"Canon:ZoomTargetWidth\": \"0\", \"Copyright\": \"\", \"DateTime\": \"2023:05:21 16:04:42\", \"Exif:ApertureValue\": \"6\", \"Exif:BodySerialNumber\": \"043020001093\", \"Exif:CameraOwnerName\": \"\", \"Exif:ColorSpace\": \"1\", \"Exif:CustomRendered\": \"0\", \"Exif:DateTimeDigitized\": \"2023:05:21 16:04:42\", \"Exif:DateTimeOriginal\": \"2023:05:21 16:04:42\", \"Exif:ExifVersion\": \"0231\", \"Exif:ExposureBiasValue\": \"-1\", \"Exif:ExposureMode\": \"1\", \"Exif:ExposureProgram\": \"1\", \"Exif:Flash\": \"0\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"135\", \"Exif:FocalPlaneResolutionUnit\": \"2\", \"Exif:FocalPlaneXResolution\": \"4234.3\", \"Exif:FocalPlaneYResolution\": \"4232.8\", \"Exif:LensModel\": \"RF70-200mm F2.8 L IS USM\", \"Exif:LensSerialNumber\": \"1450004452\", \"Exif:LensSpecification\": \"70, 200, 0, 0\", \"Exif:MeteringMode\": \"6\", \"Exif:OffsetTime\": \"+01:00\", \"Exif:OffsetTimeDigitized\": \"+01:00\", \"Exif:OffsetTimeOriginal\": \"+01:00\", \"Exif:PhotographicSensitivity\": \"2500\", \"Exif:PixelXDimension\": \"6000\", \"Exif:PixelYDimension\": \"4000\", \"Exif:RecommendedExposureIndex\": \"2500\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensitivityType\": \"2\", \"Exif:ShutterSpeedValue\": \"7.625\", \"Exif:SubsecTime\": \"32\", \"Exif:SubsecTimeDigitized\": \"32\", \"Exif:SubsecTimeOriginal\": \"32\", \"Exif:WhiteBalance\": \"1\", \"Exif:YCbCrPositioning\": \"2\", \"ExposureTime\": \"0.005\", \"FNumber\": \"8\", \"GPS:VersionID\": \"2, 3, 0, 0\", \"IPTC:Rating\": \"0\", \"Make\": \"Canon\", \"Model\": \"Canon EOS R6m2\", \"Orientation\": \"1\", \"ResolutionUnit\": \"none\", \"XResolution\": \"350\", \"YResolution\": \"350\", \"jpeg:subsampling\": \"4:2:2\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 1112458593,
                        "pxInitialFocalLength": -1.0,
                        "pxFocalLength": 7242.640687119285,
                        "type": "radial3",
                        "width": 6000,
                        "height": 4000,
                        "sensorWidth": -1.0,
                        "sensorHeight": -0.6666666666666666,
                        "serialNumber": "0430200010931450004452",
                        "principalPoint": {
                            "x": 3000.0,
                            "y": 2000.0
                        },
                        "initializationMode": "unknown",
                        "distortionParams": [
                            0.0,
                            0.0,
                            0.0
                        ],
                        "locked": false
                    }
                ],
                "sensorDatabase": "C:\\Meshroom-2021.1.0\\aliceVision\\share\\aliceVision\\cameraSensors.db",
                "defaultFieldOfView": 45.0,
                "groupCameraFallback": "folder",
                "allowedCameraModels": [
                    "pinhole",
                    "radial1",
                    "radial3",
                    "brown",
                    "fisheye4",
                    "fisheye1"
                ],
                "useInternalWhiteBalance": true,
                "viewIdMethod": "metadata",
                "viewIdRegex": ".*?(\\d+)",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/cameraInit.sfm"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                200,
                0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 12,
                "split": 1
            },
            "uids": {
                "0": "dc6312df843de4246dcc8f947e3fc7789acc0280"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{CameraInit_1.output}",
                "describerTypes": [
                    "sift"
                ],
                "describerPreset": "normal",
                "maxNbFeatures": 0,
                "describerQuality": "normal",
                "contrastFiltering": "GridSort",
                "relativePeakThreshold": 0.01,
                "gridFiltering": true,
                "forceCpuExtraction": true,
                "maxThreads": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                400,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 12,
                "split": 1
            },
            "uids": {
                "0": "7a970bd59080904eee7ed0d5b2b407672a6ad0ab"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureExtraction_1.input}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "VocabularyTree",
                "tree": "C:\\Meshroom-2021.1.0\\aliceVision\\share\\aliceVision\\vlfeat_K80L3.SIFT.tree",
                "weights": "",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 50,
                "nbNeighbors": 50,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/imageMatches.txt"
            }
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                600,
                0
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 12,
                "split": 1
            },
            "uids": {
                "0": "98f0cc8d9cf4cf6c0e3c05d99b9bc04537bdc709"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}",
                "photometricMatchingMethod": "ANN_L2",
                "geometricEstimator": "acransac",
                "geometricFilterType": "fundamental_matrix",
                "distanceRatio": 0.8,
                "maxIteration": 2048,
                "geometricError": 0.0,
                "knownPosesGeometricErrorMax": 5.0,
                "maxMatches": 0,
                "savePutativeMatches": false,
                "crossMatching": false,
                "guidedMatching": false,
                "matchFromKnownCameraPoses": false,
                "exportDebugFiles": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                800,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 12,
                "split": 1
            },
            "uids": {
                "0": "28ade0886dec3ac34f216fa7b0585227964a21a6"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureMatching_1.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}",
                "localizerEstimator": "acransac",
                "observationConstraint": "Basic",
                "localizerEstimatorMaxIterations": 4096,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "maxNumberOfMatches": 0,
                "minNumberOfMatches": 0,
                "minInputTrackLength": 2,
                "minNumberOfObservationsForTriangulation": 2,
                "minAngleForTriangulation": 3.0,
                "minAngleForLandmark": 2.0,
                "maxReprojectionError": 4.0,
                "minAngleInitialPair": 5.0,
                "maxAngleInitialPair": 40.0,
                "useOnlyMatchesFromInputFolder": false,
                "useRigConstraint": true,
                "lockAllIntrinsics": false,
                "filterTrackForks": false,
                "initialPairA": "",
                "initialPairB": "",
                "interFileExtension": ".abc",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.abc",
                "outputViewsAndPoses": "{cache}/{nodeType}/{uid0}/cameras.sfm",
                "extraInfoFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1000,
                0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 12,
                "split": 1
            },
            "uids": {
                "0": "4bade4068af48d48ddb425a2d035d0987227e9ad"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "imagesFolders": [],
                "outputFileType": "exr",
                "saveMetadata": true,
                "saveMatricesTxtFiles": false,
                "evCorrection": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputUndistorted": "{cache}/{nodeType}/{uid0}/*.{outputFileTypeValue}"
            }
        },
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                1200,
                0
            ],
            "parallelization": {
                "blockSize": 3,
                "size": 12,
                "split": 4
            },
            "uids": {
                "0": "913d4fdb64487acff10d2f9c12b317c817e07f32"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_1.input}",
                "imagesFolder": "{PrepareDenseScene_1.output}",
                "downscale": 16,
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "sgmMaxTCams": 14,
                "sgmWSH": 4,
                "sgmGammaC": 5.5,
                "sgmGammaP": 8.0,
                "refineMaxTCams": 6,
                "refineNSamplesHalf": 150,
                "refineNDepthsToRefine": 31,
                "refineNiters": 100,
                "refineWSH": 3,
                "refineSigma": 15,
                "refineGammaC": 15.5,
                "refineGammaP": 8.0,
                "refineUseTcOrRcPixSize": false,
                "exportIntermediateResults": false,
                "nbGPUs": 0,
                "verboseLevel": "trace"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                1400,
                0
            ],
            "parallelization": {
                "blockSize": 10,
                "size": 12,
                "split": 2
            },
            "uids": {
                "0": "b29561afd7d356bfabfc973310995a9cc3c5180e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMap_1.input}",
                "depthMapsFolder": "{DepthMap_1.output}",
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "nNearestCams": 10,
                "minNumOfConsistentCams": 3,
                "minNumOfConsistentCamsWithLowSimilarity": 4,
                "pixSizeBall": 0,
                "pixSizeBallWithLowSimilarity": 0,
                "computeNormalMaps": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                1600,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "7de74cfec51b4d92b610d6358627f84cf17bd2fd"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapFilter_1.input}",
                "depthMapsFolder": "{DepthMapFilter_1.output}",
                "useBoundingBox": false,
                "boundingBox": {
                    "bboxTranslation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxRotation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxScale": {
                        "x": 1.0,
                        "y": 1.0,
                        "z": 1.0
                    }
                },
                "estimateSpaceFromSfM": true,
                "estimateSpaceMinObservations": 3,
                "estimateSpaceMinObservationAngle": 10,
                "maxInputPoints": 50000000,
                "maxPoints": 5000000,
                "maxPointsPerVoxel": 1000000,
                "minStep": 2,
                "partitioning": "singleBlock",
                "repartition": "multiResolution",
                "angleFactor": 15.0,
                "simFactor": 15.0,
                "pixSizeMarginInitCoef": 2.0,
                "pixSizeMarginFinalCoef": 4.0,
                "voteMarginFactor": 4.0,
                "contributeMarginFactor": 2.0,
                "simGaussianSizeInit": 10.0,
                "simGaussianSize": 10.0,
                "minAngleThreshold": 1.0,
                "refineFuse": true,
                "helperPointsGridSize": 10,
                "densify": false,
                "densifyNbFront": 1,
                "densifyNbBack": 1,
                "densifyScale": 20.0,
                "nPixelSizeBehind": 4.0,
                "fullWeight": 1.0,
                "voteFilteringForWeaklySupportedSurfaces": true,
                "addLandmarksToTheDensePointCloud": false,
                "invertTetrahedronBasedOnNeighborsNbIterations": 10,
                "minSolidAngleRatio": 0.2,
                "nbSolidAngleFilteringIterations": 2,
                "colorizeOutput": false,
                "addMaskHelperPoints": false,
                "maskHelperPointsWeight": 1.0,
                "maskBorderSize": 4,
                "maxNbConnectedHelperPoints": 50,
                "saveRawDensePointCloud": false,
                "exportDebugTetrahedralization": false,
                "seed": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.obj",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                1800,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "7839fa39f4526ff18d60273d67c0b4479bd07ddf"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{Meshing_1.outputMesh}",
                "keepLargestMeshOnly": false,
                "smoothingSubset": "all",
                "smoothingBoundariesNeighbours": 0,
                "smoothingIterations": 5,
                "smoothingLambda": 1.0,
                "filteringSubset": "all",
                "filteringIterations": 1,
                "filterLargeTrianglesFactor": 60.0,
                "filterTrianglesRatio": 0.0,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.obj"
            }
        },
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                2000,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "ece8bd10f2cf705bcf3f255da87eb2a69d4f7636"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_1.output}",
                "imagesFolder": "{DepthMap_1.imagesFolder}",
                "inputMesh": "{MeshFiltering_1.outputMesh}",
                "textureSide": 8192,
                "downscale": 2,
                "outputTextureFileType": "png",
                "unwrapMethod": "Basic",
                "useUDIM": true,
                "fillHoles": false,
                "padding": 5,
                "multiBandDownscale": 4,
                "multiBandNbContrib": {
                    "high": 1,
                    "midHigh": 5,
                    "midLow": 10,
                    "low": 0
                },
                "useScore": true,
                "bestScoreThreshold": 0.1,
                "angleHardThreshold": 90.0,
                "processColorspace": "sRGB",
                "correctEV": false,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.obj",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.{outputTextureFileTypeValue}"
            }
        }
    }
}