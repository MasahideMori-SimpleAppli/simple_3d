import 'sp3d_v3d.dart';

///
/// (en)A class for managing parameters for physics operations.
/// (ja)物理演算のためのパラメータを管理するためのクラスです。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-11-27 17:17:38
///
class Sp3dPhysics {
  final String className = 'Sp3dPhysics';
  final String version = '2';
  bool isLocked;
  double? mass;
  double? speed;
  Sp3dV3D? direction;
  Sp3dV3D? velocity;
  Sp3dV3D? rotateAxis;
  double? angularVelocity;
  double? angle;
  Map<String, dynamic>? others;

  /// Constructor
  /// * [isLocked] : If true, Treat it as a fixed object.
  /// * [mass] : The mass(kg) of the object.
  /// * [speed] : The speed(m/s) of the object. Retained primarily for calculations.
  /// * [direction] : The direction(Unit vector) of the object. Retained primarily for calculations.
  /// * [velocity] : The velocity of the object. Used for moving objects.
  /// * [rotateAxis] : The rotate axis of the object.
  /// * [angularVelocity] : The angular velocity of the object.
  /// * [angle] : The rotated angle of the object.
  /// * [others] : Optional attributes that may be added for each app.
  Sp3dPhysics(
      {this.isLocked = false,
      this.mass,
      this.speed,
      this.direction,
      this.velocity,
      this.rotateAxis,
      this.angularVelocity,
      this.angle,
      this.others});

  Sp3dPhysics deepCopy() {
    return Sp3dPhysics(
        isLocked: isLocked,
        mass: mass,
        speed: speed,
        direction: direction?.deepCopy(),
        velocity: velocity?.deepCopy(),
        rotateAxis: rotateAxis?.deepCopy(),
        angularVelocity: angularVelocity,
        angle: angle,
        others: others != null ? {...others!} : null);
  }

  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    d['is_locked'] = isLocked;
    d['mass'] = mass;
    d['speed'] = speed;
    d['direction'] = direction?.toDict();
    d['velocity'] = velocity?.toDict();
    d['rotate_axis'] = rotateAxis?.toDict();
    d['angular_velocity'] = angularVelocity;
    d['angle'] = angle;
    d['others'] = others;
    return d;
  }

  static Sp3dPhysics fromDict(Map<String, dynamic> src) {
    return Sp3dPhysics(
        isLocked: src['is_locked'],
        mass: src['mass'],
        speed: src['speed'],
        direction: src['direction'] != null
            ? Sp3dV3D.fromDict(src['direction'])
            : null,
        velocity:
            src['velocity'] != null ? Sp3dV3D.fromDict(src['velocity']) : null,
        rotateAxis: src['rotate_axis'] != null
            ? Sp3dV3D.fromDict(src['rotate_axis'])
            : null,
        angularVelocity: src['angular_velocity'],
        angle: src['angle'],
        others: src['others']);
  }
}
