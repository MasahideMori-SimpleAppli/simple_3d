import 'dart:typed_data';
import 'dart:convert';

import 'package:file_state_manager/file_state_manager.dart';
import 'package:simple_3d/src/sp3d_fragment_list.dart';
import 'package:simple_3d/src/sp3d_material_list.dart';
import 'package:simple_3d/src/sp3d_v3d_list.dart';
import 'package:simple_3d/simple_3d.dart';

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
class Sp3dObj extends CloneableFile {
  static const className = 'Sp3dObj';
  static const version = '22';
  late List<Sp3dV3D> vertices;
  late List<Sp3dFragment> fragments;
  late List<Sp3dMaterial> materials;
  late List<Uint8List> images;
  String? id;
  String? name;
  String? author;
  Sp3dPhysics? physics;
  Map<String, dynamic>? option;
  late int layerNum;
  late EnumSp3dDrawMode drawMode;

  /// Constructor
  /// * [vertices] : vertex list.
  /// * [fragments] : This includes information such as the vertex information of the object.
  /// * [materials] : This includes information such as colors.
  /// * [images] : Image data.
  /// * [id] : Object ID.
  /// * [name] : Object name.
  /// * [author] : Object author name. It is mainly for distribution, and null is better during calculation.
  /// * [physics] : Parameters for physics calculations.
  /// * [option] : Optional attributes that may be added for each app.
  /// * [layerNum] : If the renderer has layerNum enabled,
  /// it forces the drawing order to be in ascending order of this value.
  /// * [drawMode] : Specifies the drawing mode when rendering.
  /// Specify rect when speed is required but 3D structure is not required,
  /// such as scatter plots.
  Sp3dObj(this.vertices, this.fragments, this.materials, this.images,
      {this.id,
      this.name,
      this.author,
      this.physics,
      this.option,
      this.layerNum = 0,
      this.drawMode = EnumSp3dDrawMode.normal});

  /// Deep copy the object.
  @override
  Sp3dObj clone() {
    return deepCopy();
  }

  /// Deep copy the object.
  Sp3dObj deepCopy() {
    List<Sp3dV3D> v = [];
    for (var i in vertices) {
      v.add(i.deepCopy());
    }
    List<Sp3dFragment> frgs = [];
    for (var i in fragments) {
      frgs.add(i.deepCopy());
    }
    List<Sp3dMaterial> mtrs = [];
    for (var i in materials) {
      mtrs.add(i.deepCopy());
    }
    List<Uint8List> imgs = [];
    for (Uint8List i in images) {
      imgs.add(Uint8List.fromList(List<int>.from(i)));
    }
    return Sp3dObj(v, frgs, mtrs, imgs,
        id: id,
        name: name,
        author: author,
        physics: physics?.deepCopy(),
        option: option != null ? {...option!} : null,
        layerNum: layerNum,
        drawMode: drawMode);
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  factory Sp3dObj.fromDict(Map<String, dynamic> src) {
    if ((int.tryParse(src['version']) ?? 0) <= 20) {
      return Sp3dObj.fromDictV14(src);
    } else {
      List<Uint8List> imgs = [];
      for (String i in src['images']) {
        imgs.add(Uint8List.fromList(base64.decode(i)));
      }
      return Sp3dObj(
        Sp3dV3DList.fromDict(src).vertices,
        Sp3dFragmentList.fromDict(src).fragments,
        Sp3dMaterialList.fromDict(src).materials,
        imgs,
        id: src['id'],
        name: src['name'],
        author: src['author'],
        physics: src['physics'] != null
            ? Sp3dPhysics.fromDict(src['physics'])
            : null,
        option: src['option'],
        layerNum: src['layerNum'],
        drawMode: EnumSp3dDrawMode.values.byName(src['drawMode']),
      );
    }
  }

  /// Convert the object to a dictionary.
  @override
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['className'] = className;
    d['version'] = version;
    d['vertices'] = Sp3dV3DList(vertices).toDict();
    d['fragments'] = Sp3dFragmentList(fragments).toDict();
    d['materials'] = Sp3dMaterialList(materials).toDict();
    List<String> imgs = [];
    for (Uint8List i in images) {
      imgs.add(base64.encode(List<int>.from(i)));
    }
    d['images'] = imgs;
    d['id'] = id;
    d['name'] = name;
    d['author'] = author;
    d['physics'] = physics?.toDict();
    d['option'] = option;
    d['layerNum'] = layerNum;
    d['drawMode'] = drawMode.name;
    return d;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  Sp3dObj.fromDictV14(Map<String, dynamic> src) {
    vertices = Sp3dV3DList.fromDictV14(src).vertices;
    fragments = Sp3dFragmentList.fromDictV14(src).fragments;
    materials = Sp3dMaterialList.fromDictV14(src).materials;
    List<Uint8List> imgs = [];
    if ((double.tryParse(src['version']) ?? 0) >= 9) {
      for (String i in src['images']) {
        imgs.add(Uint8List.fromList(base64.decode(i)));
      }
    } else {
      for (List<dynamic> i in src['images']) {
        List<int> iL = [];
        for (dynamic j in i) {
          iL.add(j as int);
        }
        imgs.add(Uint8List.fromList(iL));
      }
    }
    images = imgs;
    id = src['id'];
    name = src['name'];
    author = src.containsKey('author') ? src['author'] : null;
    physics = src.containsKey('physics')
        ? src['physics'] != null
            ? Sp3dPhysics.fromDictV14(src['physics'])
            : null
        : null;
    option = src['option'];
    layerNum = src.containsKey('layer_num') ? src['layer_num'] : 0;
    EnumSp3dDrawMode? nDrawMode;
    if (src.containsKey('draw_mode')) {
      if (src['version'] == "10") {
        nDrawMode = src['draw_mode'] == 0
            ? EnumSp3dDrawMode.normal
            : EnumSp3dDrawMode.rect;
      } else {
        nDrawMode = EnumSp3dDrawMode.values.byName(src['draw_mode']);
      }
    }
    drawMode = nDrawMode ?? EnumSp3dDrawMode.normal;
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  Map<String, dynamic> toDictV14() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = "20";
    d['vertices'] = Sp3dV3DList(vertices).toDictV14();
    d['fragments'] = Sp3dFragmentList(fragments).toDictV14();
    d['materials'] = Sp3dMaterialList(materials).toDictV14();
    List<String> imgs = [];
    for (Uint8List i in images) {
      imgs.add(base64.encode(List<int>.from(i)));
    }
    d['images'] = imgs;
    d['id'] = id;
    d['name'] = name;
    d['author'] = author;
    d['physics'] = physics?.toDictV14();
    d['option'] = option;
    d['layer_num'] = layerNum;
    d['draw_mode'] = drawMode.name;
    return d;
  }

  /// (en)Adds the specified vector to all vectors of this object.
  ///
  /// (ja)このオブジェクトの全てのベクトルに指定したベクトルを加算します。
  ///
  /// * [v] : vector.
  Sp3dObj move(Sp3dV3D v) {
    for (Sp3dV3D i in vertices) {
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
    for (Sp3dV3D i in vertices) {
      i.rotate(norAxis, radian);
    }
    return this;
  }

  /// (en)Rotates all vectors of this object based on the specified axis.
  /// Unlike rotate, rotateInPlace performs the rotation around the mean coordinates of this object.
  ///
  /// (ja)このオブジェクトの全てのベクトルを指定した軸をベースに回転させます。
  /// rotateとは異なり、rotateInPlace はこのオブジェクトの平均座標を原点として回転が実行されます。
  ///
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dObj rotateInPlace(Sp3dV3D norAxis, double radian) {
    final Sp3dV3D center = getCenter();
    final Sp3dV3D diff = Sp3dV3D(0, 0, 0) - center;
    move(diff);
    rotate(norAxis, radian);
    move(diff * -1);
    return this;
  }

  /// (en)Rotates all vectors of this object based on the specified axis.
  /// This method allows you to rotate this object around any point.
  ///
  /// (ja)このオブジェクトの全てのベクトルを指定した軸をベースに回転させます。
  /// このメソッドを用いると、任意の点を中心としてこのオブジェクトを回転できます。
  ///
  /// * [center] : center of rotation.
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dObj rotateBy(Sp3dV3D center, Sp3dV3D norAxis, double radian) {
    final Sp3dV3D diff = Sp3dV3D(0, 0, 0) - center;
    move(diff);
    rotate(norAxis, radian);
    move(diff * -1);
    return this;
  }

  /// (en)Merge another object into this object. This operation is high cost.
  /// id, name, author, physics, option, layerNum and drawMode values do not change.
  ///
  /// (ja)このオブジェクトに別のオブジェクトをマージします。この操作は高コストです。
  /// このオブジェクト固有のパラメータ（id,name,author,physics）とオプション値、
  /// layerNum、drawModeは変更されません。
  ///
  /// * [other] : other obj.
  Sp3dObj merge(Sp3dObj other) {
    Sp3dObj copyOther = other.deepCopy();
    // 追加する各要素のインデックスを変更。
    final int myVerticesLen = vertices.length;
    final int myMaterialLen = materials.length;
    final int myImageLen = images.length;
    for (Sp3dMaterial i in copyOther.materials) {
      if (i.imageIndex != null) {
        i.imageIndex = i.imageIndex! + myImageLen;
      }
    }
    for (Sp3dFragment i in copyOther.fragments) {
      for (Sp3dFace j in i.faces) {
        if (j.materialIndex != null) {
          j.materialIndex = j.materialIndex! + myMaterialLen;
        }
        for (int k = 0; k < j.vertexIndexList.length; k++) {
          j.vertexIndexList[k] += myVerticesLen;
        }
      }
    }
    // 追加
    for (Uint8List i in copyOther.images) {
      images.add(i);
    }
    for (Sp3dMaterial i in copyOther.materials) {
      materials.add(i);
    }
    for (Sp3dV3D i in copyOther.vertices) {
      vertices.add(i);
    }
    for (Sp3dFragment i in copyOther.fragments) {
      fragments.add(i);
    }
    return this;
  }

  /// (en)Gets the average coordinates of this object.
  ///
  /// (ja)このオブジェクトの平均座標を取得します。
  Sp3dV3D getCenter() {
    return Sp3dV3D.ave(vertices);
  }

  /// (en)Flips the orientation of all faces.
  ///
  /// (ja)保持している全ての面の向きを反転します。
  void reverse() {
    for (Sp3dFragment i in fragments) {
      i.reverse();
    }
  }

  /// (en)Creates and returns a new object with all faces flipped.
  ///
  /// (ja)全ての面の向きを反転した新しいオブジェクトを作成して返します。
  Sp3dObj reversed() {
    Sp3dObj r = deepCopy();
    r.reverse();
    return r;
  }

  /// (en)Change the isTouchable flag of all fragments of this object.
  ///
  /// (ja)このオブジェクトの全てのフラグメントのタッチ可能フラグを一括で変更します。
  ///
  /// * [isTouchable] : If false, rendered this object will be excluded from touche calculation.
  ///
  /// Returns: This object.
  Sp3dObj setIsTouchableFlags(bool isTouchable) {
    for (Sp3dFragment i in fragments) {
      i.isTouchable = isTouchable;
    }
    return this;
  }

  /// (en) Add vertices to this object and returns the corresponding index.
  ///
  /// (ja) このオブジェクトに頂点を追加し、対応するインデックスを返します。
  ///
  /// * [v] : The vertices you want to add to this object.
  ///
  List<int> addVertices(List<Sp3dV3D> v) {
    final int nowLen = vertices.length;
    List<int> r = [];
    for (int i = 0; i < v.length; i++) {
      vertices.add(v[i]);
      r.add(nowLen + i);
    }
    return r;
  }

  /// (en) Add Sp3dMaterials to this object and returns the corresponding index.
  /// This method will add the material as is even if it already exists.
  ///
  /// (ja) このオブジェクトにSp3dMaterialを追加し、対応するインデックスを返します。
  /// このメソッドは既に存在するマテリアルの場合でもそのまま追加します。
  ///
  /// * [m] : The Sp3dMaterials you want to add to this object.
  ///
  List<int> addMaterials(List<Sp3dMaterial> m) {
    final int nowLen = materials.length;
    List<int> r = [];
    for (int i = 0; i < m.length; i++) {
      materials.add(m[i]);
      r.add(nowLen + i);
    }
    return r;
  }

  /// (en) Add Sp3dMaterial to this object and returns the corresponding index.
  /// This method returns the index of the specified material
  /// if it already exists and does not add a new material.
  /// Adds the specified material if it does not already exist
  /// and returns its index.
  /// Please note that materials are compared on the basis of
  /// content equivalence.
  ///
  /// (ja) このオブジェクトにSp3dMaterialを追加し、対応するインデックスを返します。
  /// このメソッドは、指定されたマテリアルが既に存在する場合はそのインデックスを返し、
  /// 新しいマテリアルは追加しません。
  /// 指定されたマテリアルがまだ存在しない場合は追加し、そのインデックスを返します。
  /// マテリアルの比較は内容の等価性を基準に行われることに注意してください。
  ///
  /// * [m] : The Sp3dMaterial you want to add to this object.
  ///
  int addMaterialIfNeeded(Sp3dMaterial m) {
    final int r = materials.indexOf(m);
    if (r < 0) {
      final int nowLen = materials.length;
      materials.add(m);
      return nowLen;
    } else {
      return r;
    }
  }

  /// (en) Appends image data to this object and returns the corresponding index.
  /// This method adds image data as is even if it already exists.
  ///
  /// (ja) このオブジェクトに画像データを追加し、対応するインデックスを返します。
  /// このメソッドは既に存在する画像データの場合でもそのまま追加します。
  ///
  /// * [images] : The images you want to add to this object.
  ///
  List<int> addImages(List<Uint8List> images) {
    final int nowLen = images.length;
    List<int> r = [];
    for (int i = 0; i < images.length; i++) {
      images.add(images[i]);
      r.add(nowLen + i);
    }
    return r;
  }

  /// (en) Resizes the object to the specified magnification based on
  /// the center of the object.
  ///
  /// (ja) オブジェクトの中心を基準に、指定した倍率にリサイズします。
  ///
  /// * [mag] : Magnification when enlarging.
  ///
  /// Returns : This object.
  Sp3dObj resize(double mag) {
    final Sp3dV3D c = getCenter();
    for (Sp3dV3D i in vertices) {
      i.set(c + (i - c) * mag);
    }
    return this;
  }

  /// (en) Remove unused vertices, materials, and images and adjust internal indexes.
  /// Please note that this method is processing intensive.
  /// Also, please note that the vertices and material index in Sp3dFace,
  /// and the image index of Sp3dMaterial will be changed.
  ///
  /// (ja) 使用していない頂点、マテリアル、画像を破棄し、内部のインデックスを調整します。
  /// このメソッドは処理が重いため注意してください。
  /// また、Sp3dFace内の頂点及びSp3dMaterialのインデックス、
  /// Sp3dMaterial内の画像インデックスが変更されるため注意してください。
  ///
  /// Returns : This object.
  Sp3dObj cleaning() {
    // 処理を簡単にするため、全てのインデックスは後ろから調査する。
    // まず、全ての面を取得する。
    List<Sp3dFace> allFaces = [];
    for (Sp3dFragment i in fragments) {
      allFaces.addAll(i.faces);
    }
    // 使用していない画像を調査し、存在した場合は削除。
    List<bool> imageUses = [];
    for (int i = 0; i < images.length; i++) {
      imageUses.add(false);
    }
    // 高速化のための、修正が必要な可能性のあるFaceのバッファ。
    List<Sp3dFace> imageIndexTargets = [];
    List<Sp3dFace> materialIndexTargets = [];
    for (Sp3dFace i in allFaces) {
      if (i.materialIndex != null) {
        materialIndexTargets.add(i);
        if (materials[i.materialIndex!].imageIndex != null) {
          imageUses[materials[i.materialIndex!].imageIndex!] = true;
          imageIndexTargets.add(i);
        }
      }
    }
    // 未使用のものを削除しつつ、インデックスを修正する。
    for (int i = imageUses.length - 1; i >= 0; i--) {
      if (!imageUses[i]) {
        images.removeAt(i);
        for (Sp3dFace j in imageIndexTargets) {
          if (materials[j.materialIndex!].imageIndex! > i) {
            materials[j.materialIndex!].imageIndex =
                materials[j.materialIndex!].imageIndex! - 1;
          }
        }
      }
    }
    // 使用していないマテリアルを調査し、存在した場合は削除。
    List<bool> materialUses = [];
    for (int i = 0; i < materials.length; i++) {
      materialUses.add(false);
    }
    for (Sp3dFace i in materialIndexTargets) {
      materialUses[i.materialIndex!] = true;
    }
    // 未使用のものを削除しつつ、インデックスを修正する。
    for (int i = materialUses.length - 1; i >= 0; i--) {
      if (!materialUses[i]) {
        materials.removeAt(i);
        for (Sp3dFace j in materialIndexTargets) {
          if (j.materialIndex! > i) {
            j.materialIndex = j.materialIndex! - 1;
          }
        }
      }
    }
    // 使用していない頂点を調査し、存在した場合は削除。
    List<bool> verticesUses = [];
    for (int i = 0; i < vertices.length; i++) {
      verticesUses.add(false);
    }
    for (Sp3dFace i in allFaces) {
      for (int index in i.vertexIndexList) {
        verticesUses[index] = true;
      }
    }
    // 未使用のものを削除しつつ、インデックスを修正する。
    for (int i = verticesUses.length - 1; i >= 0; i--) {
      if (!verticesUses[i]) {
        vertices.removeAt(i);
        for (Sp3dFace j in allFaces) {
          for (int k = 0; k < j.vertexIndexList.length; k++) {
            if (j.vertexIndexList[k] > i) {
              j.vertexIndexList[k] = j.vertexIndexList[k] - 1;
            }
          }
        }
      }
    }
    return this;
  }

  /// (en) Creates and returns a new Sp3dObj
  /// that consists of a copy of the specified fragment.
  ///
  /// (ja) 指定されたフラグメントのコピーから構成される、新しいSp3dObjを生成して返します。
  ///
  /// * [targets] : The copy target fragments.
  Sp3dObj clonePart(List<Sp3dFragment> targets) {
    // Key is pre index, Value is new index.
    Map<int, int> verticesMap = {};
    Map<int, int> materialMap = {};
    Map<int, int> imageMap = {};
    Sp3dObj r = Sp3dObj([], [], [], []);
    // clone
    for (Sp3dFragment i in targets) {
      r.fragments.add(i.deepCopy());
      for (int preIndex in i.getUniqueVerticesIndexes()) {
        if (!verticesMap.containsKey(preIndex)) {
          final newIndex = r.vertices.length;
          r.vertices.add(vertices[preIndex].deepCopy());
          verticesMap[preIndex] = newIndex;
        }
      }
      for (int preIndex in i.getUniqueMaterialIndexes()) {
        if (!materialMap.containsKey(preIndex)) {
          final newIndex = r.materials.length;
          r.materials.add(materials[preIndex].deepCopy());
          materialMap[preIndex] = newIndex;
        }
        final int? preImageIndex = materials[preIndex].imageIndex;
        if (preImageIndex != null) {
          if (!imageMap.containsKey(preImageIndex)) {
            final newIndex = r.images.length;
            r.images
                .add(Uint8List.fromList(List<int>.from(images[preImageIndex])));
            imageMap[preImageIndex] = newIndex;
          }
        }
      }
    }
    // update indexes
    for (Sp3dFragment i in r.fragments) {
      i.updateVerticesIndexes(verticesMap);
      i.updateMaterialIndexes(materialMap);
    }
    for (Sp3dMaterial i in r.materials) {
      i.updateImageIndexes(imageMap);
    }
    return r;
  }
}
