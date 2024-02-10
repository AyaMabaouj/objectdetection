import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:detectionobject/models.dart';
import 'package:detectionobject/bndbox.dart';
import 'package:detectionobject/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

void main() {
  runApp(SafeDrive());
}

class SafeDrive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SafeDrive'),
        ),
        body: SafeDriveBody(),
      ),
    );
  }
}

class SafeDriveBody extends StatefulWidget {
  @override
  _SafeDriveBodyState createState() => _SafeDriveBodyState();
}

class _SafeDriveBodyState extends State<SafeDriveBody> {
  late List<CameraDescription> cameras;
  String model = ssd;
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        await loadModel(); // Charger le modèle lorsque les caméras sont disponibles
      }
    } on CameraException catch (e) {
      print('Erreur: $e.code\nMessage d\'erreur: $e.message');
    } finally {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  void setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  Future<void> loadModel() async {
    String? res;
    res = await Tflite.loadModel(
      model: "assets/ssd_mobilenet.tflite",
      labels: "assets/ssd_mobilenet.txt",
    );
    print("$res");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isCameraInitialized ? _buildCameraView() : _buildLoadingIndicator(),
    );
  }

 Widget _buildCameraView() {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 400,
          height: 500,
          alignment: Alignment.center,
          child: Stack(
            children: [
              _buildCameraWidget(), // Afficher la caméra
              if (_recognitions != null && _recognitions!.isNotEmpty)
                BndBox(
                  _recognitions!,
                  _imageHeight,
                  _imageWidth,
                  500,
                  400,
                  model,
                ),
            ],
          ),
        ),
        SizedBox(height: 20),
       Container(
  color: Colors.white, // Arrière-plan blanc
  padding: EdgeInsets.symmetric(vertical: 10), // Espacement vertical
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        child: Column(
          children: [
            Icon(Icons.speed, size: 40),
            SizedBox(height: 5),
            Text('Vitesse'),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            Icon(Icons.directions_car, size: 40),
            SizedBox(height: 5),
            Text('Distance'),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            Icon(Icons.warning, size: 40),
            SizedBox(height: 5),
            Text('Obstacles'),
          ],
        ),
      ),
    ],
  ),
)

      ],
    ),
  );
}



  Widget _buildCameraWidget() {
    return Camera(cameras, model, setRecognitions);
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator();
  }
}
