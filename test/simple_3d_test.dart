import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_3d/simple_3d.dart';

void main() {
  test('usage samples', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0)
    ], [
      Sp3dFragment([
        Sp3dFace([0], 0)
      ], isParticle: true, r: 1)
    ], [
      Sp3dMaterial(
        const Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        const Color.fromARGB(255, 0, 255, 0),
      )
    ], []);
    // Move
    sp3dObj.move(Sp3dV3D(1, 0, 0));
    // Rotate
    sp3dObj.rotate(Sp3dV3D(0, 1, 0), 45 * 3.14 / 180);
    // Vertex manipulation
    // You can do many other things with the Sp3dV3D feature.
    sp3dObj.vertices[0] += Sp3dV3D(1, 0, 0);
  });

  test('create, to_dict, from_dict', () {
    final sp3dObj = Sp3dObj(
        [Sp3dV3D(0, 0, 0)],
        [
          Sp3dFragment(
              [
                Sp3dFace([0], 0)
              ],
              isParticle: true,
              r: 1,
              physics: Sp3dPhysics(
                  mass: 1,
                  speed: 20,
                  direction: Sp3dV3D(1, 0, 0),
                  velocity: Sp3dV3D(1, 1, 0),
                  rotateAxis: Sp3dV3D(1, 0, 0),
                  angularVelocity: 2,
                  angle: 0.45,
                  others: {"test": "test"}),
              option: {"test": "test"})
        ],
        [
          Sp3dMaterial(
            const Color.fromARGB(255, 0, 255, 0),
            true,
            1,
            const Color.fromARGB(255, 0, 255, 0),
            imageIndex: null,
            textureCoordinates: [
              const Offset(0, 0),
              const Offset(0, 1),
              const Offset(1, 1),
              const Offset(1, 0),
            ],
          )
        ],
        [
          Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8])
        ],
        id: "1",
        name: "test",
        author: "Masahide Mori",
        physics: Sp3dPhysics(
            isLocked: true,
            mass: 1,
            speed: 20,
            direction: Sp3dV3D(1, 0, 0),
            velocity: Sp3dV3D(1, 1, 0),
            rotateAxis: Sp3dV3D(1, 0, 0),
            angularVelocity: 2,
            angle: 0.45,
            others: {"test": "test"}),
        option: {"test": "test"},
        layerNum: 1,
        drawMode: EnumSp3dDrawMode.rect);
    final sp3dObjDict = sp3dObj.toDict();
    final restored = Sp3dObj.fromDict(sp3dObjDict);
    final pre = jsonEncode(sp3dObjDict);
    final reloaded = jsonEncode(restored.toDict());
    expect(pre, reloaded);
    // vector test
    final v1 = Sp3dV3D(1, 1, 1);
    final v2 = Sp3dV3D(2, 2, 2);
    final v3 = Sp3dV3D(3, 3, 3);
    const double scalar = 3;
    expect(v1 + v2, v3);
    expect(v2 - v1, v1);
    expect(v1 * scalar, v3);
    expect(v3 / scalar, v1);
    Sp3dV3D nv1 = v1.deepCopy();
    Sp3dV3D nv2 = v2.deepCopy();
    Sp3dV3D nv3 = v3.deepCopy();
    nv1.add(v2);
    expect(nv1, v3);
    nv2.sub(v1);
    expect(nv2, v1);
    nv1 = v1.deepCopy();
    nv1.mul(scalar);
    expect(nv1, v3);
    nv3.div(scalar);
    expect(nv3, v1);
    expect(sp3dObj.move(v1).vertices.first, v1);
    expect((v1 * 2.5).equals(v2, 0.6), true);
    expect((v1 * 1.5).equals(v2, 0.6), true);
    expect((v1 * 2.7).equals(v2, 0.6), false);
  });

  // null parameter test.
  test('null test1 of create, to_dict, from_dict', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0)
    ], [
      Sp3dFragment(
        [
          Sp3dFace([0], 0)
        ],
        physics: Sp3dPhysics(),
      )
    ], [
      Sp3dMaterial(
        const Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        const Color.fromARGB(255, 0, 255, 0),
        imageIndex: null,
        textureCoordinates: [
          const Offset(0, 0),
          const Offset(0, 1),
          const Offset(1, 1),
          const Offset(1, 0),
        ],
      )
    ], [], physics: Sp3dPhysics());
    final sp3dObjDict = sp3dObj.toDict();
    final restored = Sp3dObj.fromDict(sp3dObjDict);
    final pre = jsonEncode(sp3dObjDict);
    final reloaded = jsonEncode(restored.toDict());
    expect(pre, reloaded);
    // vector test
    final v1 = Sp3dV3D(1, 1, 1);
    final v2 = Sp3dV3D(2, 2, 2);
    final v3 = Sp3dV3D(3, 3, 3);
    const double scalar = 3;
    expect(v1 + v2, v3);
    expect(v2 - v1, v1);
    expect(v1 * scalar, v3);
    expect(v3 / scalar, v1);
    Sp3dV3D nv1 = v1.deepCopy();
    Sp3dV3D nv2 = v2.deepCopy();
    Sp3dV3D nv3 = v3.deepCopy();
    nv1.add(v2);
    expect(nv1, v3);
    nv2.sub(v1);
    expect(nv2, v1);
    nv1 = v1.deepCopy();
    nv1.mul(scalar);
    expect(nv1, v3);
    nv3.div(scalar);
    expect(nv3, v1);
    expect(sp3dObj.move(v1).vertices.first, v1);
    expect((v1 * 2.5).equals(v2, 0.6), true);
    expect((v1 * 1.5).equals(v2, 0.6), true);
    expect((v1 * 2.7).equals(v2, 0.6), false);
  });

  test('null test2 of create, to_dict, from_dict', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0)
    ], [
      Sp3dFragment([
        Sp3dFace([0], 0)
      ])
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    final sp3dObjDict = sp3dObj.toDict();
    final restored = Sp3dObj.fromDict(sp3dObjDict);
    final pre = jsonEncode(sp3dObjDict);
    final reloaded = jsonEncode(restored.toDict());
    expect(pre, reloaded);
    // vector test
    final v1 = Sp3dV3D(1, 1, 1);
    final v2 = Sp3dV3D(2, 2, 2);
    final v3 = Sp3dV3D(3, 3, 3);
    const double scalar = 3;
    expect(v1 + v2, v3);
    expect(v2 - v1, v1);
    expect(v1 * scalar, v3);
    expect(v3 / scalar, v1);
    Sp3dV3D nv1 = v1.deepCopy();
    Sp3dV3D nv2 = v2.deepCopy();
    Sp3dV3D nv3 = v3.deepCopy();
    nv1.add(v2);
    expect(nv1, v3);
    nv2.sub(v1);
    expect(nv2, v1);
    nv1 = v1.deepCopy();
    nv1.mul(scalar);
    expect(nv1, v3);
    nv3.div(scalar);
    expect(nv3, v1);
    expect(sp3dObj.move(v1).vertices.first, v1);
    expect((v1 * 2.5).equals(v2, 0.6), true);
    expect((v1 * 1.5).equals(v2, 0.6), true);
    expect((v1 * 2.7).equals(v2, 0.6), false);
  });

  test('rotate, marge, and fragment move test', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
    ], [
      Sp3dFragment([
        Sp3dFace([0], 0)
      ])
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    final other = sp3dObj.deepCopy();
    other.vertices.add(Sp3dV3D(1, 0, 0));
    other.fragments.add(Sp3dFragment([
      Sp3dFace([1], 0).rotate(other, Sp3dV3D(0, 0, 1), -90 * 3.14 / 180)
    ]));
    other.fragments[1].rotate(other, Sp3dV3D(0, 0, 1), 90 * 3.14 / 180);
    sp3dObj.merge(other);
    expect(other.vertices[1] == sp3dObj.vertices[2], true);
    sp3dObj.fragments.last.move(sp3dObj, Sp3dV3D(1, 0, 0));
    expect(sp3dObj.vertices[2] == Sp3dV3D(2, 0, 0), true);
  });

  test('getCenter test', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(3, 0, 0),
      Sp3dV3D(0, 3, 0),
      Sp3dV3D(0, 0, 3),
      Sp3dV3D(9, 0, 0),
      Sp3dV3D(0, 9, 0),
      Sp3dV3D(0, 0, 9),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2], 0)
      ]),
      Sp3dFragment([
        Sp3dFace([3, 4, 5], 0)
      ]),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    final aveObj = sp3dObj.getCenter();
    final aveFragment1 = sp3dObj.fragments.first.getCenter(sp3dObj);
    final aveFragment2 = sp3dObj.fragments.last.getCenter(sp3dObj);
    expect(aveObj == Sp3dV3D(2, 2, 2), true);
    expect(aveFragment1 == Sp3dV3D(1, 1, 1), true);
    expect(aveFragment2 == Sp3dV3D(3, 3, 3), true);
  });

  test('copyWith test', () {
    Sp3dV3D v = Sp3dV3D(0, 0, 0);
    List<Sp3dV3D> arr = [
      v,
      v.copyWith(x: 1),
      v.copyWith(y: 1),
      v.copyWith(z: 1)
    ];
    expect(arr[0] == Sp3dV3D(0, 0, 0), true);
    expect(arr[1] == Sp3dV3D(1, 0, 0), true);
    expect(arr[2] == Sp3dV3D(0, 1, 0), true);
    expect(arr[3] == Sp3dV3D(0, 0, 1), true);
  });

  test('copyWith of Sp3dMaterial test', () {
    Sp3dMaterial v1 = Sp3dMaterial(Colors.black, true, 1, Colors.black,
        imageIndex: 1,
        textureCoordinates: [const Offset(0, 0)],
        option: {"test": 1});
    Sp3dMaterial v2 = v1.copyWith(
        bg: Colors.red,
        isFill: false,
        strokeWidth: 2,
        strokeColor: Colors.red,
        imageIndex: 2,
        textureCoordinates: [const Offset(1, 1)],
        option: {"test": 2});
    expect(v1.bg != v2.bg, true);
    expect(v1.isFill != v2.isFill, true);
    expect(v1.strokeWidth != v2.strokeWidth, true);
    expect(v1.strokeColor != v2.strokeColor, true);
    expect(v1.imageIndex != v2.imageIndex, true);
    expect(v1.textureCoordinates![0].dx != v2.textureCoordinates![0].dx, true);
    expect(v1.option!["test"] != v2.option!["test"], true);
  });

  test('reverse test', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 0, 2),
    ], [
      Sp3dFragment(
        [
          Sp3dFace([0, 1, 2], 0),
          Sp3dFace([0, 1, 2], 0)
        ],
        physics: Sp3dPhysics(),
      ),
      Sp3dFragment(
        [
          Sp3dFace([0, 1, 2], 0),
          Sp3dFace([0, 1, 2], 0)
        ],
        physics: Sp3dPhysics(),
      )
    ], [
      Sp3dMaterial(
        const Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        const Color.fromARGB(255, 0, 255, 0),
        imageIndex: null,
        textureCoordinates: [
          const Offset(0, 0),
          const Offset(0, 1),
          const Offset(1, 1),
          const Offset(1, 0),
        ],
      )
    ], [], physics: Sp3dPhysics());
    sp3dObj.reverse();
    expect(sp3dObj.fragments[0].faces[0].vertexIndexList[0] == 2, true);
    expect(sp3dObj.fragments[0].faces[0].vertexIndexList[1] == 1, true);
    expect(sp3dObj.fragments[0].faces[0].vertexIndexList[2] == 0, true);
    expect(sp3dObj.fragments[0].faces[1].vertexIndexList[0] == 2, true);
    expect(sp3dObj.fragments[0].faces[1].vertexIndexList[1] == 1, true);
    expect(sp3dObj.fragments[0].faces[1].vertexIndexList[2] == 0, true);
    expect(sp3dObj.fragments[1].faces[0].vertexIndexList[0] == 2, true);
    expect(sp3dObj.fragments[1].faces[0].vertexIndexList[1] == 1, true);
    expect(sp3dObj.fragments[1].faces[0].vertexIndexList[2] == 0, true);
    expect(sp3dObj.fragments[1].faces[1].vertexIndexList[0] == 2, true);
    expect(sp3dObj.fragments[1].faces[1].vertexIndexList[1] == 1, true);
    expect(sp3dObj.fragments[1].faces[1].vertexIndexList[2] == 0, true);
  });

  test('layerNum test', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 0, 2),
    ], [
      Sp3dFragment(
        [
          Sp3dFace([0, 1, 2], 0),
          Sp3dFace([0, 1, 2], 0)
        ],
        physics: Sp3dPhysics(),
      ),
      Sp3dFragment(
        [
          Sp3dFace([0, 1, 2], 0),
          Sp3dFace([0, 1, 2], 0)
        ],
        physics: Sp3dPhysics(),
      )
    ], [
      Sp3dMaterial(
        const Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        const Color.fromARGB(255, 0, 255, 0),
        imageIndex: null,
        textureCoordinates: [
          const Offset(0, 0),
          const Offset(0, 1),
          const Offset(1, 1),
          const Offset(1, 0),
        ],
      )
    ], [], physics: Sp3dPhysics(), layerNum: 1);
    expect(sp3dObj.layerNum == 1, true);
    final restoreObj = Sp3dObj.fromDict(sp3dObj.toDict());
    expect(restoreObj.layerNum == 1, true);
  });

  test('drawMode test', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 0, 2),
    ], [
      Sp3dFragment(
        [
          Sp3dFace([0, 1, 2], 0),
          Sp3dFace([0, 1, 2], 0)
        ],
        physics: Sp3dPhysics(),
      ),
      Sp3dFragment(
        [
          Sp3dFace([0, 1, 2], 0),
          Sp3dFace([0, 1, 2], 0)
        ],
        physics: Sp3dPhysics(),
      )
    ], [
      Sp3dMaterial(
        const Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        const Color.fromARGB(255, 0, 255, 0),
        imageIndex: null,
        textureCoordinates: [
          const Offset(0, 0),
          const Offset(0, 1),
          const Offset(1, 1),
          const Offset(1, 0),
        ],
      )
    ], [],
        physics: Sp3dPhysics(), layerNum: 1, drawMode: EnumSp3dDrawMode.rect);
    expect(sp3dObj.drawMode == EnumSp3dDrawMode.rect, true);
    final restoreObj = Sp3dObj.fromDict(sp3dObj.toDict());
    expect(restoreObj.drawMode == EnumSp3dDrawMode.rect, true);
    // pre version test
    Map<String, dynamic> preVersion10 = sp3dObj.toDictV14();
    preVersion10['version'] = "10";
    preVersion10['draw_mode'] = 0;
    final restorePreVerObj1 = Sp3dObj.fromDictV14(preVersion10);
    expect(restorePreVerObj1.drawMode == EnumSp3dDrawMode.normal, true);
    preVersion10['draw_mode'] = 1;
    final restorePreVerObj2 = Sp3dObj.fromDictV14(preVersion10);
    expect(restorePreVerObj2.drawMode == EnumSp3dDrawMode.rect, true);
  });

  test('isTouchable flag test', () {
    final obj = Sp3dObj([
      Sp3dV3D(3, 0, 0),
      Sp3dV3D(0, 3, 0),
      Sp3dV3D(0, 0, 3),
      Sp3dV3D(9, 0, 0),
      Sp3dV3D(0, 9, 0),
      Sp3dV3D(0, 0, 9),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2], 0)
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([3, 4, 5], 0)
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    Map<String, dynamic> d = obj.toDictV14();
    d['fragments'][0].remove('is_touchable');
    // フラグが存在しない場合、互換モードによってtrueに変化して復元される。
    final resumed = Sp3dObj.fromDictV14(d);
    expect(resumed.fragments[0].isTouchable == true, true);
    expect(resumed.fragments[1].isTouchable == false, true);
    resumed.setIsTouchableFlags(false);
    expect(resumed.fragments[0].isTouchable == false, true);
  });

  test('rotateInPlace test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 0, -1),
      Sp3dV3D(1, 0, -1),
      Sp3dV3D(1, 1, -1),
      Sp3dV3D(0, 1, -1),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
        Sp3dFace([4, 5, 6, 7], 0),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    // faceの回転
    obj.fragments[0].faces[0]
        .rotateInPlace(obj, Sp3dV3D(0, 1, 0).nor(), 90 * pi / 180);
    expect(obj.vertices[0].equals(Sp3dV3D(0.5, 0, 0.5), 0.001), true);
    expect(obj.vertices[1].equals(Sp3dV3D(0.5, 0, -0.5), 0.001), true);
    expect(obj.vertices[2].equals(Sp3dV3D(0.5, 1, -0.5), 0.001), true);
    expect(obj.vertices[3].equals(Sp3dV3D(0.5, 1, 0.5), 0.001), true);
    // 確実に元に戻す
    obj.vertices[0] = Sp3dV3D(0, 0, 0);
    obj.vertices[1] = Sp3dV3D(1, 0, 0);
    obj.vertices[2] = Sp3dV3D(1, 1, 0);
    obj.vertices[3] = Sp3dV3D(0, 1, 0);
    // fragmentの回転
    obj.fragments[0].rotateInPlace(obj, Sp3dV3D(0, 1, 0).nor(), 90 * pi / 180);
    expect(obj.vertices[0].equals(Sp3dV3D(1, 0, 0), 0.001), true);
    expect(obj.vertices[1].equals(Sp3dV3D(1, 0, -1), 0.001), true);
    expect(obj.vertices[2].equals(Sp3dV3D(1, 1, -1), 0.001), true);
    expect(obj.vertices[3].equals(Sp3dV3D(1, 1, 0), 0.001), true);
    expect(obj.vertices[4].equals(Sp3dV3D(0, 0, 0), 0.001), true);
    expect(obj.vertices[5].equals(Sp3dV3D(0, 0, -1), 0.001), true);
    expect(obj.vertices[6].equals(Sp3dV3D(0, 1, -1), 0.001), true);
    expect(obj.vertices[7].equals(Sp3dV3D(0, 1, 0), 0.001), true);
    // objの回転
    final obj2 = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 0, -1),
      Sp3dV3D(1, 0, -1),
      Sp3dV3D(1, 1, -1),
      Sp3dV3D(0, 1, -1),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([4, 5, 6, 7], 0),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    obj2.rotateInPlace(Sp3dV3D(0, 1, 0).nor(), 90 * pi / 180);
    expect(obj2.vertices[0].equals(Sp3dV3D(1, 0, 0), 0.001), true);
    expect(obj2.vertices[1].equals(Sp3dV3D(1, 0, -1), 0.001), true);
    expect(obj2.vertices[2].equals(Sp3dV3D(1, 1, -1), 0.001), true);
    expect(obj2.vertices[3].equals(Sp3dV3D(1, 1, 0), 0.001), true);
    expect(obj2.vertices[4].equals(Sp3dV3D(0, 0, 0), 0.001), true);
    expect(obj2.vertices[5].equals(Sp3dV3D(0, 0, -1), 0.001), true);
    expect(obj2.vertices[6].equals(Sp3dV3D(0, 1, -1), 0.001), true);
    expect(obj2.vertices[7].equals(Sp3dV3D(0, 1, 0), 0.001), true);
  });

  test('rotateBy test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 0, -1),
      Sp3dV3D(1, 0, -1),
      Sp3dV3D(1, 1, -1),
      Sp3dV3D(0, 1, -1),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
        Sp3dFace([4, 5, 6, 7], 0),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    // faceの回転
    obj.fragments[0].faces[0]
        .rotateBy(Sp3dV3D(1, 0, 0), obj, Sp3dV3D(0, 1, 0).nor(), 90 * pi / 180);
    expect(obj.vertices[0].equals(Sp3dV3D(1, 0, 1), 0.001), true);
    expect(obj.vertices[1].equals(Sp3dV3D(1, 0, 0), 0.001), true);
    expect(obj.vertices[2].equals(Sp3dV3D(1, 1, 0), 0.001), true);
    expect(obj.vertices[3].equals(Sp3dV3D(1, 1, 1), 0.001), true);
    // 確実に元に戻す
    obj.vertices[0] = Sp3dV3D(0, 0, 0);
    obj.vertices[1] = Sp3dV3D(1, 0, 0);
    obj.vertices[2] = Sp3dV3D(1, 1, 0);
    obj.vertices[3] = Sp3dV3D(0, 1, 0);
    // fragmentの回転
    obj.fragments[0]
        .rotateBy(Sp3dV3D(1, 0, 0), obj, Sp3dV3D(0, 1, 0).nor(), 90 * pi / 180);
    expect(obj.vertices[0].equals(Sp3dV3D(1, 0, 1), 0.001), true);
    expect(obj.vertices[1].equals(Sp3dV3D(1, 0, 0), 0.001), true);
    expect(obj.vertices[2].equals(Sp3dV3D(1, 1, 0), 0.001), true);
    expect(obj.vertices[3].equals(Sp3dV3D(1, 1, 1), 0.001), true);
    expect(obj.vertices[4].equals(Sp3dV3D(0, 0, 1), 0.001), true);
    expect(obj.vertices[5].equals(Sp3dV3D(0, 0, 0), 0.001), true);
    expect(obj.vertices[6].equals(Sp3dV3D(0, 1, 0), 0.001), true);
    expect(obj.vertices[7].equals(Sp3dV3D(0, 1, 1), 0.001), true);
    // objの回転
    final obj2 = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 0, -1),
      Sp3dV3D(1, 0, -1),
      Sp3dV3D(1, 1, -1),
      Sp3dV3D(0, 1, -1),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([4, 5, 6, 7], 0),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    obj2.rotateBy(Sp3dV3D(1, 0, 0), Sp3dV3D(0, 1, 0).nor(), 90 * pi / 180);
    expect(obj.vertices[0].equals(Sp3dV3D(1, 0, 1), 0.001), true);
    expect(obj.vertices[1].equals(Sp3dV3D(1, 0, 0), 0.001), true);
    expect(obj.vertices[2].equals(Sp3dV3D(1, 1, 0), 0.001), true);
    expect(obj.vertices[3].equals(Sp3dV3D(1, 1, 1), 0.001), true);
    expect(obj.vertices[4].equals(Sp3dV3D(0, 0, 1), 0.001), true);
    expect(obj.vertices[5].equals(Sp3dV3D(0, 0, 0), 0.001), true);
    expect(obj.vertices[6].equals(Sp3dV3D(0, 1, 0), 0.001), true);
    expect(obj.vertices[7].equals(Sp3dV3D(0, 1, 1), 0.001), true);
  });

  test('addVertices and addMaterials test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 0),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    final newVertices = [
      Sp3dV3D(0, 0, -1),
      Sp3dV3D(1, 0, -1),
      Sp3dV3D(1, 1, -1),
      Sp3dV3D(0, 1, -1)
    ];
    final verticesIndexList = obj.addVertices(newVertices);
    final materialIndexList = obj.addMaterials([
      Sp3dMaterial(const Color.fromARGB(255, 255, 0, 0), true, 1,
          const Color.fromARGB(255, 255, 0, 0))
    ]);
    obj.fragments.add(
        Sp3dFragment([Sp3dFace(verticesIndexList, materialIndexList.first)]));
    expect(obj.vertices.length == 8, true);
    expect(obj.vertices[4].equals(Sp3dV3D(0, 0, -1), 0.001), true);
    expect(obj.vertices[5].equals(Sp3dV3D(1, 0, -1), 0.001), true);
    expect(obj.vertices[6].equals(Sp3dV3D(1, 1, -1), 0.001), true);
    expect(obj.vertices[7].equals(Sp3dV3D(0, 1, -1), 0.001), true);
    expect(obj.fragments[1].faces.first.vertexIndexList[0] == 4, true);
    expect(obj.fragments[1].faces.first.vertexIndexList[1] == 5, true);
    expect(obj.fragments[1].faces.first.vertexIndexList[2] == 6, true);
    expect(obj.fragments[1].faces.first.vertexIndexList[3] == 7, true);
    expect(obj.materials.length == 2, true);
    expect(obj.materials[1].bg == const Color.fromARGB(255, 255, 0, 0), true);
    expect(obj.fragments[1].faces.first.materialIndex == 1, true);
  });

  test('addMaterialIfNeeded test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 0),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0))
    ], []);
    final int index1 = obj.addMaterialIfNeeded(Sp3dMaterial(
        const Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        const Color.fromARGB(255, 0, 255, 0)));
    final int index2 = obj.addMaterialIfNeeded(Sp3dMaterial(
        const Color.fromARGB(255, 255, 0, 0),
        true,
        1,
        const Color.fromARGB(255, 255, 0, 0)));
    expect(index1 == 0, true);
    expect(index2 == 1, true);
    expect(obj.materials.length == 2, true);
  });

  test('version up test of Sp3dFragment version 9', () {
    final fmt = Sp3dFragment([], name: "test");
    Map<String, dynamic> m = fmt.toDict();
    expect(m['name'] == 'test', true);
    m.remove('name');
    expect(m.containsKey('name'), false);
    expect(Sp3dFragment.fromDict(m).name == null, true);
  });

  test('version up test of Sp3dMaterial version 9', () {
    final fmt = Sp3dFragment([], name: "test");
    Map<String, dynamic> m = fmt.toDict();
    expect(m['name'] == 'test', true);
    m.remove('name');
    expect(m.containsKey('name'), false);
    expect(Sp3dFragment.fromDict(m).name == null, true);
  });

  test('version up test of Sp3dMaterial', () {
    final mt = Sp3dMaterial(Colors.black, true, 1, Colors.black, name: 'test');
    Map<String, dynamic> m = mt.toDict(version: 1);
    expect(m['name'] == 'test', true);
    m.remove('name');
    expect(m.containsKey('name'), false);
    expect(Sp3dMaterial.fromDict(m, 1).name == null, true);
    expect(Sp3dMaterial.fromDict(m, 1).copyWith().name == null, true);
    expect(
        Sp3dMaterial.fromDict(m, 1).copyWith(name: 'aaa').name == 'aaa', true);
    Map<String, dynamic> m2 = mt.toDict(version: 2);
    expect(m2['name'] == 'test', true);
    m2.remove('name');
    expect(m2.containsKey('name'), false);
    expect(Sp3dMaterial.fromDict(m2, 2).name == null, true);
    expect(Sp3dMaterial.fromDict(m2, 2).copyWith().name == null, true);
    expect(
        Sp3dMaterial.fromDict(m2, 2).copyWith(name: 'aaa').name == 'aaa', true);
  });

  test('version up test of Sp3dPhysics version 4', () {
    final ph = Sp3dPhysics(name: 'test');
    Map<String, dynamic> m = ph.toDict();
    expect(m['name'] == 'test', true);
    m.remove('name');
    expect(m.containsKey('name'), false);
    expect(Sp3dPhysics.fromDict(m).name == null, true);
  });

  test('Sp3dObj cleaning test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 0),
      Sp3dV3D(0, 1, 1),
      Sp3dV3D(1, 1, 1),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([0, 1, 2, 3], 0),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([1, 2, 3, 5], 2),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([1, 2, 3, 4], 1),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0)),
      Sp3dMaterial(const Color.fromARGB(255, 255, 0, 0), true, 1,
          const Color.fromARGB(255, 255, 0, 0),
          imageIndex: 0),
      Sp3dMaterial(const Color.fromARGB(255, 0, 0, 255), true, 1,
          const Color.fromARGB(255, 0, 0, 255))
    ], [
      Uint8List(8)
    ]);
    // 全てが維持される
    obj.cleaning();
    expect(obj.vertices.length == 6, true);
    expect(obj.fragments.length == 4, true);
    expect(obj.materials.length == 3, true);
    expect(obj.images.length == 1, true);
    // フラグメント数が変わるが、全てが維持される
    obj.fragments.removeAt(1);
    obj.cleaning();
    expect(obj.vertices.length == 6, true);
    expect(obj.fragments.length == 3, true);
    expect(obj.materials.length == 3, true);
    expect(obj.images.length == 1, true);
    // 画像と5番の頂点、2番目のマテリアルが消える。
    obj.fragments.removeAt(2);
    obj.cleaning();
    expect(obj.vertices.length == 5, true);
    expect(obj.vertices.last.equals(Sp3dV3D(1, 1, 1), 0.001), true);
    expect(obj.fragments.length == 2, true);
    expect(obj.fragments.first.faces.first.materialIndex == 0, true);
    expect(obj.fragments.last.faces.first.materialIndex == 1, true);
    expect(obj.fragments.last.faces.first.vertexIndexList.last == 4, true);
    expect(obj.materials.length == 2, true);
    expect(
        obj.materials.last ==
            Sp3dMaterial(const Color.fromARGB(255, 0, 0, 255), true, 1,
                const Color.fromARGB(255, 0, 0, 255)),
        true);
    expect(obj.images.isEmpty, true);
    // 元々6番目の頂点と元々3番目のマテリアルが消える。
    obj.fragments.removeAt(1);
    obj.cleaning();
    expect(obj.vertices.length == 4, true);
    expect(obj.vertices.last.equals(Sp3dV3D(0, 1, 0), 0.001), true);
    expect(obj.fragments.length == 1, true);
    expect(obj.fragments.last.faces.first.materialIndex == 0, true);
    expect(obj.materials.length == 1, true);
    expect(
        obj.materials.last ==
            Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
                const Color.fromARGB(255, 0, 255, 0)),
        true);
    expect(obj.images.isEmpty, true);
  });

  test('Sp3dFragment scale test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2], 0),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0)),
    ], []);
    // 原点をベースに2倍に拡大。
    obj.fragments.first.scale(Sp3dV3D(0, 0, 0), obj, 2.0);
    expect(obj.vertices[0].equals(Sp3dV3D(0, 0, 0), 0.001), true);
    expect(obj.vertices[1].equals(Sp3dV3D(2, 0, 0), 0.001), true);
    expect(obj.vertices[2].equals(Sp3dV3D(2, 2, 0), 0.001), true);
  });

  test('Sp3dObj clonePart test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 1),
      Sp3dV3D(0, 0, 1),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2], 0),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([1, 2, 3], 1),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([2, 3, 4], 1),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0),
          imageIndex: 0),
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0),
          imageIndex: 1),
    ], [
      Uint8List(8),
      Uint8List(12)
    ]);
    final clonePart = obj.clonePart([obj.fragments[1], obj.fragments[2]]);
    expect(clonePart.vertices[0].equals(obj.vertices[1], 0.001), true);
    expect(clonePart.vertices[1].equals(obj.vertices[2], 0.001), true);
    expect(clonePart.vertices[2].equals(obj.vertices[3], 0.001), true);
    expect(clonePart.vertices[3].equals(obj.vertices[4], 0.001), true);
    expect(clonePart.materials[0] == obj.materials[1], false);
    expect(clonePart.materials[0].imageIndex == 0, true);
    expect(clonePart.images[0].length == obj.images[1].length, true);
  });

  test('Sp3dObj V15 test', () {
    final obj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
      Sp3dV3D(1, 0, 0),
      Sp3dV3D(1, 1, 0),
      Sp3dV3D(0, 1, 1),
      Sp3dV3D(0, 0, 1),
    ], [
      Sp3dFragment([
        Sp3dFace([0, 1, 2], 0),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([1, 2, 3], 1),
      ], isTouchable: false),
      Sp3dFragment([
        Sp3dFace([2, 3, 4], 1),
      ], isTouchable: false),
    ], [
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0),
          imageIndex: 0),
      Sp3dMaterial(const Color.fromARGB(255, 0, 255, 0), true, 1,
          const Color.fromARGB(255, 0, 255, 0),
          imageIndex: 1),
    ], [
      Uint8List(8),
      Uint8List(12)
    ]);
    final oldFormat = obj.toDictV14();
    final oldFormatRestored = Sp3dObj.fromDictV14(oldFormat);
    final oldFormatAutoRestored = Sp3dObj.fromDict(oldFormat);
    final oldFormatStr = oldFormat.toString();
    final oldFormatRestoredStr = oldFormatRestored.toDictV14().toString();
    final oldFormatAutoRestoredStr =
        oldFormatAutoRestored.toDictV14().toString();
    expect(oldFormatStr == oldFormatRestoredStr, true);
    expect(oldFormatStr == oldFormatAutoRestoredStr.toString(), true);
    final newFormat = obj.toDict();
    final newFormatRestored = Sp3dObj.fromDict(newFormat);
    final newFormatStr = newFormat.toString();
    final newFormatRestoredStr = newFormatRestored.toDict().toString();
    expect(newFormatStr == newFormatRestoredStr, true);
    expect(newFormatStr == newFormatRestored.toDictV14().toString(), false);
  });
}
