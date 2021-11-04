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
  final String version = '4';
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
  Sp3dObj(this.id, this.name, this.vertices, this.fragments, this.materials,
      this.images, this.option);

  /// Deep copy the object.
  Sp3dObj deep_copy() {
    List<Sp3dV3D> v = [];
    for (var i in this.vertices) {
      v.add(i.deep_copy());
    }
    List<Sp3dFragment> frgs = [];
    for (var i in this.fragments) {
      frgs.add(i.deep_copy());
    }
    List<Sp3dMaterial> mtrs = [];
    for (var i in this.materials) {
      mtrs.add(i.deep_copy());
    }
    List<Uint8List> imgs = [];
    for (Uint8List i in this.images) {
      List<int> il = [];
      for (var j in i) {
        il.add(j);
      }
      imgs.add(Uint8List.fromList(il));
    }
    if (this.option != null) {
      return Sp3dObj(
          this.id, this.name, v, frgs, mtrs, imgs, {...this.option!});
    } else {
      return Sp3dObj(this.id, this.name, v, frgs, mtrs, imgs, null);
    }
  }

  /// (en)Adds the specified vector to all vectors of this object.
  ///
  /// (ja)このオブジェクトの全てのベクトルに指定したベクトルを加算します。
  Sp3dObj move(Sp3dV3D v) {
    for (Sp3dV3D i in this.vertices) {
      i.add(v);
    }
    return this;
  }

  /// (en)Rotates all vectors of this object based on the specified axis.
  ///
  /// (ja)このオブジェクトの全てのベクトルを指定した軸をベースに回転させます。
  ///
  /// * [nor_axis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dObj rotate(Sp3dV3D nor_axis, double radian) {
    for (Sp3dV3D i in this.vertices) {
      i.rotate(nor_axis, radian);
    }
    return this;
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict() {
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['id'] = this.id;
    d['name'] = this.name;
    List<Map<String, dynamic>> v = [];
    for (var i in this.vertices) {
      v.add(i.to_dict());
    }
    d['vertices'] = v;
    List<Map<String, dynamic>> frgs = [];
    for (var i in this.fragments) {
      frgs.add(i.to_dict());
    }
    d['fragments'] = frgs;
    List<Map<String, dynamic>> mtrs = [];
    for (var i in this.materials) {
      mtrs.add(i.to_dict());
    }
    d['materials'] = mtrs;
    List<List<int>> imgs = [];
    for (Uint8List i in this.images) {
      List<int> il = [];
      for (var j in i) {
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
  static Sp3dObj from_dict(Map<String, dynamic> src) {
    List<Sp3dV3D> v = [];
    for (var i in src['vertices']) {
      v.add(Sp3dV3D.from_dict(i));
    }
    List<Sp3dFragment> frgs = [];
    for (var i in src['fragments']) {
      frgs.add(Sp3dFragment.from_dict(i));
    }
    List<Sp3dMaterial> mtrs = [];
    for (var i in src['materials']) {
      mtrs.add(Sp3dMaterial.from_dict(i));
    }
    List<Uint8List> imgs = [];
    for (List<int> i in src['images']) {
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
  Sp3dFragment deep_copy() {
    List<Sp3dFace> f = [];
    for (var i in this.faces) {
      f.add(i.deep_copy());
    }
    if (this.option != null) {
      return Sp3dFragment(this.is_particle, f, this.r, {...this.option!});
    } else {
      return Sp3dFragment(this.is_particle, f, this.r, null);
    }
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict() {
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['is_particle'] = this.is_particle;
    List<Map<String, dynamic>> f = [];
    for (var i in this.faces) {
      f.add(i.to_dict());
    }
    d['faces'] = f;
    d['r'] = this.r;
    d['option'] = this.option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dFragment from_dict(Map<String, dynamic> src) {
    List<Sp3dFace> f = [];
    for (var i in src['faces']) {
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
  final String version = '5';
  List<int> vertex_index_list;
  int? material_index;

  /// Constructor
  /// * [vertex_index_list] : 3D vertex index list.
  /// * [material_index] : use material index. If null, disable.
  Sp3dFace(this.vertex_index_list, this.material_index);

  /// Deep copy the object.
  Sp3dFace deep_copy() {
    return Sp3dFace([...vertex_index_list], this.material_index);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict() {
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['vertex_index_list'] = this.vertex_index_list;
    d['material_index'] = this.material_index;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dFace from_dict(Map<String, dynamic> src) {
    return Sp3dFace(src['vertex_index_list'], src['material_index']);
  }

  /// (en)Gets the vertices of this face.
  ///
  /// (ja)この面の頂点を取得します。
  /// * [obj] : The object to which this face belongs.
  List<Sp3dV3D> get_vertices(Sp3dObj obj) {
    List<Sp3dV3D> r = [];
    for (int i in this.vertex_index_list) {
      r.add(obj.vertices[i]);
    }
    return r;
  }

  /// (en)Reverse the orientation of this face.
  /// Internally, the order of the referenced indexes is reversed.
  ///
  /// (ja)この面の向きを反転します。
  /// 内部的には、参照しているインデックスの順序が反転します。
  void reverse() {
    if (this.vertex_index_list.length > 2) {
      this.vertex_index_list = this.vertex_index_list.reversed.toList();
    }
  }

  /// (en)Returns a new face with the orientation of this face reversed.
  /// Internally, the order of the referenced indexes is reversed.
  ///
  /// (ja)この面の向きを反転した新しい面を返します。
  /// 内部的には、参照しているインデックスの順序が反転します。
  Sp3dFace reversed() {
    Sp3dFace r = this.deep_copy();
    r.reverse();
    return r;
  }

  /// (en)Reverse the orientation of this face.
  /// Internally, the order of 3D vectors except the beginning is reversed.
  ///
  /// (ja)この面の向きを反転します。内部では先頭を除く3Dベクトルの順番が反転します。
  void reverse_ft() {
    if (this.vertex_index_list.length > 2) {
      List<int> nl = [];
      nl.add(this.vertex_index_list.removeAt(0));
      nl.addAll(this.vertex_index_list.reversed);
      this.vertex_index_list = nl;
    }
  }

  /// (en)Returns a new face with the orientation of this face reversed.
  /// Internally, the order of 3D vectors except the beginning is reversed.
  ///
  /// (ja)この面の向きを反転した新しい面を返します。内部では先頭を除く3Dベクトルの順番が反転します。
  Sp3dFace reversed_ft() {
    Sp3dFace r = this.deep_copy();
    r.reverse_ft();
    return r;
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
  final String version = '12';
  double x;
  double y;
  double z;

  /// Constructor
  /// * [x] : The x coordinate of the 3D vertex.
  /// * [y] : The x coordinate of the 3D vertex.
  /// * [z] : The x coordinate of the 3D vertex.
  Sp3dV3D(this.x, this.y, this.z);

  /// Deep copy the object.
  Sp3dV3D deep_copy() {
    return Sp3dV3D(this.x, this.y, this.z);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict() {
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
  static Sp3dV3D from_dict(Map<String, dynamic> src) {
    return Sp3dV3D(src['x'], src['y'], src['z']);
  }

  Sp3dV3D operator +(Sp3dV3D v) {
    return Sp3dV3D(this.x + v.x, this.y + v.y, this.z + v.z);
  }

  Sp3dV3D operator -(Sp3dV3D v) {
    return Sp3dV3D(this.x - v.x, this.y - v.y, this.z - v.z);
  }

  Sp3dV3D operator *(num scalar) {
    return Sp3dV3D(this.x * scalar, this.y * scalar, this.z * scalar);
  }

  Sp3dV3D operator /(num scalar) {
    return Sp3dV3D(this.x / scalar, this.y / scalar, this.z / scalar);
  }

  bool operator ==(Object v) {
    if (v is Sp3dV3D) {
      return this.x == v.x && this.y == v.y && this.z == v.z;
    } else {
      return false;
    }
  }

  /// (en)Overwrites the contents of this vector with the contents of the other vector and returns this vector.
  ///
  /// (ja)このベクトルの内容を指定したベクトルの内容で上書きし、このベクトルを返します。
  Sp3dV3D set(Sp3dV3D v) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
    return this;
  }

  /// (en)Return vector length.
  ///
  /// (ja)長さを返します。
  double len() {
    return sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
  }

  /// (en)Return Normalized Vector.
  ///
  /// (ja)正規化したベクトルを返します。
  Sp3dV3D nor() {
    double length = this.len();
    if (length == 0) {
      return this.deep_copy();
    } else {
      return this / length;
    }
  }

  /// (en)Return dot product.
  ///
  /// (ja)ドット積を返します。
  static double dot(Sp3dV3D a, Sp3dV3D b) {
    return a.x * b.x + a.y * b.y + a.z * b.z;
  }

  /// (en)Return cross product.
  ///
  /// (ja)クロス積を返します。
  static Sp3dV3D cross(Sp3dV3D a, Sp3dV3D b) {
    return Sp3dV3D((a.y * b.z) - (a.z * b.y), (a.z * b.x) - (a.x * b.z),
        (a.x * b.y) - (a.y * b.x));
  }

  /// (en)Return the radian between vector A and vector B.
  /// When converting to degrees, degrees = radian*180/pi.
  ///
  /// (ja)２つのベクトルの成す角（ラジアン）を返します。
  /// 度に変換する場合は degrees = radian*180/pi です。
  static double angle(Sp3dV3D a, Sp3dV3D b) {
    return acos(Sp3dV3D.dot(a, b) / (a.len() * b.len()));
  }

  /// (en)Calculates and returns the surface normal.
  /// The order of the vertices must be counterclockwise.
  /// Note that this cannot be used for degenerate polygons.
  ///
  /// (ja)面法線を計算して返します。
  /// 頂点の順は逆時計回りである必要があります。
  /// これは縮退ポリゴンには使えないので注意が必要です。
  ///
  /// * [face] : face vertices.
  ///
  /// Returns surface normal.
  static Sp3dV3D surface_normal(List<Sp3dV3D> face) {
    final int vlen = face.length;
    if (vlen == 3) {
      return Sp3dV3D.cross(face[1] - face[0], face[1] - face[2]);
    } else {
      // Newellの方法の反転版
      Sp3dV3D r = Sp3dV3D(0, 0, 0);
      for (int i = 0; i < vlen; i++) {
        Sp3dV3D cv = face[i];
        Sp3dV3D nv = face[(i + 1) % vlen];
        r.x -= (cv.y - nv.y) * (cv.z + nv.z);
        r.y -= (cv.z - nv.z) * (cv.x + nv.x);
        r.z -= (cv.x - nv.x) * (cv.y + nv.y);
      }
      return r;
    }
  }

  /// (en)Return projection vector.
  ///
  /// (ja)射影ベクトルを返します。
  ///
  /// * [v] : vector.
  /// * [nor_v] : normalized vector.
  static Sp3dV3D proj(Sp3dV3D v, Sp3dV3D nor_v) {
    return nor_v * Sp3dV3D.dot(v, nor_v);
  }

  /// (en)Return euclidean distance.
  ///
  /// (ja)ユークリッド距離を返します。
  static double dist(Sp3dV3D a, Sp3dV3D b) {
    return (a - b).len();
  }

  /// (en)Return rotated this vector.
  ///
  /// (ja)このベクトルを回転します。
  ///
  /// * [nor_axis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dV3D rotate(Sp3dV3D nor_axis, double radian) {
    Sp3dV3D c = this.rotated(nor_axis, radian);
    this.x = c.x;
    this.y = c.y;
    this.z = c.z;
    return this;
  }

  /// (en)Return rotated new vector.
  ///
  /// (ja)このベクトルを回転した新しいベクトルを返します。
  ///
  /// * [nor_axis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dV3D rotated(Sp3dV3D nor_axis, double radian) {
    Sp3dV3D c = Sp3dV3D.proj(this, nor_axis);
    Sp3dV3D w = this - c;
    return c + (w * cos(radian)) + (Sp3dV3D.cross(nor_axis, w) * sin(radian));
  }

  /// (en)Return true if parameter is all zero, otherwise false.
  ///
  /// (ja)全てのパラメータが0であればtrue、それ以外はfalseを返します。
  bool is_zero() {
    return this.x == 0 && this.y == 0 && this.z == 0;
  }

  /// (en)Return random orthogonal vector.
  ///
  /// (ja)このベクトルに直交するランダムなベクトルを返します。
  Sp3dV3D ortho() {
    if (this.is_zero()) {
      return this.deep_copy();
    }
    double r = Random().nextDouble() + 1;
    if (this.x != 0) {
      return Sp3dV3D((-1 * this.y * r - this.z * r) / this.x, r, r);
    } else if (this.y != 0) {
      return Sp3dV3D(r, (-1 * this.x * r - this.z * r) / this.y, r);
    } else {
      return Sp3dV3D(r, r, (-1 * this.x * r - this.y * r) / this.z);
    }
  }

  /// (en)Return the averaged vector.
  ///
  /// (ja)平均したベクトルを返します。
  static Sp3dV3D ave(List<Sp3dV3D> v) {
    double x = 0;
    double y = 0;
    double z = 0;
    for (Sp3dV3D i in v) {
      x += i.x;
      y += i.y;
      z += i.z;
    }
    x /= v.length;
    y /= v.length;
    z /= v.length;
    return Sp3dV3D(x, y, z);
  }

  /// (en)Adds other vector to this vector and returns this vector.
  ///
  /// (ja)このベクトルに他のベクトルを加算し、このベクトルを返します。
  ///
  /// * [v] : Other vector.
  Sp3dV3D add(Sp3dV3D v) {
    this.x += v.x;
    this.y += v.y;
    this.z += v.z;
    return this;
  }

  /// (en)Subtracts other vector from this vector and returns this vector.
  ///
  /// (ja)このベクトルから他のベクトルを減算し、このベクトルを返します。
  ///
  /// * [v] : Other vector.
  Sp3dV3D sub(Sp3dV3D v) {
    this.x -= v.x;
    this.y -= v.y;
    this.z -= v.z;
    return this;
  }

  /// (en)Multiplies this vector by a scalar value and returns this vector.
  ///
  /// (ja)このベクトルにスカラー値を掛け、このベクトルを返します。
  ///
  /// * [scalar] : Scalar value.
  Sp3dV3D mul(num scalar) {
    this.x *= scalar;
    this.y *= scalar;
    this.z *= scalar;
    return this;
  }

  /// (en)Divide this vector by the scalar value and return this vector.
  ///
  /// (ja)このベクトルをスカラー値で割り、このベクトルを返します。
  ///
  /// * [scalar] : Scalar value.
  Sp3dV3D div(num scalar) {
    this.x /= scalar;
    this.y /= scalar;
    this.z /= scalar;
    return this;
  }

  /// (en)Compare while considering the error. Returns true if x, y, z are all within the e_range.
  ///
  /// (ja)誤差を考慮しつつ比較します。x,y,zの全てが誤差e_range以内の場合はtrueを返します。
  /// * [other] : other vector.
  /// * [e_range] : The range of error to allow. This must be a positive number.
  bool equals(Sp3dV3D other, double e_range) {
    return this.x - e_range <= other.x &&
        other.x <= this.x + e_range &&
        this.y - e_range <= other.y &&
        other.y <= this.y + e_range &&
        this.z - e_range <= other.z &&
        other.z <= this.z + e_range;
  }

  @override
  String toString() {
    return '[' +
        this.x.toString() +
        ',' +
        this.y.toString() +
        ',' +
        this.z.toString() +
        ']';
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + this.x.hashCode;
    result = 37 * result + this.y.hashCode;
    result = 37 * result + this.z.hashCode;
    return result;
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
  final String version = '2';
  Color bg;
  bool is_fill;
  double stroke_width;
  Color stroke_color;
  int? image_index;
  List<Offset>? texture_coordinates;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [bg] : Background color
  /// * [is_fill] : If true, fill by bg color.
  /// * [stroke_width] : Stroke width.
  /// * [stroke_color] : Stroke color.
  /// * [image_index] : Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the clockwise order as the vertices from the upper left.
  /// * [texture_coordinates] : You can specify the part of the image that you want to cut out and use. Use by specifying the coordinate information for the image.
  /// Specify the coordinates counterclockwise with a triangle or rectangle.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dMaterial(this.bg, this.is_fill, this.stroke_width, this.stroke_color,
      {this.image_index, this.texture_coordinates, this.option});

  /// Convert the object to a dictionary.
  Sp3dMaterial deep_copy() {
    var mbg =
        Color.fromARGB(this.bg.alpha, this.bg.red, this.bg.green, this.bg.blue);
    var msc = Color.fromARGB(this.stroke_color.alpha, this.stroke_color.red,
        this.stroke_color.green, this.stroke_color.blue);
    List<Offset>? t_coord;
    if (this.texture_coordinates != null) {
      t_coord = [];
      for (Offset o in this.texture_coordinates!) {
        t_coord.add(Offset(o.dx, o.dy));
      }
    }
    return Sp3dMaterial(mbg, this.is_fill, this.stroke_width, msc,
        image_index: this.image_index,
        texture_coordinates: t_coord,
        option: this.option != null ? {...this.option!} : null);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> to_dict() {
    List<double>? t_coord;
    if (this.texture_coordinates != null) {
      t_coord = [];
      for (Offset o in this.texture_coordinates!) {
        t_coord.add(o.dx);
        t_coord.add(o.dy);
      }
    }
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['bg'] = [this.bg.alpha, this.bg.red, this.bg.green, this.bg.blue];
    d['is_fill'] = this.is_fill;
    d['stroke_width'] = this.stroke_width;
    d['stroke_color'] = [
      this.stroke_color.alpha,
      this.stroke_color.red,
      this.stroke_color.green,
      this.stroke_color.blue
    ];
    d['image_index'] = this.image_index;
    d['texture_coordinates'] = t_coord;
    d['option'] = this.option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with to_dict of this class.
  static Sp3dMaterial from_dict(Map<String, dynamic> src) {
    var mbg =
        Color.fromARGB(src['bg'][0], src['bg'][1], src['bg'][2], src['bg'][3]);
    var msc = Color.fromARGB(src['stroke_color'][0], src['stroke_color'][1],
        src['stroke_color'][2], src['stroke_color'][3]);
    List<Offset>? t_coord;
    if (src.containsKey('texture_coordinates')) {
      t_coord = [];
      List<double> c_buff = [];
      for (double d in src['texture_coordinates']) {
        c_buff.add(d);
        if(c_buff.length==2){
          t_coord.add(Offset(c_buff[0], c_buff[1]));
          c_buff.clear();
        }
      }
    }
    return Sp3dMaterial(mbg, src['is_fill'], src['stroke_width'], msc,
        image_index: src['image_index'],
        texture_coordinates: t_coord,
        option: src['option']);
  }
}
