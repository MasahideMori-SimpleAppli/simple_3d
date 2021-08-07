library simple_3d;

import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';

///
/// (en) Flutter implementation of Sp3dObj.
/// The options for this object and internal elements can be freely extended for each application.
/// When writing out, to_dict is converted to json. If you want to read it, you can easily restore it by calling from_dict.
///
/// (ja) Sp3dObjのFlutter実装です。
/// このオブジェクト及び内部要素のoptionはアプリケーション毎に自由に拡張できます。
/// 書きだす場合はto_dictしたものをjson化します。読み込む場合はfrom_dict呼び出しで簡単に復元できます。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-06-30 22:54:22
///
///
class Sp3dObj {

  final String class_name = 'Sp3dObj';
  final String version = '2';
  String? id;
  String? name;
  List<Sp3dV3D> vertices;
  List<Sp3dFragment> fragments;
  List<Sp3dMaterial> materials;
  List<Uint8List> images;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [id] : Object ID.
  /// * [name] : Object Name.
  /// * [vertices] : vertex list.
  /// * [fragments] : This includes information such as the vertex information of the object.
  /// * [materials] : This includes information such as colors.
  /// * [images] : Image data.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dObj(this.id, this.name, this.vertices, this.fragments, this.materials, this.images, this.option);

  /// Deep copy the object.
  Sp3dObj deep_copy(){
    List<Sp3dV3D> v = [];
    for(var i in this.vertices){
      v.add(i.deep_copy());
    }
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
      return Sp3dObj(this.id, this.name, v, frgs, mtrs, imgs, {...this.option!});
    }else{
      return Sp3dObj(this.id, this.name, v, frgs, mtrs, imgs, null);
    }
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['id'] = this.id;
    d['name'] = this.name;
    List<Map<String,dynamic>> v = [];
    for(var i in this.vertices){
      v.add(i.to_dict());
    }
    d['vertices'] = v;
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

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dObj from_dict(Map<String, dynamic> src){
    List<Sp3dV3D> v = [];
    for(var i in src['vertices']){
      v.add(Sp3dV3D.from_dict(i));
    }
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
    return Sp3dObj(src['id'], src['name'], v, frgs, mtrs, imgs, src['option']);
  }

}


///
/// (en) A flutter implementation of Sp3dFragment.
/// Sp3dFragment is a class that handles part information used in simple3dObj.
///
/// (ja) Sp3dFragmentのflutter実装です。
/// Sp3dFragmentはsimple3dObj内で使用される、部品情報を扱うクラスです。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-06-30 23:21:09
///
class Sp3dFragment {

  final String class_name = 'Sp3dFragment';
  final String version = '1';
  bool is_particle;
  List<Sp3dFace> faces;
  double r;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [is_particle] : If true, this is particle.
  /// * [faces] : Face Object list. This includes vertex information.
  /// * [r] : Particle radius.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dFragment(this.is_particle, this.faces, this.r, this.option);

  /// Deep copy the object.
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

  /// Convert the object to a dictionary.
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

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dFragment from_dict(Map<String, dynamic> src){
    List<Sp3dFace> f = [];
    for(var i in src['faces']){
      f.add(Sp3dFace.from_dict(i));
    }
    return Sp3dFragment(src['is_particle'], f, src['r'], src['option']);
  }

}

///
/// (en) A flutter implementation of Sp3dFace.
/// Sp3dFace is a class used in Sp3dFragment that handles information such as vertices.
///
/// (ja) Sp3dFaceのflutter実装です。
/// Sp3dFaceはSp3dFragment内で使用される、頂点などの情報を扱うクラスです。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-06-30 23:39:49
///
class Sp3dFace {

  final String class_name = 'Sp3dFace';
  final String version = '2';
  List<int> vertex_index_list;
  int? material_index;

  /// Constructor
  /// * [vertex_index_list] : 3D vertex index list.
  /// * [material_index] : use material index. If null, disable.
  Sp3dFace(this.vertex_index_list, this.material_index);

  /// Deep copy the object.
  Sp3dFace deep_copy(){
    return Sp3dFace([...vertex_index_list], this.material_index);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['vertex_index_list'] = this.vertex_index_list;
    d['material_index'] = this.material_index;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dFace from_dict(Map<String, dynamic> src){
    return Sp3dFace(src['vertex_index_list'], src['material_index']);
  }

}

///
/// (en) This is a class for handling 3D vectors.
///
/// (ja) ３次元ベクトルを扱うためのクラスです。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-05-23 18:38:57
///
class Sp3dV3D {

  final String class_name = 'Sp3dV3D';
  final String version = '3';
  double x;
  double y;
  double z;

  /// Constructor
  /// * [x] : The x coordinate of the 3D vertex.
  /// * [y] : The x coordinate of the 3D vertex.
  /// * [z] : The x coordinate of the 3D vertex.
  Sp3dV3D(this.x, this.y, this.z);

  /// Deep copy the object.
  Sp3dV3D deep_copy(){
    return Sp3dV3D(this.x, this.y, this.z);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['x'] = this.x;
    d['y'] = this.y;
    d['z'] = this.z;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dV3D from_dict(Map<String, dynamic> src){
    return Sp3dV3D(src['x'],src['y'],src['z']);
  }

  Sp3dV3D operator +(Sp3dV3D v) {
    return Sp3dV3D(this.x+v.x,this.y+v.y,this.z+v.z);
  }

  Sp3dV3D operator -(Sp3dV3D v) {
    return Sp3dV3D(this.x-v.x,this.y-v.y,this.z-v.z);
  }

  Sp3dV3D operator *(double scalar) {
    return Sp3dV3D(this.x*scalar,this.y*scalar,this.z*scalar);
  }

  Sp3dV3D operator /(double scalar) {
    return Sp3dV3D(this.x/scalar,this.y/scalar,this.z/scalar);
  }

  /// Return vector length.
  double len(){
    return sqrt(this.x*this.x+this.y*this.y+this.z*this.z);
  }

  /// Return Normalized Vector.
  Sp3dV3D norm(){
    double length = this.len();
    if(length==0){
      return this.deep_copy();
    }
    else{
      return this/length;
    }
  }

  @override
  String toString(){
    return '['+this.x.toString()+','+this.y.toString()+','+this.z.toString()+']';
  }

}

///
/// (en) Flutter implementation of Sp3dMaterial.
/// Sp3dMaterial is a class used in Sp3dObj that handles information such as colors.
///
/// (ja) Sp3dMaterialのflutter実装です。
/// Sp3dMaterialはSp3dObj内で使用される、色などの情報を扱うクラスです。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-06-30 23:30:52
///
class Sp3dMaterial {

  final String class_name = 'Sp3dMaterial';
  final String version = '1';
  Color bg;
  bool is_fill;
  double stroke_width;
  Color stroke_color;
  int? image_index;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [bg] : Background color
  /// * [is_fill] : If true, fill by bg color.
  /// * [stroke_width] : Stroke width.
  /// * [stroke_color] : Stroke color.
  /// * [image_index] : Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the clockwise order as the vertices from the upper left.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dMaterial(this.bg, this.is_fill, this.stroke_width, this.stroke_color, this.image_index, this.option);

  /// Convert the object to a dictionary.
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

  /// Convert the object to a dictionary.
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

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dMaterial from_dict(Map<String, dynamic> src){
    var mbg = Color.fromARGB(src['bg'][0], src['bg'][1], src['bg'][2], src['bg'][3]);
    var msc = Color.fromARGB(src['stroke_color'][0], src['stroke_color'][1], src['stroke_color'][2], src['stroke_color'][3]);
    return Sp3dMaterial(mbg, src['is_fill'], src['stroke_width'], msc, src['image_index'], src['option']);
  }

}