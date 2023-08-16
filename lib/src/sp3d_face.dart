import 'sp3d_obj.dart';
import 'sp3d_v3d.dart';

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
  final String version = '9';
  List<int> vertexIndexList;
  int? materialIndex;

  /// Constructor
  /// * [vertexIndexList] : 3D vertex index list.
  /// * [materialIndex] : use material index. If null, disable.
  Sp3dFace(this.vertexIndexList, this.materialIndex);

  /// Deep copy the object.
  Sp3dFace deepCopy() {
    return Sp3dFace([...vertexIndexList], materialIndex);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    d['vertex_index_list'] = vertexIndexList;
    d['material_index'] = materialIndex;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dFace fromDict(Map<String, dynamic> src) {
    List<int> mVi = [];
    for (dynamic i in src['vertex_index_list']) {
      mVi.add(i as int);
    }
    return Sp3dFace(mVi, src['material_index']);
  }

  /// (en)Gets the vertices of this face.
  ///
  /// (ja)この面の頂点を取得します。
  /// * [obj] : The object to which this face belongs.
  List<Sp3dV3D> getVertices(Sp3dObj obj) {
    List<Sp3dV3D> r = [];
    for (int i in vertexIndexList) {
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
    if (vertexIndexList.length > 2) {
      vertexIndexList = vertexIndexList.reversed.toList();
    }
  }

  /// (en)Returns a new face with the orientation of this face reversed.
  /// Internally, the order of the referenced indexes is reversed.
  ///
  /// (ja)この面の向きを反転した新しい面を返します。
  /// 内部的には、参照しているインデックスの順序が反転します。
  Sp3dFace reversed() {
    Sp3dFace r = deepCopy();
    r.reverse();
    return r;
  }

  /// (en)Reverse the orientation of this face.
  /// Internally, the order of 3D vectors except the beginning is reversed.
  ///
  /// (ja)この面の向きを反転します。内部では先頭を除く3Dベクトルの順番が反転します。
  void reverseFt() {
    if (vertexIndexList.length > 2) {
      List<int> nl = [];
      nl.add(vertexIndexList.removeAt(0));
      nl.addAll(vertexIndexList.reversed);
      vertexIndexList = nl;
    }
  }

  /// (en)Returns a new face with the orientation of this face reversed.
  /// Internally, the order of 3D vectors except the beginning is reversed.
  ///
  /// (ja)この面の向きを反転した新しい面を返します。内部では先頭を除く3Dベクトルの順番が反転します。
  Sp3dFace reversedFt() {
    Sp3dFace r = deepCopy();
    r.reverseFt();
    return r;
  }

  /// (en)Adds the specified vector to all vectors of this Face.
  ///
  /// (ja)この面の全てのベクトルに指定したベクトルを加算します。
  ///
  /// * [parent] : parent obj.
  /// * [v] : vector.
  Sp3dFace move(Sp3dObj parent, Sp3dV3D v) {
    for (int i in vertexIndexList) {
      parent.vertices[i].add(v);
    }
    return this;
  }

  /// (en)Rotates all vectors of this face based on the specified axis.
  ///
  /// (ja)この面の全てのベクトルを指定した軸をベースに回転させます。
  ///
  /// * [parent] : parent obj.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dFace rotate(Sp3dObj parent, Sp3dV3D norAxis, double radian) {
    for (int i in vertexIndexList) {
      parent.vertices[i].rotate(norAxis, radian);
    }
    return this;
  }

  /// (en)Rotates all vectors of this face based on the specified axis.
  /// Unlike rotate, rotateInPlace rotates around the mean coordinates of this face as the origin.
  ///
  /// (ja)この面の全てのベクトルを指定した軸をベースに回転させます。
  /// rotateとは異なり、rotateInPlace はこの面の平均座標を原点として回転します。
  ///
  /// * [parent] : parent obj.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dFace rotateInPlace(Sp3dObj parent, Sp3dV3D norAxis, double radian) {
    final Sp3dV3D center = getCenter(parent);
    final Sp3dV3D diff = Sp3dV3D(0, 0, 0) - center;
    move(parent, diff);
    rotate(parent, norAxis, radian);
    move(parent, diff * -1);
    return this;
  }

  /// (en)Gets the average coordinates of this face.
  ///
  /// (ja)この面の平均座標を取得します。
  ///
  /// * [parent] : parent obj.
  Sp3dV3D getCenter(Sp3dObj parent) {
    return Sp3dV3D.ave(getVertices(parent));
  }
}
