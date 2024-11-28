import 'package:simple_3d/simple_3d.dart';

///
/// (en) A class for efficiently saving and restoring faces.
/// This class is for internal use only.
///
/// (ja) 面を効率よく保存・復元するためのクラスです。
/// このクラスは内部の処理のみで利用されます。
///
/// Author Masahide Mori
///
/// First edition creation date 2024-11-27 20:36:33
///
class Sp3dFaceList {
  static const String className = 'Sp3dFaceList';
  static const String version = '1';

  List<Sp3dFace> faces;

  Sp3dFaceList(this.faces);

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    List<Map<String, dynamic>> f = [];
    for (var i in faces) {
      f.add(i.toDict());
    }
    d['className'] = className;
    d['version'] = version;
    d['face'] = f;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFaceList fromDict(Map<String, dynamic> src) {
    List<Sp3dFace> f = [];
    for (var i in src['faces']['face']) {
      f.add(Sp3dFace.fromDict(i));
    }
    return Sp3dFaceList(f);
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  List<Map<String, dynamic>> toDictV14() {
    List<Map<String, dynamic>> f = [];
    for (var i in faces) {
      f.add(i.toDictV14());
    }
    return f;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFaceList fromDictV14(Map<String, dynamic> src) {
    List<Sp3dFace> f = [];
    for (var i in src['faces']) {
      f.add(Sp3dFace.fromDictV14(i));
    }
    return Sp3dFaceList(f);
  }
}
