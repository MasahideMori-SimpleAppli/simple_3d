## 16.1.2

* Improve hash comparison accuracy for Sp3dMaterial class by updating internal dependencies.

## 16.1.1

* Added missing parameter description to norSafe method of Sp3dV3D class.

## 16.1.0

* Added norSafe() method to Sp3dV3D class for rendering / UI use.
* Minor internal refactoring without API changes.

## 16.0.2

* Updates associated with dependencies library updates.

## 16.0.1

* Updated about [issue 12](https://github.com/MasahideMori-SimpleAppli/simple_3d_renderer/issues/12) in simple_3d_renderer.
* This is a fix for a mismatch between the flutter version this package requests and the actual flutter version required.

## 16.0.0

* Updated minimum SDK version.
* The way Dart handles color information has changed from integers to floating point numbers, so this package's color handling has been changed to floating point numbers.
* In the serialization and deserialization supported by this package, colors from previous versions will be automatically adjusted. 
* Please be careful when using the serialized results of this package on the server side, etc. The serialized color values have changed from this version.

## 15.0.0

* The contents of the output dictionary have been changed to speed up toDict and fromDict and to reduce the output file size.
* With this change, JSON dictionary keys that were previously written in snake case will now be written in camel case.
* In this change, the vertex data is converted to the Sp3dV3DList class and then passed toDict and fromDict.
* In this change, the face data is converted to the Sp3dFaceList class and then passed toDict and fromDict.
* In this change, the fragment data is converted to the Sp3dFragmentList class and then passed toDict and fromDict.
* In this change, the material data is converted to the Sp3dMaterialList class and then passed toDict and fromDict.
* For backward compatibility, fromDictV14 and toDictV14 have been added to each class. You can use these if you are using JSON data in the backend.
* When loading an older version of Sp3dObj, the fromDict method automatically calls fromDictV14, so no operation is required.

## 14.0.1

* Hashcodes for Sp3dMaterial option values are now less likely to collide.

## 14.0.0

* Sp3dObj extended [CloneableFile](https://github.com/MasahideMori-SimpleAppli/file_state_manager/blob/main/lib/src/cloneable_file.dart). This makes it possible to undo and redo using the [file_state_manager](https://pub.dev/packages/file_state_manager) package.

## 13.3.0

* Added clonePart method to Sp3dObj. 
* Added getUniqueVerticesIndices method to Sp3dFragment.
* Added getUniqueMaterialIndices method to Sp3dFragment.
* Added updateVerticesIndexes method to Sp3dFace and Sp3dFragment.
* Added updateMaterialIndexes method to Sp3dFace and Sp3dFragment. 
* Added updateImageIndexes method to Sp3dMaterial.

## 13.2.1

* Fixed version code in Sp3dFragment.
* Fixed unnecessary line breaks in EnumSp3dDrawingMode.

## 13.2.0

* Added scale method to Sp3dFragment.

## 13.1.1

* Readme has been updated.

## 13.1.0

* Added resize method to Sp3dObj.
* Added cleaning method to Sp3dObj.

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
