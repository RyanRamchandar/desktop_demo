import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _brightness = Brightness.light;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final colors = [
    Colors.teal,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];
  var _colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _brightness,
        primarySwatch: colors[_colorIndex % colors.length],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Desktop Home Page'),
          actions: [
            IconButton(
                onPressed: _changeColor,
                icon: const Icon(Icons.color_lens)),
            IconButton(
                onPressed: _toggleDarkMode,
                icon: const Icon(Icons.nightlight_round_sharp)),
          ],
        ),
        body: Body(counter: _counter),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Text(
            '🎉',
            style: TextStyle(fontSize: 30),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      );
  }

  void _changeColor() {
    setState((){
      _colorIndex++;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      if (_brightness == Brightness.light) {
        _brightness = Brightness.dark;
      } else {
        _brightness = Brightness.light;
      }
    });
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.counter,
  }) : super(key: key);

  final int counter;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 0;
  late ConfettiController _controllerCenter;
  bool _checked = false;
  String _dropDownValue = 'Watermelon';

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          minWidth: 100,
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.account_circle),
              label: Text('Section 1'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.accessibility),
              label: Text('Section 2'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: Text('Section 3'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.info_outline),
              label: Text('Section 4'),
            ),
          ],
          onDestinationSelected: (selected) {
            setState(() {
              _selectedIndex = selected;
            });
          },
          selectedIndex: _selectedIndex,
        ),
        const VerticalDivider(width: 0,),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                if (widget.counter > 10)
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      const SizedBox(
                        width: 700,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/cubresa-logo.png')),
                          ),
                        ),
                      ),
                      ConfettiWidget(
                        confettiController: _controllerCenter..play(),
                        blastDirectionality: BlastDirectionality.explosive,
                        // don't specify a direction, blast randomly
                        shouldLoop: false,
                        // start again as soon as the animation is finished
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple
                        ],
                        // manually specify the colors to be used
                        createParticlePath:
                            drawStar, // define a custom shape/path.
                      )
                    ],
                  ),
                const SizedBox(height: 50),
                const Text(
                    'Press the 🎉 button more than 10 times to see a surprise'),
                Text(
                  '${widget.counter}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated Button'),
                ),
                const SizedBox(height: 25),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined Button'),
                ),
                const SizedBox(height: 25),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text Button'),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 400,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText('This text is selectable'),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  value: _checked,
                                  onChanged: (value) {
                                    setState(() {
                                      _checked = value ?? false;
                                    });
                                  }),
                              const SizedBox(width: 4),
                              const Text('Checkbox'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          DropdownButton(
                              value: _dropDownValue,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Watermelon',
                                  child: Text('Watermelon'),
                                ),
                                DropdownMenuItem(
                                    value: 'Peach', child: Text('Peach')),
                                DropdownMenuItem(
                                    value: 'Lime', child: Text('Lime')),
                                DropdownMenuItem(
                                    value: 'Grape', child: Text('Grape')),
                                DropdownMenuItem(
                                    value: 'Mango', child: Text('Mango')),
                                DropdownMenuItem(
                                    value: 'Coconut', child: Text('Coconut')),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _dropDownValue = value ?? '';
                                });
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Text field with an alert!'),
                            onFieldSubmitted: (String value) async {
                              await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Thanks!'),
                                    content: Text(
                                        'You typed "$value", which has length ${value.characters.length}.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const LinearProgressIndicator(
                            minHeight: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Age',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Role',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Location',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Sarah')),
                          DataCell(Text('19')),
                          DataCell(Text('Student')),
                          DataCell(Text('Winnipeg, MB')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Janine')),
                          DataCell(Text('43')),
                          DataCell(Text('Professor')),
                          DataCell(Text('London, ON')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('William')),
                          DataCell(Text('27')),
                          DataCell(Text('Associate Professor')),
                          DataCell(Text('Phoenix, AZ')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
