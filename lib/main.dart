import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Single Page Counter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066FF)),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SinglePageCounter(),
    );
  }
}

class SinglePageCounter extends StatefulWidget {
  const SinglePageCounter({super.key});

  @override
  State<SinglePageCounter> createState() => _SinglePageCounterState();
}

class _SinglePageCounterState extends State<SinglePageCounter> {
  int _counter = 0;
  Color _bgColor = const Color(0xFF0F172A); // initial deep background
  Color _numberColor = Colors.white;

  void _increment() {
    setState(() {
      _counter++;
      _bgColor = _randomColor();
      _numberColor = _contrastFor(_bgColor);
    });
  }

  Color _randomColor() {
    final rnd = Random();
    // keep colors vibrant but not too bright
    return Color.fromARGB(
      255,
      60 + rnd.nextInt(160),
      60 + rnd.nextInt(160),
      60 + rnd.nextInt(160),
    );
  }

  Color _contrastFor(Color c) {
    // simple luminance-based contrast
    return c.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // animated background color change
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_bgColor, _bgColor.withOpacity(0.85)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title / Logo
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _numberColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.exposure_plus_1,
                        color: _numberColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Professional Tap Counter',
                      style: TextStyle(
                        color: _numberColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // Display card with animated number
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 36),
                  decoration: BoxDecoration(
                    color: _numberColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'TAPS',
                        style: TextStyle(
                          color: _numberColor.withOpacity(0.85),
                          fontSize: 12,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                        child: Text(
                          '$_counter',
                          key: ValueKey<int>(_counter),
                          style: TextStyle(
                            fontSize: 96,
                            fontWeight: FontWeight.w800,
                            color: _numberColor,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Centered floating '+' button — pressing increments and randomizes color
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: FloatingActionButton(
          onPressed: _increment,
          backgroundColor: _numberColor, // contrast: button bg = text color
          child: Icon(
            Icons.add,
            color: _bgColor, // icon uses current bg color for contrast
            size: 36,
          ),
          elevation: 12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
