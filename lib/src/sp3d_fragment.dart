import 'sp3d_face.dart';
import 'sp3d_obj.dart';
import 'sp3d_physics.dart';
import 'sp3d_v3d.dart';

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
  final String version = '4';
  List<Sp3dFace> faces;
  bool isParticle;
  double r;
  Sp3dPhysics? physics;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [faces] : Face Object list. This includes vertex information.
  /// * [isParticle] : If true, this is particle.
  /// * [r] : Particle radius.
  /// * [physics] : Parameters for physics calculations. This defines the behavior of the fragment, not the entire object.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dFragment(this.faces,
      {this.isParticle = false, this.r = 0, this.physics, this.option});

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
    return Sp3dFragment(f,
        isParticle: src['is_particle'],
        r: src['r'],
        physics: src.containsKey('physics')
            ? src['physics'] != null
                ? Sp3dPhysics.fromDict(src['physics'])
                : null
            : null,
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
