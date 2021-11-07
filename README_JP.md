# simple_3d

日本語版の解説です。

## Overview
このパッケージはSimple 3D Formatの実用的なFlutter(Dart)実装です。  
Simple 3D Formatは、3次元オブジェクトを専門家以外でも手軽に扱えるようにするためのファイル・フォーマットです。  
このフォーマットで出力されたファイルは拡張子.sp3dを持ち、内部クラスがJSONに変換されます。１つのオブジェクトに関する全てのデータが１つのファイル内に含まれています。
この仕様は様々な用途に使用できるように複雑さを最小限に抑え、かつ簡単にテキストエディタで内容が確認できることを目的としています。  
科学の為に作られたので、他のジャンルで使いにくい可能性があります。  
科学の発展のため、利権や争いなどに影響されずに利用できることを目指しています。

## Usage
### Quick Start
(ja)Sp3dObjのレンダリングのためのパッケージを用意しています。  
下記のパッケージを利用すると、より簡単にご利用になれます。  
利用方法はsimple_3d_rendererパッケージをご覧ください。  

[simple_3d_renderer](https://pub.dev/packages/simple_3d_renderer)  
[util_simple_3d](https://pub.dev/packages/util_simple_3d)

### Create Data
```dart
final sp3dObj = Sp3dObj(
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
      Sp3dMaterial(Color.fromARGB(255, 0, 255, 0), true, 1, Color.fromARGB(255, 0, 255, 0))
    ],
    [],
    null);
```
### Operation example
```dart
// Move
sp3dObj.move(Sp3dV3D(1,0,0));
// Rotate
sp3dObj.rotate(Sp3dV3D(0,1,0),45*pi/180);
// Vertex manipulation
// Sp3dV3Dの機能を使うと、他にも様々なことが出来ます。
sp3dObj.vertices[0] += Sp3dV3D(1,0,0);
```
### Convert
```dart
final sp3dObjDict = sp3dObj.toDict();
```
### Load
```dart
final restored = Sp3dObj.fromDict(sp3dObjDict);
```

## Support
もし何らかの理由で有償のサポートが必要な場合は私の会社に問い合わせてください。  
このパッケージは私が個人で開発していますが、会社経由でサポートできる場合があります。  
[合同会社シンプルアプリ](https://simpleappli.com/index.html)  

## Format Name
Simple 3D Format

## Filename Extension
.sp3d

## MIME Type ( Temporary )
model/x.sp3d

## Suitable
科学や簡単なゲームなどに向いています。

## Not Suitable
高度なグラフィックを必要とするものには向いていません。

## Structure ( Decoded object )
- Sp3dObj
    - id: String?
    - name: String?
    - vertices: List
        - v: Sp3dV3D
    - fragments: List
        - fragment: Sp3dFragment
            - isParticle: bool.
            - faces: List, 面の定義です。三角メッシュまたは四角メッシュを表します。
                - face: Sp3dFace
                    - vertexIndexList: List, 頂点のインデックスリストです. 左上から逆時計回りで定義します。
                        - index: int
                    - materialIndex: int?
                - r: double, particleの場合の半径です。
                - option: Map<String, dynamic>, アプリ毎に拡張可能なオプション属性です。ただし、JSON化出来るパラメータのみ入れられます。
    - materials: List
        - material: Sp3dMaterial
            - bg: Color, argb.
            - isFill: bool, falseの場合線だけを表示します。
            - strokeWidth: double
            - strokeColor: Color, argb
            - imageIndex: int?, nullでは無い時、指定された画像でfaceを塗りつぶします。
            - textureCoordinates: List, ３点、又は６点（四角の場合、三角形２つで指定します）での、画像の切り出し位置の指定です。 
            - option: Map<String, dynamic>, アプリ毎に拡張可能なオプション属性です。ただし、JSON化出来るパラメータのみ入れられます。
    - images: list
        - image: Uint8List, png data.
    - option: Map<String, dynamic>, アプリ毎に拡張可能なオプション属性です。ただし、JSON化出来るパラメータのみ入れられます.
    
## Parameter Note
多数の原子の計算にSp3dObjを使用する場合は、isParticleフラグとr（半径）の使用を検討してください。  
各原子は計算または保存時に1つの頂点を持ち、画面上に描画する場合にのみUtil_Sp3dGeometryなどを使用して球を描画することが出来ます。  
（つまり、描画の時には新しいSp3dObjを作ります）。  

## About version control
バージョン3.1.0以降において以下のようになっています。  
それぞれ、Cの部分が変更されます。
- 変数の追加など、以前のファイルの読み込み時に問題が起こったり、ファイルの構造が変わるような変更 
  - C.X.X
- メソッドの追加など 
  - X.C.X
- 軽微な変更やバグ修正 
  - X.X.C
    
## License
このソフトウェアはMITライセンスの元配布されます。LICENSEファイルの内容をご覧ください。

## Copyright notice
The “Dart” name and “Flutter” name are trademarks of Google LLC.  
*The developer of this package is not Google LLC.