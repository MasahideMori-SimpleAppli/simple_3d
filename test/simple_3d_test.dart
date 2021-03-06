import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
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
        Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        Color.fromARGB(255, 0, 255, 0),
      )
    ], []);
    // Move
    sp3dObj.move(Sp3dV3D(1, 0, 0));
    // Rotate
    sp3dObj.rotate(Sp3dV3D(0, 1, 0), 45 * 3.14 / 180);
    // Vertex manipulation
    // You can do many other things with the Sp3dV3D feature.
    sp3dObj.vertices[0] += Sp3dV3D(1, 0, 0);
    print("usage sample end");
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
            Color.fromARGB(255, 0, 255, 0),
            true,
            1,
            Color.fromARGB(255, 0, 255, 0),
            imageIndex: null,
            textureCoordinates: [
              Offset(0, 0),
              Offset(0, 1),
              Offset(1, 1),
              Offset(1, 0),
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
        option: {"test": "test"});
    final sp3dObjDict = sp3dObj.toDict();
    print("to_dict");
    print(sp3dObjDict);
    final restored = Sp3dObj.fromDict(sp3dObjDict);
    print("restored");
    print(restored.toDict());
    print("is match");
    final pre = jsonEncode(sp3dObjDict);
    final reloaded = jsonEncode(restored.toDict());
    print(pre == reloaded);
    expect(pre, reloaded);
    // vector test
    print("vector test");
    final v1 = Sp3dV3D(1, 1, 1);
    final v2 = Sp3dV3D(2, 2, 2);
    final v3 = Sp3dV3D(3, 3, 3);
    final double scalar = 3;
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
    print("move test");
    expect(sp3dObj.move(v1).vertices.first, v1);
    print("equals_test");
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
        Color.fromARGB(255, 0, 255, 0),
        true,
        1,
        Color.fromARGB(255, 0, 255, 0),
        imageIndex: null,
        textureCoordinates: [
          Offset(0, 0),
          Offset(0, 1),
          Offset(1, 1),
          Offset(1, 0),
        ],
      )
    ], [], physics: Sp3dPhysics());
    final sp3dObjDict = sp3dObj.toDict();
    print("to_dict");
    print(sp3dObjDict);
    final restored = Sp3dObj.fromDict(sp3dObjDict);
    print("restored");
    print(restored.toDict());
    print("is match");
    final pre = jsonEncode(sp3dObjDict);
    final reloaded = jsonEncode(restored.toDict());
    print(pre == reloaded);
    expect(pre, reloaded);
    // vector test
    print("vector test");
    final v1 = Sp3dV3D(1, 1, 1);
    final v2 = Sp3dV3D(2, 2, 2);
    final v3 = Sp3dV3D(3, 3, 3);
    final double scalar = 3;
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
    print("move test");
    expect(sp3dObj.move(v1).vertices.first, v1);
    print("equals_test");
    expect((v1 * 2.5).equals(v2, 0.6), true);
    expect((v1 * 1.5).equals(v2, 0.6), true);
    expect((v1 * 2.7).equals(v2, 0.6), false);
  });

  // null parameter test.
  test('null test2 of create, to_dict, from_dict', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0)
    ], [
      Sp3dFragment([
        Sp3dFace([0], 0)
      ])
    ], [
      Sp3dMaterial(Color.fromARGB(255, 0, 255, 0), true, 1,
          Color.fromARGB(255, 0, 255, 0))
    ], []);
    final sp3dObjDict = sp3dObj.toDict();
    print("to_dict");
    print(sp3dObjDict);
    final restored = Sp3dObj.fromDict(sp3dObjDict);
    print("restored");
    print(restored.toDict());
    print("is match");
    final pre = jsonEncode(sp3dObjDict);
    final reloaded = jsonEncode(restored.toDict());
    print(pre == reloaded);
    expect(pre, reloaded);
    // vector test
    print("vector test");
    final v1 = Sp3dV3D(1, 1, 1);
    final v2 = Sp3dV3D(2, 2, 2);
    final v3 = Sp3dV3D(3, 3, 3);
    final double scalar = 3;
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
    print("move test");
    expect(sp3dObj.move(v1).vertices.first, v1);
    print("equals_test");
    expect((v1 * 2.5).equals(v2, 0.6), true);
    expect((v1 * 1.5).equals(v2, 0.6), true);
    expect((v1 * 2.7).equals(v2, 0.6), false);
  });

  // marge test.
  test('rotate, marge, and fragment move test', () {
    final sp3dObj = Sp3dObj([
      Sp3dV3D(0, 0, 0),
    ], [
      Sp3dFragment([
        Sp3dFace([0], 0)
      ])
    ], [
      Sp3dMaterial(Color.fromARGB(255, 0, 255, 0), true, 1,
          Color.fromARGB(255, 0, 255, 0))
    ], []);
    final other = sp3dObj.deepCopy();
    other.vertices.add(Sp3dV3D(1, 0, 0));
    other.fragments.add(Sp3dFragment([
      Sp3dFace([1], 0).rotate(other, Sp3dV3D(0, 0, 1), -90 * 3.14 / 180)
    ]));
    print("add and rotate face");
    print(other.toDict());
    other.fragments[1].rotate(other, Sp3dV3D(0, 0, 1), 90 * 3.14 / 180);
    print("fragment reverse rotate");
    print(other.toDict());
    sp3dObj.merge(other);
    print("merge");
    print(sp3dObj.toDict());
    expect(other.vertices[1] == sp3dObj.vertices[2], true);
    print("move");
    sp3dObj.fragments.last.move(sp3dObj, Sp3dV3D(1, 0, 0));
    expect(sp3dObj.vertices[2] == Sp3dV3D(2, 0, 0), true);
  });

  // getCenter test.
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
      Sp3dMaterial(Color.fromARGB(255, 0, 255, 0), true, 1,
          Color.fromARGB(255, 0, 255, 0))
    ], []);
    final aveObj = sp3dObj.getCenter();
    final aveFragment1 = sp3dObj.fragments.first.getCenter(sp3dObj);
    final aveFragment2 = sp3dObj.fragments.last.getCenter(sp3dObj);
    print("average");
    print(aveObj);
    print(aveFragment1);
    print(aveFragment2);
    expect(aveObj == Sp3dV3D(2, 2, 2), true);
    expect(aveFragment1 == Sp3dV3D(1, 1, 1), true);
    expect(aveFragment2 == Sp3dV3D(3, 3, 3), true);
  });
}
