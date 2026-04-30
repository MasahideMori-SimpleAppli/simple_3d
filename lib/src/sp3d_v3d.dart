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
  static const String version = '22';
  double x;
  double y;
  double z;

  /// Constructor
  /// * [x] : The x coordinate of the 3D vertex.
  /// * [y] : The y coordinate of the 3D vertex.
  /// * [z] : The z coordinate of the 3D vertex.
  Sp3dV3D(this.x, this.y, this.z);

  /// (en) Returns a vector with x, y, and z equal to 0.
  ///
  /// (ja) x,y,zが0のベクトルを返します。
  factory Sp3dV3D.zero() {
    return Sp3dV3D(0, 0, 0);
  }

  /// (en) Deep copy the object.
  ///
  /// (ja) このオブジェクトのディープコピーを返します。
  Sp3dV3D deepCopy() {
    return Sp3dV3D(x, y, z);
  }

  /// (en) Creates a copy with only the specified values rewritten.
  ///
  /// (ja) 指定された値のみを書き換えたコピーを作成します。
  ///
  /// * [x] : The x coordinate of the 3D vertex.
  /// * [y] : The y coordinate of the 3D vertex.
  /// * [z] : The z coordinate of the 3D vertex.
  Sp3dV3D copyWith({double? x, double? y, double? z}) {
    return Sp3dV3D(x ?? this.x, y ?? this.y, z ?? this.z);
  }

  /// (en) Convert the object to a dictionary.
  /// Starting with simple_3d version 15,
  /// this method excludes printing of class name and version information.
  ///
  /// (ja) オブジェクトを辞書に変換します。
  /// simple_3d バージョン 15 以降では、
  /// このメソッドはクラス名とバージョン情報の出力を除外します。
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['x'] = x;
    d['y'] = y;
    d['z'] = z;
    return d;
  }

  /// 変換用
  static double _d(dynamic value) => (value as num).toDouble();

  /// (en) Restore this object from the dictionary.
  ///
  /// (ja) このオブジェクトを辞書から復元します。
  ///
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dV3D fromDict(Map<String, dynamic> src) {
    return Sp3dV3D(_d(src['x']), _d(src['y']), _d(src['z']));
  }

  /// (en) Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  ///
  /// (ja) オブジェクトを辞書に変換します。
  /// これは古いバージョンとの互換性のための呼び出しです。
  Map<String, dynamic> toDictV14() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = "16";
    d['x'] = x;
    d['y'] = y;
    d['z'] = z;
    return d;
  }

  /// (en) Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  ///
  /// (ja) このオブジェクトを辞書から復元します。
  /// これは古いバージョンとの互換性のための呼び出しです。
  ///
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dV3D fromDictV14(Map<String, dynamic> src) {
    return Sp3dV3D(_d(src['x']), _d(src['y']), _d(src['z']));
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

  /// (en) Safe normalization for rendering / UI use.
  /// This method is not intended for mathematical computations.
  ///
  /// (ja) 描画・UI用途向けの安全な正規化を行ったベクトルを返します。
  /// このメソッドは数学的な計算を目的としたものではありません。
  ///
  /// * [eps] : Epsilon value.
  /// Degenerate, NaN, or vectors with a length less than or equal to this value
  /// are treated as invalid and converted to (0, 0, 0).
  Sp3dV3D norSafe({double eps = 1e-6}) {
    final double length = len();
    if (!length.isFinite || length <= eps) {
      return Sp3dV3D(0, 0, 0);
    }
    return this / length;
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

  /// (en) Returns the signed angle in radians from vector a to vector b
  /// around the specified normal axis.
  /// The result range is (-pi, pi].
  ///
  /// The sign of the angle is determined by the right-hand rule:
  /// if the rotation from a to b follows the direction of the normal,
  /// the angle is positive; otherwise negative.
  ///
  /// Both input vectors do not need to be normalized.
  /// If either vector has zero length, 0 is returned.
  ///
  /// (ja) ベクトルaからベクトルbへの符号付き角度（ラジアン）を、
  /// 指定した法線軸まわりで返します。
  /// 戻り値の範囲は (-π, π] です。
  ///
  /// 角度の符号は右手系で決まります：
  /// a→b の回転が normal の向きに一致する場合は正、
  /// 逆向きの場合は負になります。
  ///
  /// 入力ベクトルは正規化されている必要はありません。
  /// いずれかの長さが0の場合は 0 を返します。
  ///
  /// * [a] : Starting vector (it will be normalized internally).
  /// * [b] : Ending vector (it will be normalized internally).
  /// * [normal] : reference axis that defines the rotation direction (it will be normalized internally).
  static double signedAngle(Sp3dV3D a, Sp3dV3D b, Sp3dV3D normal) {
    final lenA = a.len();
    final lenB = b.len();
    final lenN = normal.len(); // normalの長さをチェック
    // normalが0の場合も、角度を定義できないため0を返す。
    if (lenA == 0 || lenB == 0 || lenN == 0) return 0.0;
    final na = a / lenA;
    final nb = b / lenB;
    final nn = normal / lenN; // normalを正規化
    final cross = Sp3dV3D.cross(na, nb);
    final dot = Sp3dV3D.dot(na, nb).clamp(-1.0, 1.0);
    // 正規化されたnnを使うことで、signの大きさが適切に保たれる
    final sign = Sp3dV3D.dot(nn, cross);
    return atan2(sign, dot);
  }

  /// (en) Returns the signed angle in radians from vector a to vector b
  /// after projecting both vectors onto the plane defined by normal.
  /// Range: (-pi, pi].
  ///
  /// This ignores components along the normal and measures rotation
  /// within the plane only.
  ///
  /// (ja) ベクトルaとbをnormalで定義される平面へ射影し、
  /// 平面内での符号付き角度（ラジアン）を返します。
  /// 範囲: (-π, π]
  ///
  /// * [a] : The starting direction (will be projected onto the plane).
  /// * [b] : The target direction (will be projected onto the plane).
  /// * [normal] : The normal vector that defines the plane (it will be normalized internally).
  static double signedAngleOnPlane(Sp3dV3D a, Sp3dV3D b, Sp3dV3D normal) {
    final lenN = normal.len();
    if (lenN == 0) return 0.0; // 法線がない場合は角度を定義できない
    // normalを正規化（長さ1の単位ベクトルにする）
    final n = normal / lenN;
    // 単位ベクトルnを使えば、現在の射影の式で正しく計算できる
    final pa = a - n * Sp3dV3D.dot(a, n);
    final pb = b - n * Sp3dV3D.dot(b, n);
    // 既に正規化済みのnを渡す
    return signedAngle(pa, pb, n);
  }

  /// (en) Returns the projection of this vector onto the plane defined by
  /// the given normal vector.
  ///
  /// The component along the normal direction is removed:
  ///   v_proj = v − (v·n̂) n̂
  ///
  /// The normal does not need to be normalized.
  /// If the normal has zero length, this vector is returned unchanged.
  ///
  /// (ja) このベクトルを、指定した法線normalで定義される平面へ
  /// 射影したベクトルを返します。
  ///
  /// normal方向成分が除去されます：
  ///   v_proj = v − (v·n̂) n̂
  ///
  /// normalは正規化されている必要はありません。
  /// normalの長さが0の場合は、このベクトルをそのまま返します。
  ///
  /// * [normal] : plane normal defining the projection plane (it will be normalized internally).
  Sp3dV3D projectOnPlane(Sp3dV3D normal) {
    final nLen = normal.len();
    if (nLen == 0) return this;
    final n = normal / nLen;
    return this - n * Sp3dV3D.dot(this, n);
  }

  /// (en) Returns the unit direction of this vector projected onto the plane
  /// defined by the given normal.
  ///
  /// This is equivalent to:
  ///   normalize( projectOnPlane(normal) )
  ///
  /// If the projected vector has zero length (i.e., this vector is parallel
  /// to the normal or zero), a zero vector is returned.
  ///
  /// The normal does not need to be normalized.
  ///
  /// (ja) このベクトルを指定した法線normalの平面へ射影した後、
  /// 平面内方向の単位ベクトルを返します。
  ///
  /// これは次と等価です：
  ///   normalize( projectOnPlane(normal) )
  ///
  /// 射影後ベクトルの長さが0（このベクトルがnormalと平行、
  /// またはゼロベクトル）の場合はゼロベクトルを返します。
  ///
  /// normalは正規化されている必要はありません。
  ///
  /// * [normal] : plane normal defining the projection plane (it will be normalized internally).
  Sp3dV3D directionOnPlane(Sp3dV3D normal) {
    // すでに projectOnPlane 内で normal の長さチェックと射影計算が完結している
    final p = projectOnPlane(normal);
    final len = p.len();
    // 射影後の長さが 0（元のベクトルが法線と平行）ならゼロベクトルを返す
    if (len == 0) return Sp3dV3D.zero();
    return p / len;
  }

  /// (en) Returns the unsigned angle in radians between vectors a and b
  /// after projecting both onto the plane defined by the given normal.
  /// The result range is [0, pi].
  ///
  /// This ignores components along the normal direction and measures
  /// the angle within the plane only.
  ///
  /// Input vectors do not need to be normalized.
  /// If either projected vector has zero length, 0 is returned.
  ///
  /// (ja) ベクトルaとbを指定した法線normalの平面へ射影した後、
  /// 平面内での無符号角度（ラジアン）を返します。
  /// 戻り値の範囲は [0, π] です。
  ///
  /// normal方向成分は無視され、平面内の角度のみを計算します。
  ///
  /// 入力ベクトルは正規化されている必要はありません。
  /// 射影後ベクトルの長さが0の場合は 0 を返します。
  ///
  /// * [a] : First vector (it will be projected onto the plane).
  /// * [b] : Second vector (it will be projected onto the plane).
  /// * [normal] : Plane normal defining the projection plane (it will be normalized internally).
  static double angleOnPlane(Sp3dV3D a, Sp3dV3D b, Sp3dV3D normal) {
    final nLen = normal.len();
    if (nLen == 0) return 0.0;
    // normalを正規化（正しい射影計算のため）
    final n = normal / nLen;
    // 平面への射影
    final pa = a - n * Sp3dV3D.dot(a, n);
    final pb = b - n * Sp3dV3D.dot(b, n);
    // 射影後の長さが0なら0を返す
    if (pa.len() == 0 || pb.len() == 0) return 0.0;
    return angle(pa, pb);
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
    assert(
      (norV.len() - 1.0).abs() < 1e-6,
      'norV must be normalized',
    );
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

  /// (en) Rotates this vector about the specified center.
  ///
  /// (ja) 指定された中心を原点としてこのベクトルを回転します。
  ///
  /// * [center] : center of rotation.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dV3D rotateBy(
    Sp3dV3D center,
    Sp3dV3D norAxis,
    double radian,
  ) {
    Sp3dV3D c = rotatedBy(center, norAxis, radian);
    x = c.x;
    y = c.y;
    z = c.z;
    return this;
  }

  /// (en) Returns a new vector that is this vector rotated around
  /// the specified center.
  ///
  /// (ja) 指定された中心を原点としてこのベクトルを回転した新しいベクトルを返します。
  ///
  /// * [center] : center of rotation.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dV3D rotatedBy(
    Sp3dV3D center,
    Sp3dV3D norAxis,
    double radian,
  ) {
    return (this - center).rotated(norAxis, radian) + center;
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
    // 1. 同一インスタンスなら即座に true
    if (identical(this, other)) return true;
    // 2. 絶対値（abs）を使って「差が eRange 以内か」を判定
    return (x - other.x).abs() <= eRange &&
        (y - other.y).abs() <= eRange &&
        (z - other.z).abs() <= eRange;
  }

  @override
  String toString() {
    return '[$x,$y,$z]';
  }

  @override
  bool operator ==(Object other) {
    // 1. 同一インスタンスなら即座に true
    if (identical(this, other)) return true;
    // 2. 型チェックと値の比較
    return other is Sp3dV3D &&
        runtimeType == other.runtimeType &&
        x == other.x &&
        y == other.y &&
        z == other.z;
  }

  @override
  int get hashCode => Object.hash(x, y, z);
}
