import 'package:flutter/material.dart';
import 'package:sample_http/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:sample_http/exception.dart';

void main() {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ApiClient _client;

  @override
  void initState() {
    const token = String.fromEnvironment('GITHUB_TOKEN');
    _client = ApiClient(
      http.Client(),
      baseUrl: 'https://api.github.com',
      defaultHeaders: {
        'Accept': 'application/vnd.github+json',
        'Authorization': 'Bearer $token',
        'X-GitHub-Api-Version': '2022-11-28'
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  final res = await _client.get(path: 'repositories');
                  print(res);
                } on ApiException catch (e) {
                  print(e.message);
                } on Exception catch (e) {
                  print(e);
                }
              },
              child: const Text('リポジトリ取得'),
            ),
          ],
        ),
      ),
    );
  }
}
