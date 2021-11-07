# simple_3d

(en)Japanese ver is [here](https://github.com/MasahideMori-SimpleAppli/simple_3d/blob/main/README_JP.md).  
(ja)この解説の日本語版は[ここ](https://github.com/MasahideMori-SimpleAppli/simple_3d/blob/main/README_JP.md)にあります。  

## Overview
This package is a working Flutter(Dart) implementation of Simple 3D Format.  
Simple 3D Format is a file format that makes it easy for non-experts to handle 3D objects.  
The file output in this format has the extension .sp3d, and the inner class convert to JSON. All the data about one object is contained in one file.  
This specification aims to minimize complexity, make it easier to read in a text editor, and make it versatile.  
Made for science, it can be difficult to use in other genres. 
For the development of science, I aim to be able to use it without being affected by interests and conflicts.

## Usage
### Quick Start
I created a package for rendering Sp3dObj.  
You can use it more easily by using the following packages.  
See the simple_3d_renderer package for how to use it.

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
// (en)You can do many other things with the Sp3dV3D feature.
// (ja)Sp3dV3Dの機能を使うと、他にも様々なことが出来ます。
sp3dObj.vertices[0] += Sp3dV3D(1,0,0);
```
### Convert
```dart
final sp3dObjDict = sp3dobj.toDict();
```
### Load
```dart
final restored = Sp3dObj.fromDict(sp3dObjDict);
```

## Support
If for any reason you need paid support, please contact my company.  
[SimpleAppli Inc.](https://simpleappli.com/en/index_en.html)

## Format Name
Simple 3D Format

## Filename Extension
.sp3d

## MIME Type ( Temporary )
model/x.sp3d

## Suitable
Science, Simple Games, etc.

## Not Suitable
Advanced graphics.  

## Structure ( Decoded object )
- Sp3dObj
    - id: String?
    - name: String?
    - vertices: List
        - v: Sp3dV3D
    - fragments: List
        - fragment: Sp3dFragment
            - isParticle: bool.
            - faces: List, One vertex for particle type.
                - face: Sp3dFace
                    - vertexIndexList: List, Vertices index. Counterclockwise rotation from the upper left.
                        - index: int
                    - materialIndex: int?
                - r: double, Radius for particle type.
                - option: Map<String, dynamic>, Optional attributes that may be added for each app.
    - materials: List
        - material: Sp3dMaterial
            - bg: Color, argb.
            - isFill: bool, if false, stroke line only.
            - strokeWidth: double
            - strokeColor: Color, argb
            - imageIndex: int?, Invalid if null. When fill is enabled and there are 4 vertex, fill with image with the Counterclockwise order as the vertices from the upper left.
            - textureCoordinates: List, Cutout coordinates when you want to use a part of the image. 3 or 4 points. 
            - option: Map<String, dynamic>, Optional attributes that may be added for each app.
    - images: list
        - image: Uint8List, png data.
    - option: Map<String, dynamic>, Optional attributes that may be added for each app.
    
## Parameter Note
If you use Sp3dObj to calculate a large number of atoms, consider using the is_particle flag and r(radius).  
Each atom has one vertex when calculated or saved, and you can draw a sphere using Util_Sp3dGeometry etc. only when drawing on the screen.  
(That is, create a new Sp3dObj when drawing).

## About version control
It is as follows in version 3.1.0 or later.  
The C part will be changed at the time of version upgrade.
- Changes such as adding variables, structure change that cause problems when reading previous files. 
  - C.X.X
- Adding methods, etc. 
  - X.C.X
- Minor changes and bug fixes. 
  - X.X.C  

## License
This software is released under the MIT License, see LICENSE file.  

## Copyright notice
The “Dart” name and “Flutter” name are trademarks of Google LLC.  
*The developer of this package is not Google LLC.