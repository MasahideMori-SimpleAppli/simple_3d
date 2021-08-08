import 'dart:convert';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_3d/simple_3d.dart';

void main() {
  test('create, to_dict, from_dict', () {
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
    final sp3dobj_d = sp3dobj.to_dict();
    print("to_dict");
    print(sp3dobj_d);
    final restored = Sp3dObj.from_dict(sp3dobj_d);
    print("restored");
    print(restored.to_dict());
    print("is match");
    final pre = jsonEncode(sp3dobj_d);
    final reloaded = jsonEncode(restored.to_dict());
    print(pre == reloaded);
    expect(pre, reloaded);
    // vector test
    print("vector test");
    final v1 = Sp3dV3D(1, 1, 1);
    final v2 = Sp3dV3D(2, 2, 2);
    final v3 = Sp3dV3D(3, 3, 3);
    final double scalar = 3;
    expect(v1+v2,v3);
    expect(v2-v1,v1);
    expect(v1*scalar,v3);
    expect(v3/scalar,v1);
    Sp3dV3D nv1 = v1.deep_copy();
    Sp3dV3D nv2 = v2.deep_copy();
    Sp3dV3D nv3 = v3.deep_copy();
    nv1.add(v2);
    expect(nv1,v3);
    nv2.sub(v1);
    expect(nv2,v1);
    nv1 = v1.deep_copy();
    nv1.mul(scalar);
    expect(nv1,v3);
    nv3.div(scalar);
    expect(nv3,v1);
  });
}
