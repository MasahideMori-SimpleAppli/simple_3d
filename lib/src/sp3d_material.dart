import 'dart:ui';

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
  final String version = '4';
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
        option: option != null ? {...option!} : null);
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
    return Sp3dMaterial(mbg, src['is_fill'], src['stroke_width'], msc,
        imageIndex: src['image_index'],
        textureCoordinates: tCoord,
        option: src['option']);
  }
}
