import 'dart:ui';
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
  static const String version = '7';
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
    var mbg = Color.fromARGB(bg.alpha, bg.red, bg.green, bg.blue);
    var msc = Color.fromARGB(strokeColor.alpha, strokeColor.red,
        strokeColor.green, strokeColor.blue);
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
            Color.fromARGB(
                this.bg.alpha, this.bg.red, this.bg.green, this.bg.blue),
        isFill ?? this.isFill,
        strokeWidth ?? this.strokeWidth,
        strokeColor ??
            Color.fromARGB(this.strokeColor.alpha, this.strokeColor.red,
                this.strokeColor.green, this.strokeColor.blue),
        imageIndex: imageIndex ?? this.imageIndex,
        textureCoordinates: textureCoordinates ?? tCoord,
        name: name ?? this.name,
        option: option ?? (option != null ? {...option} : null));
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
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
    d['version'] = version;
    d['bg'] = [bg.alpha, bg.red, bg.green, bg.blue];
    d['is_fill'] = isFill;
    d['stroke_width'] = strokeWidth;
    d['stroke_color'] = [
      strokeColor.alpha,
      strokeColor.red,
      strokeColor.green,
      strokeColor.blue
    ];
    d['image_index'] = imageIndex;
    d['texture_coordinates'] = tCoord;
    d['name'] = name;
    d['option'] = option;
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

  /// calculate hash code for map.
  int _calculateMapHashCode(Map<String, dynamic> m) {
    int r = 0;
    m.forEach((String key, dynamic value) {
      r = r ^ key.hashCode ^ (value?.hashCode ?? 0);
    });
    return r;
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
      objects.add(_calculateMapHashCode(option!));
    } else {
      objects.add(0);
    }
    return Object.hashAll(objects);
  }
}
