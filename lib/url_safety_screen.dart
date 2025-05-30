import 'package:flutter/material.dart';
import 'package:phisguard/url_safety.dart';
import 'package:url_launcher/url_launcher.dart';

class URLSafetyScreen extends StatefulWidget {
  final String url;

  const URLSafetyScreen({super.key, required this.url});

  @override
  State<URLSafetyScreen> createState() => _URLSafetyScreenState();
}

class _URLSafetyScreenState extends State<URLSafetyScreen> {
  late final Future<bool> _safetyFuture;

  @override
  void initState() {
    super.initState();
    _safetyFuture = checkUrlSafety(widget.url);
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('URL Safety Scanner'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<bool>(
            future: _safetyFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Scanning URL...'),
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error scanning URL.'));
              }

              final bool isSafe = snapshot.data ?? false;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.url,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isSafe
                        ? 'The URL is safe.'
                        : 'The URL appears to be suspicious!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: isSafe ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => _launchUrl(widget.url, context),
                    child: const Text('Open in Chrome'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              );
            },
          ),
        ),
      );

  Future<void> _launchUrl(String url, BuildContext context) async {
    try {
      final Uri chromeUri = Uri.parse('googlechrome://navigate?url=${Uri.encodeFull(url)}');
      if (await canLaunchUrl(chromeUri)) {
        await launchUrl(chromeUri);
      } else {
        throw Exception('Chrome is not installed.');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to open the URL in Chrome. Please ensure Chrome is installed.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}