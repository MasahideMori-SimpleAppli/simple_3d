import 'package:simple_3d/simple_3d.dart';

///
/// (en) A class for efficiently saving and restoring fragments.
/// This class is for internal use only.
///
/// (ja) フラグメントを効率よく保存・復元するためのクラスです。
/// このクラスは内部の処理のみで利用されます。
///
/// Author Masahide Mori
///
/// First edition creation date 2024-11-27 20:24:20
///
class Sp3dFragmentList {
  static const String className = 'Sp3dFragmentList';
  static const String version = '1';

  List<Sp3dFragment> fragments;

  Sp3dFragmentList(this.fragments);

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    List<Map<String, dynamic>> frgs = [];
    for (var i in fragments) {
      frgs.add(i.toDict());
    }
    d['className'] = className;
    d['version'] = version;
    d['fragment'] = frgs;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFragmentList fromDict(Map<String, dynamic> src) {
    List<Sp3dFragment> frgs = [];
    for (var i in src['fragments']['fragment']) {
      frgs.add(Sp3dFragment.fromDict(i));
    }
    return Sp3dFragmentList(frgs);
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  List<Map<String, dynamic>> toDictV14() {
    List<Map<String, dynamic>> frgs = [];
    for (var i in fragments) {
      frgs.add(i.toDictV14());
    }
    return frgs;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFragmentList fromDictV14(Map<String, dynamic> src) {
    List<Sp3dFragment> frgs = [];
    for (var i in src['fragments']) {
      frgs.add(Sp3dFragment.fromDictV14(i));
    }
    return Sp3dFragmentList(frgs);
  }
}
