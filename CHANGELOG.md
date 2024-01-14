## 13.0.0

* Added name parameter to Sp3dFragment.
* Added name parameter to Sp3dMaterial.
* Added name parameter to Sp3dPhysics.
* Fixed some method descriptions. This is a fix for a string copy-paste mistake and is not about any
  significant behavior change.
* Fine tuning of Sp3dMaterial's hash calculation.

## 12.1.0

* Some static methods of Sp3dV3D are now available as regular methods (format of xxxTo(Sp3dV3D
  other)).
* Added addImages method to Sp3dObj.

## 12.0.0

* Added equals operator override to Sp3dMaterial.
* Added addVertices method to Sp3dObj. This method returns the list of indexes of added vertices.
* Added addMaterials method to Sp3dObj.
* Added addMaterialIfNeeded method to Sp3dObj.
* Some variables changed to static const from final.

## 11.2.0

* Added rotateBy method to Sp3dObj, Sp3dFragment and Sp3dFace.

## 11.1.0

* Added rotateInPlace method to Sp3dObj, Sp3dFragment and Sp3dFace.
* Added getCenter method to Sp3dFace.

## 11.0.0

* Added isTouchable flag to Sp3dFragment.
* Added setIsTouchableFlags method to Sp3dObj.

## 10.0.0

* Supported Dart 3.
* Changed the minimum Dart version and changed how Enum values are handled.

## 9.0.0

* Added drawMode parameter to Sp3dObj.

## 8.0.0

* Added layerNum parameter to Sp3dObj.
* Changed to convert image files to base64 format when call toDict in Sp3dObj. Compatibility with
  previous files is maintained.

## 7.2.0

* Added reverse and reversed method to Sp3dFragment.
* Added reverse and reversed method to Sp3dObj.
* copyWith method to Sp3dMaterial.

## 7.1.0

* Added copyWith method to Sp3dV3D.
* Fixed the constructor description of Sp3dV3D.

## 7.0.1

* Fix changelog.

## 7.0.0

* Refactored the structure for future development.

## 6.0.1

* Bug fix of toDict and fromDict of Sp3dPhysics.  
  If you have a file saved in 6.0.0, it will be fixed by modifying the camel case in saved JSON key
  to snake case.  
  This can be ignored if you are not using the Sp3dPhysics.

## 6.0.0

* Updated README.md
* Added Sp3dPhysics class.
* Added Sp3dPhysics variable to Sp3dObj and Sp3dFragment.
* Added move and rotate method to Sp3dFace.
* Added move, rotate, getCenter method to Sp3dFragment.
* Added merge and getCenter method to Sp3dObj.
* Added author variable to Sp3dObj.
* Changed infrequently used constructor arguments to Optional parameters.

## 5.0.2

* Bug fix of Image Load in Sp3dObj.
* Fixed an issue where Sp3dFace vertex reference type judgement might fail under certain conditions.

## 5.0.1

* Fixed README.md.

## 5.0.0

* Changed Class member name to lower camel case.
* Separated the Japanese README file.
* Fixed README.md(textureCoordinates length).
* Fixed explanatory text of textureCoordinates in Sp3dMaterial.

## 4.0.0

* Updated README.md.
* Texture support has been added to Sp3dMaterial.

## 3.3.1

* Update README.md.

## 3.3.0

* Added get_vertices method to Sp3dFace.

## 3.2.0

* Added surface_normal method to Sp3dV3D.

## 3.1.0

* Added angle method to Sp3dV3D.
* From this version, the method of managing version numbers has changed. See the readme for details.

## 3.0.0

* Fixed the reverse function of Sp3dFace. Along with this, the behavior of the reversed function
  also changes.
  The previous reverse and reversed have been changed to reverse_ft and reversed_ft.
* Fixed the rotate function of Sp3dV3D. The previous rotate function have been changed to the
  rotated function.
* Added rotate method to Sp3dObj.

## 2.0.0

* The coordinate system on the specifications has been changed to the right-hand coordinate system(
  pre-version is left-hand).
  Regarding this change, only the description of the specification of README.md has been changed.
* Added equals method to Sp3dV3D. Added reverse, and reversed method to Sp3dFace.

## 1.0.8

* Added set method to Sp3dV3D. Added move method to Sp3dObj.

## 1.0.7

* Added ave method to Sp3dV3D.

## 1.0.6

* Added rotate, is_zero, and ortho method to Sp3dV3D.

## 1.0.5

* Changed the argument type of mul and div of Sp3dV3D from double to num.

## 1.0.4

* Fixed method name (norm to nor) of Sp3dV3D. And add dot, cross, proj and dist method to Sp3dV3D.

## 1.0.3

* Added add, sub, mul and div method to Sp3dV3D.

## 1.0.2

* Added four arithmetic operations, len method, and nor method to Sp3dV3D.

## 1.0.1

* Removed final from Sp3v3d variables.

## 1.0.0

* Fixed a structural problem.

## 0.1.1

* Updated meta and api description.

## 0.1.0

* Beta release.

## 0.0.1

* Initial release.
