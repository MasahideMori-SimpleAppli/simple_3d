# simple_3d

(en)The explanation is in English and Japanese.  
(ja)日本語版は(ja)として記載してあります。

## Overview
(en)This package is a working Flutter(Dart) implementation of Simple 3D Format.  
Simple 3D Format is a file format that makes it easy for non-experts to handle 3D objects.  
The file output in this format has the extension .sp3d, and the inner class convert to JSON. All the data about one object is contained in one file.  
This specification aims to minimize complexity, make it easier to read in a text editor, and make it versatile.  
Made for science, it can be difficult to use in other genres. 
For the development of science, I aim to be able to use it without being affected by interests and conflicts.

(ja)このパッケージはSimple 3D Formatの実用的なFlutter(Dart)実装です。  
Simple 3D Formatは、3次元オブジェクトを専門家以外でも手軽に扱えるようにするためのファイル・フォーマットです。  
このフォーマットで出力されたファイルは拡張子.sp3dを持ち、内部クラスがJSONに変換されます。１つのオブジェクトに関する全てのデータが１つのファイル内に含まれています。
この仕様は様々な用途に使用できるように複雑さを最小限に抑え、かつ簡単にテキストエディタで内容が確認できることを目的としています。  
科学の為に作られたので、他のジャンルで使いにくい可能性があります。  
科学の発展のため、利権や争いなどに影響されずに利用できることを目指しています。

## Usage
### Create Data
    final sp3dobj = Sp3dObj(
        "1",
        "test",
        [Sp3dV3D(0, 0, 0)],
        [
          Sp3dFragment(
              true,
              [
                Sp3dFace([0], 0)
              ],
              1,
              null)
        ],
        [
          Sp3dMaterial(Color.fromARGB(255, 0, 255, 0), true, 1,
              Color.fromARGB(255, 0, 255, 0), null, null)
        ],
        [],
        null);
### Convert
    final sp3dobj_d = sp3dobj.to_dict();
### Load
    final restored = Sp3dObj.from_dict(sp3dobj_d);

## About future development
(en)I'm developing a package to easily create some geometry and a package to easily screen Sp3dObj. Please wait.  
(ja)いくつかのジオメトリを簡単に作成するためのパッケージと、Sp3dObjを簡単に画面表示するためのパッケージを開発中です。公開までしばらくお待ちください。

## Format Name
Simple 3D Format

## Filename Extension
.sp3d

## MIME Type ( Temporary )
model/x.sp3d

## Suitable
(en)Science, Simple Games, etc.   
(ja)科学や簡単なゲームなどに向いています。

## Not Suitable
(en)Advanced graphics.  
(ja)高度なグラフィックを必要とするものには向いていません。

## Structure ( Decoded object )
- Sp3dObj
    - id: String?
    - name: String?
    - vertices: List
        - v: Sp3dV3D
    - fragments: List
        - fragment: Sp3dFragment
            - is_particle: bool
            - faces: List, One vertex for particle type.
                - face: Sp3dFace
                    - vertex_index_list: List, Vertices index. Counterclockwise rotation from the upper left.
                        - index: int
                    - material_index: int?
                - r: double, Radius for particle type.
                - option: Map<String, dynamic>, Optional attributes that may be added for each app.
    - materials: List
        - material: Sp3dMaterial
            - bg: Color, argb.
            - is_fill: bool, if false, stroke line only.
            - stroke_width: double
            - stroke_color: Color, argb
            - image_index: int?, Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the Counterclockwise order as the vertices from the upper left.
            - option: Map<String, dynamic>, Optional attributes that may be added for each app.
    - images: list
        - image: Uint8List, png data.
    - option: Map<String, dynamic>, Optional attributes that may be added for each app.

## About version control
(en)It is as follows in version 3.1.0 or later.  
The C part will be changed at the time of version upgrade.
- Changes such as adding variables, structure change that cause problems when reading previous files. 
  - C.X.X
- Adding methods, etc. 
  - X.C.X
- Minor changes and bug fixes. 
  - X.X.C
  
(ja)バージョン3.1.0以降において以下のようになっています。  
それぞれ、Cの部分が変更されます。
- 変数の追加など、以前のファイルの読み込み時に問題が起こったり、ファイルの構造が変わるような変更 
  - C.X.X
- メソッドの追加など 
  - X.C.X
- 軽微な変更やバグ修正 
  - X.X.C

## License
(en)This software is released under the MIT License, see LICENSE file.  
(ja)このソフトウェアはMITライセンスの元配布されます。LICENSEファイルの内容をご覧ください。

## Copyright notice
The “Dart” name and “Flutter” name are trademarks of Google LLC.  
*The developer of this package is not Google LLC.
