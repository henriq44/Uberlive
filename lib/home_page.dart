import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uberapp/controller/controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ControllerStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                controller.isDeniedForever
                    ? Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => AppSettings.openLocationSettings(),
                            child: const Text('Ir para configurações'),
                          ),
                          const Text(
                              'Permissão negada, alterar em configurações'),
                        ],
                      )
                    : const Text('Permissão concedida'),
                Text(
                  'Maps',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Observer(builder: (_) {
        return FloatingActionButton(
          onPressed: () async {
            await controller.getPosition();

            Navigator.pushNamed(context, '/map');
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
