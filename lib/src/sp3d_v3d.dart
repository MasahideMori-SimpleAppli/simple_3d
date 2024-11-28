import 'dart:math';

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
  static const String className = 'Sp3dV3D';
  static const String version = '17';
  double x;
  double y;
  double z;

  /// Constructor
  /// * [x] : The x coordinate of the 3D vertex.
  /// * [y] : The y coordinate of the 3D vertex.
  /// * [z] : The z coordinate of the 3D vertex.
  Sp3dV3D(this.x, this.y, this.z);

  /// Deep copy the object.
  Sp3dV3D deepCopy() {
    return Sp3dV3D(x, y, z);
  }

  /// Creates a copy with only the specified values rewritten.
  /// * [x] : The x coordinate of the 3D vertex.
  /// * [y] : The y coordinate of the 3D vertex.
  /// * [z] : The z coordinate of the 3D vertex.
  Sp3dV3D copyWith({double? x, double? y, double? z}) {
    return Sp3dV3D(x ?? this.x, y ?? this.y, z ?? this.z);
  }

  /// Convert the object to a dictionary.
  /// Starting with simple_3d version 15,
  /// this method excludes printing of class name and version information.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['x'] = x;
    d['y'] = y;
    d['z'] = z;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dV3D fromDict(Map<String, dynamic> src) {
    return Sp3dV3D(src['x'], src['y'], src['z']);
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  Map<String, dynamic> toDictV14() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = "16";
    d['x'] = x;
    d['y'] = y;
    d['z'] = z;
    return d;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dV3D fromDictV14(Map<String, dynamic> src) {
    return Sp3dV3D(src['x'], src['y'], src['z']);
  }

  Sp3dV3D operator +(Sp3dV3D v) {
    return Sp3dV3D(x + v.x, y + v.y, z + v.z);
  }

  Sp3dV3D operator -(Sp3dV3D v) {
    return Sp3dV3D(x - v.x, y - v.y, z - v.z);
  }

  Sp3dV3D operator *(num scalar) {
    return Sp3dV3D(x * scalar, y * scalar, z * scalar);
  }

  Sp3dV3D operator /(num scalar) {
    return Sp3dV3D(x / scalar, y / scalar, z / scalar);
  }

  @override
  bool operator ==(Object other) {
    if (other is Sp3dV3D) {
      return x == other.x && y == other.y && z == other.z;
    } else {
      return false;
    }
  }

  /// (en)Overwrites the contents of this vector with the contents of the other vector and returns this vector.
  ///
  /// (ja)このベクトルの内容を指定したベクトルの内容で上書きし、このベクトルを返します。
  Sp3dV3D set(Sp3dV3D v) {
    x = v.x;
    y = v.y;
    z = v.z;
    return this;
  }

  /// (en)Return vector length.
  ///
  /// (ja)長さを返します。
  double len() {
    return sqrt(x * x + y * y + z * z);
  }

  /// (en)Return Normalized Vector.
  ///
  /// (ja)正規化したベクトルを返します。
  Sp3dV3D nor() {
    double length = len();
    if (length == 0) {
      return deepCopy();
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

  /// (en)Return dot product.
  ///
  /// (ja)ドット積を返します。
  double dotTo(Sp3dV3D other) {
    return dot(this, other);
  }

  /// (en)Return cross product.
  ///
  /// (ja)クロス積を返します。
  static Sp3dV3D cross(Sp3dV3D a, Sp3dV3D b) {
    return Sp3dV3D((a.y * b.z) - (a.z * b.y), (a.z * b.x) - (a.x * b.z),
        (a.x * b.y) - (a.y * b.x));
  }

  /// (en)Return cross product.
  ///
  /// (ja)クロス積を返します。
  Sp3dV3D crossTo(Sp3dV3D other) {
    return cross(this, other);
  }

  /// (en)Return the radian between vector A and vector B.
  /// When converting to degrees, degrees = radian*180/pi.
  ///
  /// (ja)２つのベクトルの成す角（ラジアン）を返します。
  /// 度に変換する場合は degrees = radian*180/pi です。
  static double angle(Sp3dV3D a, Sp3dV3D b) {
    return acos(Sp3dV3D.dot(a, b) / (a.len() * b.len()));
  }

  /// (en)Return the radian between vector A and vector B.
  /// When converting to degrees, degrees = radian*180/pi.
  ///
  /// (ja)２つのベクトルの成す角（ラジアン）を返します。
  /// 度に変換する場合は degrees = radian*180/pi です。
  double angleTo(Sp3dV3D other) {
    return angle(this, other);
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

  /// (en)Return euclidean distance.
  ///
  /// (ja)ユークリッド距離を返します。
  double distTo(Sp3dV3D other) {
    return dist(this, other);
  }

  /// (en)Return rotated this vector.
  ///
  /// (ja)このベクトルを回転します。
  ///
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dV3D rotate(Sp3dV3D norAxis, double radian) {
    Sp3dV3D c = rotated(norAxis, radian);
    x = c.x;
    y = c.y;
    z = c.z;
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
    return x == 0 && y == 0 && z == 0;
  }

  /// (en)Return random orthogonal vector.
  ///
  /// (ja)このベクトルに直交するランダムなベクトルを返します。
  Sp3dV3D ortho() {
    if (isZero()) {
      return deepCopy();
    }
    double r = Random().nextDouble() + 1;
    if (x != 0) {
      return Sp3dV3D((-1 * y * r - z * r) / x, r, r);
    } else if (y != 0) {
      return Sp3dV3D(r, (-1 * x * r - z * r) / y, r);
    } else {
      return Sp3dV3D(r, r, (-1 * x * r - y * r) / z);
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
    x += v.x;
    y += v.y;
    z += v.z;
    return this;
  }

  /// (en)Subtracts other vector from this vector and returns this vector.
  ///
  /// (ja)このベクトルから他のベクトルを減算し、このベクトルを返します。
  ///
  /// * [v] : Other vector.
  Sp3dV3D sub(Sp3dV3D v) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
    return this;
  }

  /// (en)Multiplies this vector by a scalar value and returns this vector.
  ///
  /// (ja)このベクトルにスカラー値を掛け、このベクトルを返します。
  ///
  /// * [scalar] : Scalar value.
  Sp3dV3D mul(num scalar) {
    x *= scalar;
    y *= scalar;
    z *= scalar;
    return this;
  }

  /// (en)Divide this vector by the scalar value and return this vector.
  ///
  /// (ja)このベクトルをスカラー値で割り、このベクトルを返します。
  ///
  /// * [scalar] : Scalar value.
  Sp3dV3D div(num scalar) {
    x /= scalar;
    y /= scalar;
    z /= scalar;
    return this;
  }

  /// (en)Compare while considering the error. Returns true if x, y, z are all within the e_range.
  ///
  /// (ja)誤差を考慮しつつ比較します。x,y,zの全てが誤差e_range以内の場合はtrueを返します。
  /// * [other] : other vector.
  /// * [eRange] : The range of error to allow. This must be a positive number.
  bool equals(Sp3dV3D other, double eRange) {
    return x - eRange <= other.x &&
        other.x <= x + eRange &&
        y - eRange <= other.y &&
        other.y <= y + eRange &&
        z - eRange <= other.z &&
        other.z <= z + eRange;
  }

  @override
  String toString() {
    return '[$x,$y,$z]';
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + x.hashCode;
    result = 37 * result + y.hashCode;
    result = 37 * result + z.hashCode;
    return result;
  }
}
