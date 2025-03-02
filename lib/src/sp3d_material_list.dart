import 'package:simple_3d/simple_3d.dart';

///
/// (en) A class for efficiently saving and restoring materials.
/// This class is for internal use only.
///
/// (ja) マテリアルを効率よく保存・復元するためのクラスです。
/// このクラスは内部の処理のみで利用されます。
///
/// Author Masahide Mori
///
/// First edition creation date 2024-11-26 21:01:05
///
class Sp3dMaterialList {
  static const String className = 'Sp3dMaterialList';
  static const String version = '2';

  List<Sp3dMaterial> materials;

  Sp3dMaterialList(this.materials);

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    List<Map<String, dynamic>> mtrs = [];
    for (var i in materials) {
      mtrs.add(i.toDict(version: int.parse(version)));
    }
    d['className'] = className;
    d['version'] = version;
    d['material'] = mtrs;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dMaterialList fromDict(Map<String, dynamic> src) {
    List<Sp3dMaterial> mtrs = [];
    for (var i in src['materials']['material']) {
      mtrs.add(Sp3dMaterial.fromDict(i, int.parse(src["version"])));
    }
    return Sp3dMaterialList(mtrs);
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  List<Map<String, dynamic>> toDictV14() {
    List<Map<String, dynamic>> v = [];
    for (var i in materials) {
      v.add(i.toDictV14());
    }
    return v;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dMaterialList fromDictV14(Map<String, dynamic> src) {
    List<Sp3dMaterial> mtrs = [];
    for (var i in src['materials']) {
      mtrs.add(Sp3dMaterial.fromDictV14(i));
    }
    return Sp3dMaterialList(mtrs);
  }
}
