import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Flutter Demo Desktop Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Body(counter: _counter),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
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
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                if (widget.counter > 10)
                  const SizedBox(
                      width: 700,
                      child: Image(
                          image: AssetImage('assets/images/cubresa-logo.png'))),
                const SizedBox(height: 50),
                const Text('Press the + button more than 10 times to see a surprise 🎉'),
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
