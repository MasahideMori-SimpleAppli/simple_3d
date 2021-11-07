library simple_3d;

import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';

///
/// (en) Flutter implementation of Sp3dObj.
/// The options for this object and internal elements can be freely extended for each application.
/// When writing out, toDict is converted to json. If you want to read it, you can easily restore it by calling fromDict.
///
/// (ja) Sp3dObjのFlutter実装です。
/// このオブジェクト及び内部要素のoptionはアプリケーション毎に自由に拡張できます。
/// 書きだす場合はtoDictしたものをjson化します。読み込む場合はfromDict呼び出しで簡単に復元できます。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-06-30 22:54:22
///
class Sp3dObj {
  final String className = 'Sp3dObj';
  final String version = '5';
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
  Sp3dObj deepCopy() {
    List<Sp3dV3D> v = [];
    for (var i in this.vertices) {
      v.add(i.deepCopy());
    }
    List<Sp3dFragment> frgs = [];
    for (var i in this.fragments) {
      frgs.add(i.deepCopy());
    }
    List<Sp3dMaterial> mtrs = [];
    for (var i in this.materials) {
      mtrs.add(i.deepCopy());
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
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dObj rotate(Sp3dV3D norAxis, double radian) {
    for (Sp3dV3D i in this.vertices) {
      i.rotate(norAxis, radian);
    }
    return this;
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = this.className;
    d['version'] = this.version;
    d['id'] = this.id;
    d['name'] = this.name;
    List<Map<String, dynamic>> v = [];
    for (var i in this.vertices) {
      v.add(i.toDict());
    }
    d['vertices'] = v;
    List<Map<String, dynamic>> frgs = [];
    for (var i in this.fragments) {
      frgs.add(i.toDict());
    }
    d['fragments'] = frgs;
    List<Map<String, dynamic>> mtrs = [];
    for (var i in this.materials) {
      mtrs.add(i.toDict());
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
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dObj fromDict(Map<String, dynamic> src) {
    List<Sp3dV3D> v = [];
    for (var i in src['vertices']) {
      v.add(Sp3dV3D.fromDict(i));
    }
    List<Sp3dFragment> frgs = [];
    for (var i in src['fragments']) {
      frgs.add(Sp3dFragment.fromDict(i));
    }
    List<Sp3dMaterial> mtrs = [];
    for (var i in src['materials']) {
      mtrs.add(Sp3dMaterial.fromDict(i));
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
  final String className = 'Sp3dFragment';
  final String version = '2';
  bool isParticle;
  List<Sp3dFace> faces;
  double r;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [isParticle] : If true, this is particle.
  /// * [faces] : Face Object list. This includes vertex information.
  /// * [r] : Particle radius.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dFragment(this.isParticle, this.faces, this.r, this.option);

  /// Deep copy the object.
  Sp3dFragment deepCopy() {
    List<Sp3dFace> f = [];
    for (var i in this.faces) {
      f.add(i.deepCopy());
    }
    if (this.option != null) {
      return Sp3dFragment(this.isParticle, f, this.r, {...this.option!});
    } else {
      return Sp3dFragment(this.isParticle, f, this.r, null);
    }
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = this.className;
    d['version'] = this.version;
    d['is_particle'] = this.isParticle;
    List<Map<String, dynamic>> f = [];
    for (var i in this.faces) {
      f.add(i.toDict());
    }
    d['faces'] = f;
    d['r'] = this.r;
    d['option'] = this.option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFragment fromDict(Map<String, dynamic> src) {
    List<Sp3dFace> f = [];
    for (var i in src['faces']) {
      f.add(Sp3dFace.fromDict(i));
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
  final String className = 'Sp3dFace';
  final String version = '6';
  List<int> vertexIndexList;
  int? materialIndex;

  /// Constructor
  /// * [vertexIndexList] : 3D vertex index list.
  /// * [materialIndex] : use material index. If null, disable.
  Sp3dFace(this.vertexIndexList, this.materialIndex);

  /// Deep copy the object.
  Sp3dFace deepCopy() {
    return Sp3dFace([...vertexIndexList], this.materialIndex);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = this.className;
    d['version'] = this.version;
    d['vertex_index_list'] = this.vertexIndexList;
    d['material_index'] = this.materialIndex;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFace fromDict(Map<String, dynamic> src) {
    return Sp3dFace(src['vertex_index_list'], src['material_index']);
  }

  /// (en)Gets the vertices of this face.
  ///
  /// (ja)この面の頂点を取得します。
  /// * [obj] : The object to which this face belongs.
  List<Sp3dV3D> getVertices(Sp3dObj obj) {
    List<Sp3dV3D> r = [];
    for (int i in this.vertexIndexList) {
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
    if (this.vertexIndexList.length > 2) {
      this.vertexIndexList = this.vertexIndexList.reversed.toList();
    }
  }

  /// (en)Returns a new face with the orientation of this face reversed.
  /// Internally, the order of the referenced indexes is reversed.
  ///
  /// (ja)この面の向きを反転した新しい面を返します。
  /// 内部的には、参照しているインデックスの順序が反転します。
  Sp3dFace reversed() {
    Sp3dFace r = this.deepCopy();
    r.reverse();
    return r;
  }

  /// (en)Reverse the orientation of this face.
  /// Internally, the order of 3D vectors except the beginning is reversed.
  ///
  /// (ja)この面の向きを反転します。内部では先頭を除く3Dベクトルの順番が反転します。
  void reverseFt() {
    if (this.vertexIndexList.length > 2) {
      List<int> nl = [];
      nl.add(this.vertexIndexList.removeAt(0));
      nl.addAll(this.vertexIndexList.reversed);
      this.vertexIndexList = nl;
    }
  }

  /// (en)Returns a new face with the orientation of this face reversed.
  /// Internally, the order of 3D vectors except the beginning is reversed.
  ///
  /// (ja)この面の向きを反転した新しい面を返します。内部では先頭を除く3Dベクトルの順番が反転します。
  Sp3dFace reversedFt() {
    Sp3dFace r = this.deepCopy();
    r.reverseFt();
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
  final String className = 'Sp3dV3D';
  final String version = '13';
  double x;
  double y;
  double z;

  /// Constructor
  /// * [x] : The x coordinate of the 3D vertex.
  /// * [y] : The x coordinate of the 3D vertex.
  /// * [z] : The x coordinate of the 3D vertex.
  Sp3dV3D(this.x, this.y, this.z);

  /// Deep copy the object.
  Sp3dV3D deepCopy() {
    return Sp3dV3D(this.x, this.y, this.z);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = this.className;
    d['version'] = this.version;
    d['x'] = this.x;
    d['y'] = this.y;
    d['z'] = this.z;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dV3D fromDict(Map<String, dynamic> src) {
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
      return this.deepCopy();
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
  static Sp3dV3D surfaceNormal(List<Sp3dV3D> face) {
    final int vLen = face.length;
    if (vLen == 3) {
      return Sp3dV3D.cross(face[1] - face[0], face[1] - face[2]);
    } else {
      // Newellの方法の反転版
      Sp3dV3D r = Sp3dV3D(0, 0, 0);
      for (int i = 0; i < vLen; i++) {
        Sp3dV3D cv = face[i];
        Sp3dV3D nv = face[(i + 1) % vLen];
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
  /// * [norV] : normalized vector.
  static Sp3dV3D proj(Sp3dV3D v, Sp3dV3D norV) {
    return norV * Sp3dV3D.dot(v, norV);
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
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dV3D rotate(Sp3dV3D norAxis, double radian) {
    Sp3dV3D c = this.rotated(norAxis, radian);
    this.x = c.x;
    this.y = c.y;
    this.z = c.z;
    return this;
  }

  /// (en)Return rotated new vector.
  ///
  /// (ja)このベクトルを回転した新しいベクトルを返します。
  ///
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dV3D rotated(Sp3dV3D norAxis, double radian) {
    Sp3dV3D c = Sp3dV3D.proj(this, norAxis);
    Sp3dV3D w = this - c;
    return c + (w * cos(radian)) + (Sp3dV3D.cross(norAxis, w) * sin(radian));
  }

  /// (en)Return true if parameter is all zero, otherwise false.
  ///
  /// (ja)全てのパラメータが0であればtrue、それ以外はfalseを返します。
  bool isZero() {
    return this.x == 0 && this.y == 0 && this.z == 0;
  }

  /// (en)Return random orthogonal vector.
  ///
  /// (ja)このベクトルに直交するランダムなベクトルを返します。
  Sp3dV3D ortho() {
    if (this.isZero()) {
      return this.deepCopy();
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
  /// * [eRange] : The range of error to allow. This must be a positive number.
  bool equals(Sp3dV3D other, double eRange) {
    return this.x - eRange <= other.x &&
        other.x <= this.x + eRange &&
        this.y - eRange <= other.y &&
        other.y <= this.y + eRange &&
        this.z - eRange <= other.z &&
        other.z <= this.z + eRange;
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
  final String className = 'Sp3dMaterial';
  final String version = '3';
  Color bg;
  bool isFill;
  double strokeWidth;
  Color strokeColor;
  int? imageIndex;
  List<Offset>? textureCoordinates;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [bg] : Background color
  /// * [isFill] : If true, fill by bg color.
  /// * [strokeWidth] : Stroke width.
  /// * [strokeColor] : Stroke color.
  /// * [imageIndex] : Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the clockwise order as the vertices from the upper left.
  /// * [textureCoordinates] : You can specify the part of the image that you want to cut out and use. Use by specifying the coordinate information for the image.
  /// Specify the coordinates counterclockwise with a triangle(3 vertices) or rectangle(There are two triangles. 6 vertices).
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dMaterial(this.bg, this.isFill, this.strokeWidth, this.strokeColor,
      {this.imageIndex, this.textureCoordinates, this.option});

  /// Convert the object to a dictionary.
  Sp3dMaterial deepCopy() {
    var mbg =
        Color.fromARGB(this.bg.alpha, this.bg.red, this.bg.green, this.bg.blue);
    var msc = Color.fromARGB(this.strokeColor.alpha, this.strokeColor.red,
        this.strokeColor.green, this.strokeColor.blue);
    List<Offset>? tCoord;
    if (this.textureCoordinates != null) {
      tCoord = [];
      for (Offset o in this.textureCoordinates!) {
        tCoord.add(Offset(o.dx, o.dy));
      }
    }
    return Sp3dMaterial(mbg, this.isFill, this.strokeWidth, msc,
        imageIndex: this.imageIndex,
        textureCoordinates: tCoord,
        option: this.option != null ? {...this.option!} : null);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    List<double>? tCoord;
    if (this.textureCoordinates != null) {
      tCoord = [];
      for (Offset o in this.textureCoordinates!) {
        tCoord.add(o.dx);
        tCoord.add(o.dy);
      }
    }
    Map<String, dynamic> d = {};
    d['class_name'] = this.className;
    d['version'] = this.version;
    d['bg'] = [this.bg.alpha, this.bg.red, this.bg.green, this.bg.blue];
    d['is_fill'] = this.isFill;
    d['stroke_width'] = this.strokeWidth;
    d['stroke_color'] = [
      this.strokeColor.alpha,
      this.strokeColor.red,
      this.strokeColor.green,
      this.strokeColor.blue
    ];
    d['image_index'] = this.imageIndex;
    d['texture_coordinates'] = tCoord;
    d['option'] = this.option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dMaterial fromDict(Map<String, dynamic> src) {
    var mbg =
        Color.fromARGB(src['bg'][0], src['bg'][1], src['bg'][2], src['bg'][3]);
    var msc = Color.fromARGB(src['stroke_color'][0], src['stroke_color'][1],
        src['stroke_color'][2], src['stroke_color'][3]);
    List<Offset>? tCoord;
    if (src.containsKey('texture_coordinates')) {
      tCoord = [];
      List<double> cBuff = [];
      for (double d in src['texture_coordinates']) {
        cBuff.add(d);
        if (cBuff.length == 2) {
          tCoord.add(Offset(cBuff[0], cBuff[1]));
          cBuff.clear();
        }
      }
    }
    return Sp3dMaterial(mbg, src['is_fill'], src['stroke_width'], msc,
        imageIndex: src['image_index'],
        textureCoordinates: tCoord,
        option: src['option']);
  }
}
