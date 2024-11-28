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
  static const String className = 'Sp3dPhysics';
  static const String version = '5';
  bool isLocked;
  double? mass;
  double? speed;
  Sp3dV3D? direction;
  Sp3dV3D? velocity;
  Sp3dV3D? rotateAxis;
  double? angularVelocity;
  double? angle;
  String? name;
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
  /// * [name] : Name of the action.
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
      this.name,
      this.others});

  /// Deep copy the object.
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
        name: name,
        others: others != null ? {...others!} : null);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['className'] = className;
    d['version'] = version;
    d['isLocked'] = isLocked;
    d['mass'] = mass;
    d['speed'] = speed;
    d['direction'] = direction?.toDict();
    d['velocity'] = velocity?.toDict();
    d['rotateAxis'] = rotateAxis?.toDict();
    d['angularVelocity'] = angularVelocity;
    d['angle'] = angle;
    d['name'] = name;
    d['others'] = others;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dPhysics fromDict(Map<String, dynamic> src) {
    return Sp3dPhysics(
        isLocked: src['isLocked'],
        mass: src['mass'],
        speed: src['speed'],
        direction: src['direction'] != null
            ? Sp3dV3D.fromDict(src['direction'])
            : null,
        velocity:
            src['velocity'] != null ? Sp3dV3D.fromDict(src['velocity']) : null,
        rotateAxis: src['rotateAxis'] != null
            ? Sp3dV3D.fromDict(src['rotateAxis'])
            : null,
        angularVelocity: src['angularVelocity'],
        angle: src['angle'],
        name: src['name'],
        others: src['others']);
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  Map<String, dynamic> toDictV14() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = "4";
    d['is_locked'] = isLocked;
    d['mass'] = mass;
    d['speed'] = speed;
    d['direction'] = direction?.toDictV14();
    d['velocity'] = velocity?.toDictV14();
    d['rotate_axis'] = rotateAxis?.toDictV14();
    d['angular_velocity'] = angularVelocity;
    d['angle'] = angle;
    d['name'] = name;
    d['others'] = others;
    return d;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dPhysics fromDictV14(Map<String, dynamic> src) {
    // after version 4
    String? mName;
    if (src.containsKey('name')) {
      mName = src['name'];
    }
    return Sp3dPhysics(
        isLocked: src['is_locked'],
        mass: src['mass'],
        speed: src['speed'],
        direction: src['direction'] != null
            ? Sp3dV3D.fromDictV14(src['direction'])
            : null,
        velocity: src['velocity'] != null
            ? Sp3dV3D.fromDictV14(src['velocity'])
            : null,
        rotateAxis: src['rotate_axis'] != null
            ? Sp3dV3D.fromDictV14(src['rotate_axis'])
            : null,
        angularVelocity: src['angular_velocity'],
        angle: src['angle'],
        name: mName,
        others: src['others']);
  }
}
