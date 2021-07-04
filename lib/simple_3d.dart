library simple_3d;

import 'dart:typed_data';
import 'dart:ui';

///
/// Sp3dObjのFlutter実装です。
/// opt属性は辞書であり、アプリケーション毎に自由に拡張できます。
/// 書きだす場合はto_dictしたものをjson化します。読み込む場合はfrom_dict呼び出しで簡単に復元できます。
///
/// Author Masahide Mori
/// Version 1.00
/// First edition creation date 2021-06-30 22:54:22
///
///
class Sp3dObj {

  final String class_name = 'Sp3dObj';
  final String version = '1';
  // Object ID
  String? id;
  // Object Name
  String? name;
  // Object fragment
  List<Sp3dFragment> fragments;
  // Information such as object color
  List<Sp3dMaterial> materials;
  // PNG Image data
  List<Uint8List> images;
  // Option parameters.
  Map<String, dynamic>? option;

  /// Constructor
  Sp3dObj(this.id, this.name, this.fragments, this.materials, this.images, this.option);

  Sp3dObj deep_copy(){
    List<Sp3dFragment> frgs = [];
    for(var i in this.fragments){
      frgs.add(i.deep_copy());
    }
    List<Sp3dMaterial> mtrs = [];
    for(var i in this.materials){
      mtrs.add(i.deep_copy());
    }
    List<Uint8List> imgs = [];
    for(Uint8List i in this.images){
      List<int> il = [];
      for(var j in i){
        il.add(j);
      }
      imgs.add(Uint8List.fromList(il));
    }
    if(this.option!=null) {
      return Sp3dObj(this.id, this.name, frgs, mtrs, imgs, {...this.option!});
    }else{
      return Sp3dObj(this.id, this.name, frgs, mtrs, imgs, null);
    }
  }

  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['id'] = this.id;
    d['name'] = this.name;
    List<Map<String,dynamic>> frgs = [];
    for(var i in this.fragments){
      frgs.add(i.to_dict());
    }
    d['fragments'] = frgs;
    List<Map<String,dynamic>> mtrs = [];
    for(var i in this.materials){
      mtrs.add(i.to_dict());
    }
    d['materials'] = mtrs;
    List<List<int>> imgs = [];
    for(Uint8List i in this.images){
      List<int> il = [];
      for(var j in i){
        il.add(j);
      }
      imgs.add(il);
    }
    d['images'] = imgs;
    d['option'] = this.option;
    return d;
  }

  static Sp3dObj from_dict(src){
    List<Sp3dFragment> frgs = [];
    for(var i in src['fragments']){
      frgs.add(Sp3dFragment.from_dict(i));
    }
    List<Sp3dMaterial> mtrs = [];
    for(var i in src['materials']){
      mtrs.add(Sp3dMaterial.from_dict(i));
    }
    List<Uint8List> imgs = [];
    for(List<int> i in src['images']){
      imgs.add(Uint8List.fromList([...i]));
    }
    return Sp3dObj(src['id'], src['name'], frgs, mtrs, imgs, src['option']);
  }

}


///
/// Sp3dFragmentのflutter実装です。
/// Sp3dFragmentはsimple3dObj内で使用される、部品情報を扱うクラスです。
///
/// Author Masahide Mori
/// Version 1.00
/// First edition creation date 2021-06-30 23:21:09
///
class Sp3dFragment {

  final String class_name = 'Sp3dFragment';
  final String version = '1';
  // If true, this is particle.
  bool is_particle;
  // Face obj.
  List<Sp3dFace> faces;
  // Particle radius.
  double r;
  // Option parameters.
  Map<String, dynamic>? option;

  /// Constructor
  Sp3dFragment(this.is_particle, this.faces, this.r, this.option);

  Sp3dFragment deep_copy(){
    List<Sp3dFace> f = [];
    for(var i in this.faces){
      f.add(i.deep_copy());
    }
    if(this.option!=null) {
      return Sp3dFragment(this.is_particle, f, this.r, {...this.option!});
    }else{
      return Sp3dFragment(this.is_particle, f, this.r, null);
    }
  }

  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['is_particle'] = this.is_particle;
    List<Map<String,dynamic>> f = [];
    for(var i in this.faces){
      f.add(i.to_dict());
    }
    d['faces'] = f;
    d['r'] = this.r;
    d['option'] = this.option;
    return d;
  }

  static Sp3dFragment from_dict(src){
    List<Sp3dFace> f = [];
    for(var i in src['faces']){
      f.add(Sp3dFace.from_dict(i));
    }
    return Sp3dFragment(src['is_particle'], f, src['r'], src['option']);
  }

}

///
/// Sp3dFaceのflutter実装です。
/// Sp3dFaceはSp3dFragment内で使用される、頂点などの情報を扱うクラスです。
///
/// Author Masahide Mori
/// Version 1.00
/// First edition creation date 2021-06-30 23:39:49
///
class Sp3dFace {

  final String class_name = 'Sp3dFace';
  final String version = '1';
  // 3d vertex.
  List<Sp3dV3D> vertex;
  // use material index. If null, disable.
  int? material_index;

  /// Constructor
  Sp3dFace(this.vertex, this.material_index);

  Sp3dFace deep_copy(){
    List<Sp3dV3D> v = [];
    for(var i in this.vertex){
      v.add(i.deep_copy());
    }
    return Sp3dFace(v, this.material_index);
  }

  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    List<Map<String,dynamic>> v = [];
    for(var i in this.vertex){
      v.add(i.to_dict());
    }
    d['vertex'] = v;
    d['material_index'] = this.material_index;
    return d;
  }

  static Sp3dFace from_dict(src){
    List<Sp3dV3D> v = [];
    for(var i in src['vertex']){
      v.add(Sp3dV3D.from_dict(i));
    }
    return Sp3dFace(v, src['material_index']);
  }

}

///
/// ３次元ベクトルを扱うためのクラスです。
///
/// Author Masahide Mori
/// Version 1.00
/// First edition creation date 2021-05-23 18:38:57
///
class Sp3dV3D {

  final String class_name = 'Sp3dV3D';
  final String version = '1';
  final double x;
  final double y;
  final double z;

  /// 通常のコンストラクタ
  Sp3dV3D(this.x, this.y, this.z);

  Sp3dV3D deep_copy(){
    return Sp3dV3D(this.x, this.y, this.z);
  }

  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['x'] = this.x;
    d['y'] = this.y;
    d['z'] = this.z;
    return d;
  }

  static Sp3dV3D from_dict(src){
    return Sp3dV3D(src['x'],src['y'],src['z']);
  }

}

///
/// Sp3dMaterialのflutter実装です。
/// Sp3dMaterialはSp3dObj内で使用される、色などの情報を扱うクラスです。
///
/// Author Masahide Mori
/// Version 1.00
/// First edition creation date 2021-06-30 23:30:52
///
class Sp3dMaterial {

  final String class_name = 'Sp3dMaterial';
  final String version = '1';
  // bg Color
  Color bg;
  //
  bool is_fill;
  // double
  double stroke_width;
  //
  Color stroke_color;
  // Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the clockwise order as the vertices from the upper left.
  int? image_index;
  // Option parameters.
  Map<String, dynamic>? option;

  /// Constructor
  Sp3dMaterial(this.bg, this.is_fill, this.stroke_width, this.stroke_color, this.image_index, this.option);

  Sp3dMaterial deep_copy(){
    var mbg = Color.fromARGB(this.bg.alpha, this.bg.red, this.bg.green, this.bg.blue);
    var msc = Color.fromARGB(this.stroke_color.alpha, this.stroke_color.red, this.stroke_color.green, this.stroke_color.blue);
    if(this.option!=null) {
      return Sp3dMaterial(
          mbg, this.is_fill, this.stroke_width, msc, this.image_index,
          {...this.option!});
    }
    else{
      return Sp3dMaterial(
          mbg, this.is_fill, this.stroke_width, msc, this.image_index,
          null);
    }
  }

  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['bg'] = [this.bg.alpha,this.bg.red,this.bg.green,this.bg.blue];
    d['is_fill'] = this.is_fill;
    d['stroke_width'] = this.stroke_width;
    d['stroke_color'] = [this.stroke_color.alpha,this.stroke_color.red,this.stroke_color.green,this.stroke_color.blue];
    d['image_index'] = this.image_index;
    d['option'] = this.option;
    return d;
  }

  static Sp3dMaterial from_dict(src){
    var mbg = Color.fromARGB(src['bg'][0], src['bg'][1], src['bg'][2], src['bg'][3]);
    var msc = Color.fromARGB(src['stroke_color'][0], src['stroke_color'][1], src['stroke_color'][2], src['stroke_color'][3]);
    return Sp3dMaterial(mbg, src['is_fill'], src['stroke_width'], msc, src['image_index'], src['option']);
  }

}