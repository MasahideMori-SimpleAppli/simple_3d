import 'dart:ui';
import 'package:file_state_manager/file_state_manager.dart';
import 'package:flutter/foundation.dart';

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
  static const String className = 'Sp3dMaterial';
  static const String version = '11';
  Color bg;
  bool isFill;
  double strokeWidth;
  Color strokeColor;
  int? imageIndex;
  List<Offset>? textureCoordinates;
  String? name;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [bg] : Background color
  /// * [isFill] : If true, fill by bg color.
  /// * [strokeWidth] : Stroke width.
  /// * [strokeColor] : Stroke color.
  /// * [imageIndex] : Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the clockwise order as the vertices from the upper left.
  /// * [textureCoordinates] : You can specify the part of the image that you want to cut out and use. Use by specifying the coordinate information for the image.
  /// Specify the coordinates counterclockwise with a triangle(3 vertices) or rectangle(There are two triangles. 6 vertices).
  /// * [name] : The material name.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dMaterial(this.bg, this.isFill, this.strokeWidth, this.strokeColor,
      {this.imageIndex, this.textureCoordinates, this.name, this.option});

  /// Deep copy the object.
  Sp3dMaterial deepCopy() {
    var mbg = Color.from(alpha: bg.a, red: bg.r, green: bg.g, blue: bg.b);
    var msc = Color.from(
        alpha: strokeColor.a,
        red: strokeColor.r,
        green: strokeColor.g,
        blue: strokeColor.b);
    List<Offset>? tCoord;
    if (textureCoordinates != null) {
      tCoord = [];
      for (Offset o in textureCoordinates!) {
        tCoord.add(Offset(o.dx, o.dy));
      }
    }
    return Sp3dMaterial(mbg, isFill, strokeWidth, msc,
        imageIndex: imageIndex,
        textureCoordinates: tCoord,
        name: name,
        option: option != null ? {...option!} : null);
  }

  /// Creates a copy with only the specified values rewritten.
  /// * [bg] : Background color
  /// * [isFill] : If true, fill by bg color.
  /// * [strokeWidth] : Stroke width.
  /// * [strokeColor] : Stroke color.
  /// * [imageIndex] : Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the clockwise order as the vertices from the upper left.
  /// * [textureCoordinates] : You can specify the part of the image that you want to cut out and use. Use by specifying the coordinate information for the image.
  /// Specify the coordinates counterclockwise with a triangle(3 vertices) or rectangle(There are two triangles. 6 vertices).
  /// * [name] : The material name.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dMaterial copyWith(
      {Color? bg,
      bool? isFill,
      double? strokeWidth,
      Color? strokeColor,
      int? imageIndex,
      List<Offset>? textureCoordinates,
      String? name,
      Map<String, dynamic>? option}) {
    List<Offset>? tCoord;
    if (textureCoordinates == null) {
      if (this.textureCoordinates != null) {
        tCoord = [];
        for (Offset o in this.textureCoordinates!) {
          tCoord.add(Offset(o.dx, o.dy));
        }
      }
    }
    return Sp3dMaterial(
        bg ??
            Color.from(
                alpha: this.bg.a,
                red: this.bg.r,
                green: this.bg.g,
                blue: this.bg.b),
        isFill ?? this.isFill,
        strokeWidth ?? this.strokeWidth,
        strokeColor ??
            Color.from(
                alpha: this.strokeColor.a,
                red: this.strokeColor.r,
                green: this.strokeColor.g,
                blue: this.strokeColor.b),
        imageIndex: imageIndex ?? this.imageIndex,
        textureCoordinates: textureCoordinates ?? tCoord,
        name: name ?? this.name,
        option: option ?? (option != null ? {...option} : null));
  }

  /// Convert the object to a dictionary.
  /// Starting with simple_3d version 15,
  /// this method excludes printing of class name and version information.
  /// * [version] : The Sp3dMaterialList version.
  /// If it is 1, RGB is an Int from 0 to 255. If it is 2 or more,
  /// RGB is a floating point number with a maximum of 1.
  Map<String, dynamic> toDict({required int version}) {
    List<double>? tCoord;
    if (textureCoordinates != null) {
      tCoord = [];
      for (Offset o in textureCoordinates!) {
        tCoord.add(o.dx);
        tCoord.add(o.dy);
      }
    }
    Map<String, dynamic> d = {};
    if (version == 1) {
      d['bg'] = [
        (bg.a * 255).round(),
        (bg.r * 255).round(),
        (bg.g * 255).round(),
        (bg.b * 255).round()
      ];
      d['strokeColor'] = [
        (strokeColor.a * 255).round(),
        (strokeColor.r * 255).round(),
        (strokeColor.g * 255).round(),
        (strokeColor.b * 255).round()
      ];
    } else {
      d['bg'] = [bg.a, bg.r, bg.g, bg.b];
      d['strokeColor'] = [
        strokeColor.a,
        strokeColor.r,
        strokeColor.g,
        strokeColor.b
      ];
    }
    d['isFill'] = isFill;
    d['strokeWidth'] = strokeWidth;
    d['imageIndex'] = imageIndex;
    d['textureCoordinates'] = tCoord;
    d['name'] = name;
    d['option'] = option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  /// * [version] : The Sp3dMaterialList version.
  /// If it is 1, RGB is an Int from 0 to 255. If it is 2 or more,
  /// RGB is a floating point number with a maximum of 1.
  static Sp3dMaterial fromDict(Map<String, dynamic> src, int version) {
    late Color mbg;
    late Color msc;
    if (version == 1) {
      mbg = Color.fromARGB(
          src['bg'][0], src['bg'][1], src['bg'][2], src['bg'][3]);
      msc = Color.fromARGB(src['strokeColor'][0], src['strokeColor'][1],
          src['strokeColor'][2], src['strokeColor'][3]);
    } else {
      mbg = Color.from(
          alpha: src['bg'][0],
          red: src['bg'][1],
          green: src['bg'][2],
          blue: src['bg'][3]);
      msc = Color.from(
          alpha: src['strokeColor'][0],
          red: src['strokeColor'][1],
          green: src['strokeColor'][2],
          blue: src['strokeColor'][3]);
    }
    List<Offset>? tCoord;
    if (src['textureCoordinates'] != null) {
      tCoord = [];
      List<double> cBuff = [];
      for (double d in src['textureCoordinates']) {
        cBuff.add(d);
        if (cBuff.length == 2) {
          tCoord.add(Offset(cBuff[0], cBuff[1]));
          cBuff.clear();
        }
      }
    }
    return Sp3dMaterial(mbg, src['isFill'], src['strokeWidth'], msc,
        imageIndex: src['imageIndex'],
        textureCoordinates: tCoord,
        name: src['name'],
        option: src['option']);
  }

  /// Convert the object to a dictionary.
  /// This is a compatibility call for older versions.
  Map<String, dynamic> toDictV14() {
    List<double>? tCoord;
    if (textureCoordinates != null) {
      tCoord = [];
      for (Offset o in textureCoordinates!) {
        tCoord.add(o.dx);
        tCoord.add(o.dy);
      }
    }
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = "9";
    d['bg'] = [
      (bg.a * 255).round(),
      (bg.r * 255).round(),
      (bg.g * 255).round(),
      (bg.b * 255).round()
    ];
    d['is_fill'] = isFill;
    d['stroke_width'] = strokeWidth;
    d['stroke_color'] = [
      (strokeColor.a * 255).round(),
      (strokeColor.r * 255).round(),
      (strokeColor.g * 255).round(),
      (strokeColor.b * 255).round()
    ];
    d['image_index'] = imageIndex;
    d['texture_coordinates'] = tCoord;
    d['name'] = name;
    d['option'] = option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// This is a compatibility call for older versions.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dMaterial fromDictV14(Map<String, dynamic> src) {
    var mbg =
        Color.fromARGB(src['bg'][0], src['bg'][1], src['bg'][2], src['bg'][3]);
    var msc = Color.fromARGB(src['stroke_color'][0], src['stroke_color'][1],
        src['stroke_color'][2], src['stroke_color'][3]);
    List<Offset>? tCoord;
    if (src.containsKey('texture_coordinates')) {
      if (src['texture_coordinates'] != null) {
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
    }
    // After version 7.
    String? mName;
    if (src.containsKey('name')) {
      mName = src['name'];
    }
    return Sp3dMaterial(mbg, src['is_fill'], src['stroke_width'], msc,
        imageIndex: src['image_index'],
        textureCoordinates: tCoord,
        name: mName,
        option: src['option']);
  }

  /// (en) Updates the image indexes.
  ///
  /// (ja) 画像のインデックスを更新します。
  ///
  /// * [updateMap] : The key is the index before the update,
  /// and the value is the index after the update.
  void updateImageIndexes(Map<int, int> updateMap) {
    if (imageIndex != null) {
      if (updateMap.containsKey(imageIndex!)) {
        imageIndex = updateMap[imageIndex!];
      }
    }
  }

  /// Identity check function of textureCoordinates.
  bool _checkTextureCoordinates(Sp3dMaterial other) {
    if (textureCoordinates == null && other.textureCoordinates == null) {
      return true;
    }
    if (textureCoordinates != null && other.textureCoordinates != null) {
      final int myTCLen = textureCoordinates!.length;
      final int otherTCLen = other.textureCoordinates!.length;
      if (myTCLen != otherTCLen) {
        return false;
      } else {
        for (int i = 0; i < myTCLen; i++) {
          if (textureCoordinates![i] != other.textureCoordinates![i]) {
            return false;
          }
        }
        return true;
      }
    }
    return false;
  }

  @override
  bool operator ==(Object other) {
    if (other is Sp3dMaterial) {
      return bg == other.bg &&
          isFill == other.isFill &&
          strokeWidth == other.strokeWidth &&
          strokeColor == other.strokeColor &&
          imageIndex == other.imageIndex &&
          _checkTextureCoordinates(other) &&
          name == other.name &&
          mapEquals(option, other.option);
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    List<Object> objects = [];
    objects.add(bg);
    objects.add(isFill);
    objects.add(strokeWidth);
    objects.add(strokeColor);
    objects.add(imageIndex != null ? imageIndex! : 0);
    if (textureCoordinates != null) {
      objects.addAll(textureCoordinates!);
    } else {
      objects.add(0);
    }
    objects.add(name != null ? name! : 0);
    if (option != null) {
      objects.add(UtilObjectHash.calcMap(option!));
    } else {
      objects.add(0);
    }
    return Object.hashAll(objects);
  }
}
