# simple_3d

(en)Japanese ver is [here](https://github.com/MasahideMori-SimpleAppli/simple_3d/blob/main/README_JA.md).  
(ja)この解説の日本語版は[ここ](https://github.com/MasahideMori-SimpleAppli/simple_3d/blob/main/README_JA.md)にあります。  

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
    [Sp3dV3D(0, 0, 0)],
    [
      Sp3dFragment(
          [
            Sp3dFace([0], 0)
          ],
          isParticle: true,
          r: 1)
    ],
    [
      Sp3dMaterial(
        Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        Color.fromARGB(255, 0, 255, 0),
      )
    ],
    []);
```
### Operation example
```dart
// Move
sp3dObj.move(Sp3dV3D(1,0,0));
// Rotate
sp3dObj.rotate(Sp3dV3D(0,1,0),45*pi/180);
// Vertex manipulation
// You can do many other things with the Sp3dV3D feature.
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
If you need paid support for any reason, please contact my company.  
This package is developed by me personally, but may be supported via the company.  
[SimpleAppli Inc.](https://simpleappli.com/en/index_en.html)

## Format Name
Simple 3D Format

## Filename Extension
.sp3d

## MIME Type ( Temporary )
model/x.sp3d

## Suitable
Science(For example, physical calculation), Simple Games, etc.

## Not Suitable
Advanced graphics.  

## Structure ( Decoded object )
- Sp3dObj
    - vertices: List
        - v: Sp3dV3D
    - fragments: List
        - fragment: Sp3dFragment
            - faces: List, The definition of the face. Represents a triangular or square mesh.
                - face: Sp3dFace
                    - vertexIndexList: List, Vertices index. Counterclockwise rotation from the upper left.
                        - index: int
                    - materialIndex: int?
            - isParticle: bool.
            - r: double, Radius for particle type.
            - physics: Sp3dPhysics?
            - option: Map<String, dynamic>?, Optional attributes that may be added for each app. However, only parameters that can be converted to JSON can be entered.
    - materials: List
        - material: Sp3dMaterial
            - bg: Color, argb.
            - isFill: bool, if false, stroke line only.
            - strokeWidth: double
            - strokeColor: Color, argb
            - imageIndex: int?, Fills the face with the specified image, which is not null.
            - textureCoordinates: List?, Cutout coordinates when you want to use a part of the image. 3 or 6 points(In the case of a square, specify it with two triangles). 
            - option: Map<String, dynamic>?, Optional attributes that may be added for each app. However, only parameters that can be converted to JSON can be entered.
    - images: list
        - image: Uint8List, png data.
    - id: String?
    - name: String?
    - author: String?
    - physics: Sp3dPhysics?
        - mass: double?, (kg). However, the unit should be changed for the calculation of atoms etc.
        - speed: double?, (m/s). However, the unit should be changed for the calculation of atoms etc.
        - direction: Sp3dV3D?, Unit vector.
        - velocity: Sp3dV3D?, Use for move.
        - rotateAxis: Sp3dV3D?
        - angularVelocity: double?, (rad/s).
        - angle: double?, rad.
        - others: Map<String, dynamic>?, If you want to use other parameters, add here To do.
    - option: Map<String, dynamic>?, Optional attributes that may be added for each app. However, only parameters that can be converted to JSON can be entered.
    - layerNum: int, Drawing priority in the depth direction that is enabled for rendering software. Layers with smaller numbers are drawn first.
    - drawMode: enum, Enum for specifying the mode in which the Sp3dObj is drawn by the renderer.  

## Parameter Note
If you use Sp3dObj to calculate a large number of atoms, consider using the isParticle flag and r(radius).  
Each atom has one vertex when calculated or saved, and you can draw a sphere using UtilSp3dGeometry etc. only when drawing on the screen.  
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