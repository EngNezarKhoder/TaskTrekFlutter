import 'package:flutter/material.dart';
import 'package:task_app/widgets/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _navigateToMainPage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()));
  }

  @override
  void initState() {
    super.initState();
    _navigateToMainPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffed7899),
        child: Center(
          child: Image.asset("images/icons8-todoist-64.png"),
        ),
      ),
    );
  }
}
