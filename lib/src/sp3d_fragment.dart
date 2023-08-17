import '../simple_3d.dart';

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
  final String version = '7';
  List<Sp3dFace> faces;
  bool isParticle;
  double r;
  Sp3dPhysics? physics;
  bool isTouchable;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [faces] : Face Object list. This includes vertex information.
  /// * [isParticle] : If true, this is particle.
  /// * [r] : Particle radius.
  /// * [physics] : Parameters for physics calculations.
  /// This defines the behavior of the fragment, not the entire object.
  /// * [isTouchable] : If false, rendered this fragment will be excluded　from
  /// touche calculation. Default value is true.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dFragment(this.faces,
      {this.isParticle = false,
      this.r = 0,
      this.physics,
      this.isTouchable = true,
      this.option});

  /// Deep copy the object.
  Sp3dFragment deepCopy() {
    List<Sp3dFace> f = [];
    for (var i in faces) {
      f.add(i.deepCopy());
    }
    return Sp3dFragment(f,
        isParticle: isParticle,
        r: r,
        physics: physics != null ? physics!.deepCopy() : null,
        isTouchable: isTouchable,
        option: option != null ? {...option!} : null);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    List<Map<String, dynamic>> f = [];
    for (var i in faces) {
      f.add(i.toDict());
    }
    d['faces'] = f;
    d['is_particle'] = isParticle;
    d['r'] = r;
    d['physics'] = physics != null ? physics!.toDict() : null;
    d['is_touchable'] = isTouchable;
    d['option'] = option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFragment fromDict(Map<String, dynamic> src) {
    List<Sp3dFace> f = [];
    for (var i in src['faces']) {
      f.add(Sp3dFace.fromDict(i));
    }
    // after version 5.
    bool mIsTouchable = true;
    if (src.containsKey('is_touchable')) {
      mIsTouchable = src['is_touchable'];
    }
    return Sp3dFragment(f,
        isParticle: src['is_particle'],
        r: src['r'],
        physics: src.containsKey('physics')
            ? src['physics'] != null
                ? Sp3dPhysics.fromDict(src['physics'])
                : null
            : null,
        isTouchable: mIsTouchable,
        option: src['option']);
  }

  /// (en)Adds the specified vector to all vectors of this Fragment.
  ///
  /// (ja)このフラグメントの全てのベクトルに指定したベクトルを加算します。
  ///
  /// * [parent] : parent obj.
  /// * [v] : vector.
  Sp3dFragment move(Sp3dObj parent, Sp3dV3D v) {
    for (Sp3dFace i in faces) {
      i.move(parent, v);
    }
    return this;
  }

  /// (en)Rotates all vectors of this fragment based on the specified axis.
  ///
  /// (ja)このフラグメントの全てのベクトルを指定した軸をベースに回転させます。
  ///
  /// * [parent] : parent obj.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dFragment rotate(Sp3dObj parent, Sp3dV3D norAxis, double radian) {
    for (Sp3dFace i in faces) {
      i.rotate(parent, norAxis, radian);
    }
    return this;
  }

  /// (en)Rotates all vectors of this fragment based on the specified axis.
  /// Unlike rotate, rotateInPlace will perform the rotation with
  /// this fragment's mean coordinate as the origin.
  ///
  /// (ja)このフラグメントの全てのベクトルを指定した軸をベースに回転させます。
  /// rotateとは異なり、rotateInPlace はこのフラグメントの平均座標を原点として
  /// 回転が実行されます。
  ///
  /// * [parent] : parent obj.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dFragment rotateInPlace(Sp3dObj parent, Sp3dV3D norAxis, double radian) {
    final List<Sp3dV3D> fragmentVertices = [];
    for (Sp3dFace i in faces) {
      fragmentVertices.addAll(i.getVertices(parent));
    }
    final Sp3dV3D center = Sp3dV3D.ave(fragmentVertices);
    final Sp3dV3D diff = Sp3dV3D(0, 0, 0) - center;
    _moveForRotateInPlace(fragmentVertices, diff);
    _rotateForRotateInPlace(fragmentVertices, norAxis, radian);
    _moveForRotateInPlace(fragmentVertices, diff * -1);
    return this;
  }

  /// (en)Rotates all vectors of this fragment based on the specified axis.
  /// This method allows you to rotate this fragment around any point.
  ///
  /// (ja)このフラグメントの全てのベクトルを指定した軸をベースに回転させます。
  /// このメソッドを用いると、任意の点を中心としてこのフラグメントを回転できます。
  ///
  /// * [center] : center of rotation.
  /// * [parent] : parent obj.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dFragment rotateBy(
      Sp3dV3D center, Sp3dObj parent, Sp3dV3D norAxis, double radian) {
    final List<Sp3dV3D> fragmentVertices = [];
    for (Sp3dFace i in faces) {
      fragmentVertices.addAll(i.getVertices(parent));
    }
    final Sp3dV3D diff = Sp3dV3D(0, 0, 0) - center;
    _moveForRotateInPlace(fragmentVertices, diff);
    _rotateForRotateInPlace(fragmentVertices, norAxis, radian);
    _moveForRotateInPlace(fragmentVertices, diff * -1);
    return this;
  }

  void _moveForRotateInPlace(List<Sp3dV3D> targets, Sp3dV3D v) {
    for (Sp3dV3D i in targets) {
      i.add(v);
    }
  }

  void _rotateForRotateInPlace(
      List<Sp3dV3D> targets, Sp3dV3D norAxis, double radian) {
    for (Sp3dV3D i in targets) {
      i.rotate(norAxis, radian);
    }
  }

  /// (en)Gets the average coordinates of this fragment.
  ///
  /// (ja)このフラグメントの平均座標を取得します。
  ///
  /// * [parent] : parent obj.
  Sp3dV3D getCenter(Sp3dObj parent) {
    List<Sp3dV3D> allV = [];
    for (Sp3dFace i in faces) {
      allV.addAll(i.getVertices(parent));
    }
    return Sp3dV3D.ave(allV);
  }

  /// (en)Flips the orientation of all faces.
  ///
  /// (ja)保持している全ての面の向きを反転します。
  void reverse() {
    for (Sp3dFace i in faces) {
      i.reverse();
    }
  }

  /// (en)Creates and returns a new fragment with all faces flipped.
  ///
  /// (ja)全ての面の向きを反転した新しいフラグメントを作成して返します。
  Sp3dFragment reversed() {
    Sp3dFragment r = deepCopy();
    r.reverse();
    return r;
  }
}
