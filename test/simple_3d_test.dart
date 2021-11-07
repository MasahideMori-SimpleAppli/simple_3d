import 'dart:convert';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_3d/simple_3d.dart';

void main() {
  test('create, to_dict, from_dict', () {
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
        [],
        null);
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
}
