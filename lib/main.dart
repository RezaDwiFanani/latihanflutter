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
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
      title: 'Professional Counter',
      theme: ThemeData(
        useMaterial3: true, // Menggunakan Material Design 3 yang lebih modern
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4), // Warna dasar Ungu Modern
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(
          0xFFF3F4F6,
        ), // Background abu lembut
      ),
      home: const HalamanUtama(),
    );
  }
}

// --- HALAMAN 1: MENU UTAMA ---
class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)], // Gradient Pastel
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.dashboard_customize,
                    size: 60,
                    color: Color(0xFF6750A4),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Pilih mode penghitung di bawah",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 32),

                  // Tombol Increment
                  _MenuButton(
                    label: "Mode Tambah (+)",
                    icon: Icons.add_circle_outline,
                    color: Colors.deepPurple,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HalamanCounter(mode: CounterMode.increment),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tombol Decrement
                  _MenuButton(
                    label: "Mode Kurang (-)",
                    icon: Icons.remove_circle_outline,
                    color: Colors.redAccent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HalamanCounter(mode: CounterMode.decrement),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget tombol custom agar kodingan lebih rapi
class _MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// --- ENUM UNTUK MENENTUKAN MODE ---
enum CounterMode { increment, decrement }

// --- HALAMAN COUNTER (DIGABUNG AGAR LEBIH EFISIEN) ---
class HalamanCounter extends StatefulWidget {
  final CounterMode mode;

  const HalamanCounter({super.key, required this.mode});

  @override
  State<HalamanCounter> createState() => _HalamanCounterState();
}

class _HalamanCounterState extends State<HalamanCounter> {
  int _counter = 0;
  Color _textColor = const Color(0xFF2D3748); // Warna awal Dark Grey

  void _updateCounter() {
    setState(() {
      if (widget.mode == CounterMode.increment) {
        _counter++;
      } else {
        _counter--;
      }
      _textColor = _getRandomColor();
    });
  }

  Color _getRandomColor() {
    // Menghasilkan warna yang lebih kontras & estetik (tidak terlalu pucat)
    return Color.fromARGB(
      255,
      Random().nextInt(200), // Max 200 agar tidak terlalu putih
      Random().nextInt(200),
      Random().nextInt(200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIncrement = widget.mode == CounterMode.increment;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          isIncrement ? "Increment Mode" : "Decrement Mode",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TAP BUTTON BELOW",
              style: TextStyle(
                color: Colors.grey[400],
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),

            // Animasi Transisi Angka
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                '$_counter',
                key: ValueKey<int>(_counter), // Key penting untuk animasi
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: _textColor.withOpacity(0.3),
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 40),
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: _updateCounter,
          elevation: 10,
          backgroundColor: isIncrement
              ? const Color(0xFF6750A4)
              : const Color(0xFFD93025),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            isIncrement ? Icons.add : Icons.remove,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
