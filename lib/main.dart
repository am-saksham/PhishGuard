import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:phisguard/splash_screen.dart';
import 'package:phisguard/url_safety_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  bool _isHandlingDeepLink = false;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Listen for deep link updates
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('Deep link detected: $uri');
      _handleDeepLink(uri);
    }, onError: (error) {
      debugPrint('Error handling deep link: $error');
    });
  }

  void _handleDeepLink(Uri uri) {
    if (!_isHandlingDeepLink) {
      _isHandlingDeepLink = true;
      _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => URLSafetyScreen(url: uri.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: _navigatorKey,
    home: const SplashScreen(),
  );
}