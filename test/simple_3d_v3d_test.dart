import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_3d/simple_3d.dart';

void main() {
  final x = Sp3dV3D(1, 0, 0);
  final y = Sp3dV3D(0, 1, 0);
  final z = Sp3dV3D(0, 0, 1);
  final nx = Sp3dV3D(-1, 0, 0);
  final zero = Sp3dV3D.zero();

  group('Sp3dV3D.signedAngle', () {
    test('90 deg CCW around +Z', () {
      expect(Sp3dV3D.signedAngle(x, y, z), closeTo(pi / 2, 1e-9));
    });

    test('90 deg CW around +Z', () {
      expect(Sp3dV3D.signedAngle(y, x, z), closeTo(-pi / 2, 1e-9));
    });

    test('180 deg', () {
      expect(Sp3dV3D.signedAngle(x, nx, z).abs(), closeTo(pi, 1e-9));
    });

    test('normal flip reverses sign', () {
      final a1 = Sp3dV3D.signedAngle(x, y, z);
      final a2 = Sp3dV3D.signedAngle(x, y, z * -1.0);
      expect(a1, closeTo(-a2, 1e-9));
    });

    test('boundary: zero length input or normal', () {
      expect(Sp3dV3D.signedAngle(zero, x, z), 0.0);
      expect(Sp3dV3D.signedAngle(x, y, zero), 0.0);
    });

    test('normal scale invariant', () {
      // 修正した「内部で正規化される」ことの確認
      expect(Sp3dV3D.signedAngle(x, y, z * 10.0), closeTo(pi / 2, 1e-9));
    });
  });

  group('Sp3dV3D.signedAngleOnPlane', () {
    test('ignores normal component and projection removes tilt', () {
      final a = Sp3dV3D(1, 0, 10); // 上に浮いている
      final b = Sp3dV3D(0, 1, 20); // もっと上に浮いている
      // Z軸法線（XY平面）に射影すれば 90度
      expect(Sp3dV3D.signedAngleOnPlane(a, b, z), closeTo(pi / 2, 1e-9));
    });

    test('normal scale invariant', () {
      expect(Sp3dV3D.signedAngleOnPlane(x, y, z * 5.0), closeTo(pi / 2, 1e-9));
    });

    test('zero projection returns 0', () {
      final a = Sp3dV3D(0, 0, 5); // 法線と平行（射影すると長さ0）
      expect(Sp3dV3D.signedAngleOnPlane(a, x, z), 0.0);
      expect(Sp3dV3D.signedAngleOnPlane(x, y, zero), 0.0);
    });
  });

  group('Sp3dV3D.angleOnPlane', () {
    test('returns unsigned angle [0, PI]', () {
      // 順序を逆にしても常に正
      expect(Sp3dV3D.angleOnPlane(x, y, z), closeTo(pi / 2, 1e-9));
      expect(Sp3dV3D.angleOnPlane(y, x, z), closeTo(pi / 2, 1e-9));
    });

    test('boundary: zero length after projection', () {
      final a = Sp3dV3D(0, 0, 5); // 法線平行
      expect(Sp3dV3D.angleOnPlane(a, x, z), 0.0);
    });
  });

  group('Sp3dV3D Plane Projections', () {
    test('projectOnPlane: removes normal component', () {
      final v = Sp3dV3D(1, 1, 1);
      final projected = v.projectOnPlane(y); // Y軸除去
      expect(projected.x, 1.0);
      expect(projected.y, 0.0);
      expect(projected.z, 1.0);

      expect(v.projectOnPlane(zero), equals(v)); // normal=0ならそのまま
    });

    test('directionOnPlane: returns unit vector or zero', () {
      final v = Sp3dV3D(10, 10, 0);
      final dir = v.directionOnPlane(z);
      expect(dir.len(), closeTo(1.0, 1e-9));
      expect(dir.x, closeTo(cos(pi / 4), 1e-9));

      final parallelV = Sp3dV3D(0, 0, 5);
      expect(parallelV.directionOnPlane(z), equals(zero)); // 平行ならzero
    });
  });
}
