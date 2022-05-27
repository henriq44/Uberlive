import 'dart:developer';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:uberapp/check_permission.dart';
part 'controller.g.dart';

class ControllerStore = _ControllerStoreBase with _$ControllerStore;

abstract class _ControllerStoreBase with Store {
  final userPosition = CheckPermission();

  @observable
  bool isDeniedForever = false;

  @observable
  Position? currentPosition;

  void setIsDeniedForever(bool value) => isDeniedForever = value;

  void setCurrentPosition(Position value) => currentPosition = value;

  @action
  Future<void> getPosition() async {
    try {
      final result = await userPosition.getPosition();
      log(result.toString());

      setCurrentPosition(result);

      setIsDeniedForever(false);
    } catch (e) {
      log(e.toString());
      if (e.toString() == 'DENIED_FOREVER') {
        setIsDeniedForever(true);
      }
    }
  }
}
