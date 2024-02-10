import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';


class SensorUtils {
  static StreamSubscription<UserAccelerometerEvent>? userAccelerometerSubscription;
  static StreamSubscription<AccelerometerEvent>? accelerometerSubscription;
  static StreamSubscription<GyroscopeEvent>? gyroscopeSubscription;
  static StreamSubscription<MagnetometerEvent>? magnetometerSubscription;

  static void startListeningToSensors() {
    userAccelerometerSubscription = userAccelerometerEventStream().listen((event) {
      // Traitez les événements ici
    });

    accelerometerSubscription = accelerometerEventStream().listen((event) {
      // Traitez les événements ici
    });

    gyroscopeSubscription = gyroscopeEventStream().listen((event) {
      // Traitez les événements ici
    });

    magnetometerSubscription = magnetometerEventStream().listen((event) {
      // Traitez les événements ici
    });
  }

  static void stopListeningToSensors() {
    userAccelerometerSubscription?.cancel();
    accelerometerSubscription?.cancel();
    gyroscopeSubscription?.cancel();
    magnetometerSubscription?.cancel();
  }
}
