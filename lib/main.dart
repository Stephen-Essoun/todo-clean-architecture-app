import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ExtensionsTest());
  }
}

class ExtensionsTest extends StatefulWidget {
  const ExtensionsTest({super.key});

  @override
  State<ExtensionsTest> createState() => _ExtensionsTestState();
}

class _ExtensionsTestState extends State<ExtensionsTest> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extensions on widgets')),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          Future.delayed(
              const Duration(seconds: 3),
              () => setState(
                    () {
                      isLoading = false;
                    },
                  ));
        },
        child: const Text('/extentions on'),
      ).loading(isLoading)),
    );
  }
}

extension WhileWait on ElevatedButton {
  Widget loading(bool isLoading) {
    return isLoading
        ? const ElevatedButton(
            onPressed: null,
            child: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator.adaptive(),
            ))
        : this;
  }
}
