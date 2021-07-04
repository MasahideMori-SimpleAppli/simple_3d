import 'dart:convert';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_3d/simple_3d.dart';

void main() {
  test('create, to_dict, from_dict', () {
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
    print(pre==reloaded);
    expect(pre,reloaded);
  });
}
