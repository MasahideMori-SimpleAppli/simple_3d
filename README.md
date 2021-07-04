# simple_3d

The explanation is in English and Japanese.  
（日本語版は各項目の後半にあります）  

## Overview
This package is a working Dart implementation of Simple 3D Format.  
Simple 3D Format is a file format that makes it easy for non-experts to handle 3D objects.  
The file output in this format has the extension .sp3d, and the inner class convert to JSON. All the data about one object is contained in one file.  
This specification aims to minimize complexity, make it easier to read in a text editor, and make it versatile.  
Made for science, it can be difficult to use in other genres. 
For the development of science, I aim to be able to use it without being affected by interests and conflicts.

このパッケージはSimple 3D Formatの実用的なDart実装です。  
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
        [
          Sp3dFragment(
            true,
            [
              Sp3dFace(
                  [Sp3dV3D(0,0,0)],
                  0
              )
            ],
            1,
            null)
        ],
        [
          Sp3dMaterial(
              Color.fromARGB(255, 0, 255, 0),
              true,
              1,
              Color.fromARGB(255, 0, 255, 0),
              null,
              null
          )
        ],
        []);
### Convert
    final sp3dobj_d = sp3dobj.to_dict();
### Load
    final restored = Sp3dObj.from_dict(sp3dobj_d);

## Format Name
Simple 3D Format

## Filename Extension
.sp3d

## MIME Type ( Temporary )
model/x.sp3d

## Suitable
Science, Simple Games, etc.   
科学や簡単なゲームなどに向いています。

## Not Suitable
Advanced graphics.  
高度なグラフィックを必要とするものには向いていません。

## Structure ( Decoded object )
- Sp3dObj
    - id: String?
    - name: String?
    - fragments: List
        - fragment: Sp3dFragment
            - is_particle: bool
            - faces: List, One vertex for particle type.
                - face: Sp3dFace
                    - vertex: List, Clockwise rotation from the upper left.
                        - Sp3dV3D
                    - material_index: int?
                - r: double, Radius for particle type.
                - option: Map<String, dynamic>, Optional attributes that may be added for each app.
    - materials: List
        - material: Sp3dMaterial
            - bg: Color, argb.
            - is_fill: bool, if false, stroke line only.
            - stroke_width: double
            - stroke_color: Color, argb
            - image_index: int?, Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the clockwise order as the vertices from the upper left.
            - option: Map<String, dynamic>, Optional attributes that may be added for each app.
    - images: list
        - image: Uint8List, png data.

## License
This software is released under the MIT License, see LICENSE file.  
このソフトウェアはMITライセンスの元配布されます。LICENSEファイルの内容をご覧ください。

## Copyright notice
The “Dart” name and logo are trademarks of Google LLC.