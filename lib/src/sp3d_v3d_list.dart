import 'package:simple_3d/simple_3d.dart';

///
/// (en) A class for efficiently saving and restoring 3D vectors.
/// This class is for internal use only.
///
/// (ja) ３次元ベクトルを効率よく保存・復元するためのクラスです。
/// このクラスは内部の処理のみで利用されます。
///
/// Author Masahide Mori
///
/// First edition creation date 2024-11-26 18:29:20
///
class Sp3dV3DList {
  static const String className = 'Sp3dV3DList';
  static const String version = '1';

  List<Sp3dV3D> vertices;

  Sp3dV3DList(this.vertices);

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    List<Map<String, dynamic>> v = [];
    for (Sp3dV3D i in vertices) {
      v.add(i.toDict());
    }
    d['className'] = className;
    d['version'] = version;
    d['v'] = v;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dV3DList fromDict(Map<String, dynamic> src) {
    List<Sp3dV3D> v = [];
    for (var i in src['vertices']['v']) {
      v.add(Sp3dV3D.fromDict(i));
    }
    return Sp3dV3DList(v);
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  List<Map<String, dynamic>> toDictV14() {
    List<Map<String, dynamic>> v = [];
    for (var i in vertices) {
      v.add(i.toDictV14());
    }
    return v;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dV3DList fromDictV14(Map<String, dynamic> src) {
    List<Sp3dV3D> v = [];
    for (var i in src['vertices']) {
      v.add(Sp3dV3D.fromDictV14(i));
    }
    return Sp3dV3DList(v);
  }
}
