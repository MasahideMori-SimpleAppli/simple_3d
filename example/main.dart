import 'package:flutter/material.dart';
import 'package:simple_3d/simple_3d.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('simple_3d:　Basic internal structure.'),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  sp3dObj.toDict().toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            )),
      ),
    );
  }
}
