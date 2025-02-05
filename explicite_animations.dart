import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpliciteAnimations extends StatelessWidget {
  ExpliciteAnimations({super.key});

  /// List of animation names
  final List<Map<String, dynamic>> animationList = [
    {'name': 'Login', 'page': LoginScreen()},
    {'name': 'TweenAnimationBuilder', 'page': TweenExample()},
    {'name': 'AnimationController', 'page': AnimationControllers()},
    {'name': 'CurvedAnimation', 'page': CurvedAnimations()},
    {'name': 'FadeTransition', 'page': FadeTransitions()},
    {'name': 'SlideTransition', 'page': SlideTransitions()},
    {'name': 'ScaleTransition', 'page': ScaleTransitions()},
    {'name': 'RotationTransition', 'page': RotationTransitions()},
    {'name': 'SizeTransition', 'page': SizeTransitions()},
    {'name': 'PositionedTransition', 'page': PositionedTransitions()},
    {'name': 'DecoratedBoxTransition', 'page': DecoratedBoxTransitions()},
    {'name': 'AlignTransition', 'page': AlignTransitions()},
    {'name': 'LineAnimation', 'page': LineAnimation()},
    {'name': 'MorphingAnimation', 'page': MorphingAnimation()},
    {'name': 'CurvedLineAnimation', 'page': CurvedLineAnimation()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicite Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(animationList.length, (index) {
            return ElevatedButton(
              onPressed: () {
                Get.to(
                  animationList[index]['page'],
                  transition:
                      Transition.noTransition, // Disable default animation
                  opaque: false,
                  fullscreenDialog: true,
                  popGesture: true,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 800),
                );
              },
              child: Text(animationList[index]['name']),
            );
          }),
        ),
      ),
    );
  }
}

/// TweenAnimationBuilder
class TweenExample extends StatelessWidget {
  const TweenExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(seconds: 2),
          builder: (context, value, child) {
            return Opacity(opacity: value, child: child);
          },
          child: Container(width: 100, height: 100, color: Colors.blue),
        ),
      ),
    );
  }
}

/// AnimationController
class AnimationControllers extends StatefulWidget {
  const AnimationControllers({super.key});

  @override
  State<AnimationControllers> createState() => _AnimationControllersState();
}

class _AnimationControllersState extends State<AnimationControllers>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _controller.value,
              child: child,
            );
          },
          child: Container(width: 100, height: 100, color: Colors.red),
        ),
      ),
    );
  }
}

/// AlignTransition
class AlignTransitions extends StatefulWidget {
  const AlignTransitions({super.key});

  @override
  State<AlignTransitions> createState() => _AlignTransitionsState();
}

class _AlignTransitionsState extends State<AlignTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey.withOpacity(0.2),
          child: AlignTransition(
            alignment: _animation,
            child: Container(width: 50, height: 50, color: Colors.orange),
          ),
        ),
      ),
    );
  }
}

/// DecoratedBoxTransition
class DecoratedBoxTransitions extends StatefulWidget {
  const DecoratedBoxTransitions({super.key});

  @override
  State<DecoratedBoxTransitions> createState() =>
      _DecoratedBoxTransitionsState();
}

class _DecoratedBoxTransitionsState extends State<DecoratedBoxTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Decoration> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = DecorationTween(
      begin: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(0),
      ),
      end: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(50),
      ),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DecoratedBoxTransition(
          decoration: _animation,
          child: SizedBox(width: 100, height: 100),
        ),
      ),
    );
  }
}

/// PositionedTransition
class PositionedTransitions extends StatefulWidget {
  const PositionedTransitions({super.key});

  @override
  State<PositionedTransitions> createState() => _PositionedTransitionsState();
}

class _PositionedTransitionsState extends State<PositionedTransitions>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<RelativeRect> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(10, 10, 50, 50),
      end: RelativeRect.fromLTRB(50, 50, 10, 10),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionedTransition(
            rect: _animation,
            child: Container(width: 100, height: 100, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class SizeTransitions extends StatefulWidget {
  const SizeTransitions({super.key});

  @override
  State<SizeTransitions> createState() => _SizeTransitionsState();
}

class _SizeTransitionsState extends State<SizeTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SizeTransition Example")),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.center,
                heightFactor: _animation.value, // Now animated correctly
                child: Container(width: 100, height: 100, color: Colors.blue),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// RotationTransition
class RotationTransitions extends StatefulWidget {
  const RotationTransitions({super.key});

  @override
  State<RotationTransitions> createState() => _RotationTransitionsState();
}

class _RotationTransitionsState extends State<RotationTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Container(width: 100, height: 100, color: Colors.pink),
        ),
      ),
    );
  }
}

/// ScaleTransition
class ScaleTransitions extends StatefulWidget {
  const ScaleTransitions({super.key});

  @override
  State<ScaleTransitions> createState() => _ScaleTransitionsState();
}

class _ScaleTransitionsState extends State<ScaleTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.5, end: 1.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Container(width: 100, height: 100, color: Colors.teal),
        ),
      ),
    );
  }
}

/// SlideTransition
class SlideTransitions extends StatefulWidget {
  const SlideTransitions({super.key});

  @override
  State<SlideTransitions> createState() => _SlideTransitionsState();
}

class _SlideTransitionsState extends State<SlideTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(1, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Container(width: 100, height: 100, color: Colors.orange),
        ),
      ),
    );
  }
}

/// FadeTransition
class FadeTransitions extends StatefulWidget {
  const FadeTransitions({super.key});

  @override
  State<FadeTransitions> createState() => _FadeTransitionsState();
}

class _FadeTransitionsState extends State<FadeTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Container(width: 100, height: 100, color: Colors.purple),
        ),
      ),
    );
  }
}

/// CurvedAnimation
class CurvedAnimations extends StatefulWidget {
  const CurvedAnimations({super.key});

  @override
  State<CurvedAnimations> createState() => _CurvedAnimationsState();
}

class _CurvedAnimationsState extends State<CurvedAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Container(width: 100, height: 100, color: Colors.green),
        ),
      ),
    );
  }
}

/// CurvedLineAnimation
class LineAnimation extends StatefulWidget {
  const LineAnimation({super.key});

  @override
  State<LineAnimation> createState() => _LineAnimationState();
}

class _LineAnimationState extends State<LineAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Curved Line Animation")),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(300, 200),
              painter: CurvedLinePainter(_animation.value),
            );
          },
        ),
      ),
    );
  }
}

/// 🎨 CustomPainter to draw animated curved lines
class CurvedLinePainter extends CustomPainter {
  final double phase;

  CurvedLinePainter(this.phase);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    for (double x = 0; x < size.width; x++) {
      double y = 50 * sin((x / size.width) * 2 * pi + phase) + size.height / 2;
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvedLinePainter oldDelegate) {
    return oldDelegate.phase != phase;
  }
}

class MorphingAnimation extends StatefulWidget {
  const MorphingAnimation({super.key});

  @override
  State<MorphingAnimation> createState() => _MorphingAnimationState();
}

class _MorphingAnimationState extends State<MorphingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _shapeState = 0; // 0: Curve, 1: Circle, 2: Rectangle

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (_shapeState == 2) {
      _shapeState = 0;
      _controller.reverse();
    } else {
      _shapeState++;
      _controller.forward(from: 0);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Morphing Animation")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(300, 300),
                  painter: MorphingPainter(_animation.value, _shapeState),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startAnimation,
            child: Text(
              _shapeState == 2 ? "Reset to Curve" : "Next Shape",
            ),
          ),
        ],
      ),
    );
  }
}

/// 🎨 CustomPainter for Morphing Shapes
class MorphingPainter extends CustomPainter {
  final double progress;
  final int shapeState;

  MorphingPainter(this.progress, this.shapeState);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    final Path path = Path();

    if (shapeState == 0) {
      /// 🌀 Step 1: Draw a Quadratic Bezier Curve
      path.moveTo(0, size.height / 2);
      final double controlX = size.width / 2;
      final double controlY = (size.height / 2) - (100 * (1 - progress));
      final double endX = size.width;
      final double endY = size.height / 2;
      path.quadraticBezierTo(controlX, controlY, endX, endY);
    } else if (shapeState == 1) {
      /// 🔵 Step 2: Morph to Circle
      double radius = lerpDouble(50, 150, progress)!;
      path.addOval(
          Rect.fromCircle(center: size.center(Offset.zero), radius: radius));
    } else {
      /// 🟦 Step 3: Morph to Rectangle
      double sizeFactor = lerpDouble(50, 200, progress)!;
      path.addRect(Rect.fromCenter(
        center: size.center(Offset.zero),
        width: sizeFactor,
        height: sizeFactor,
      ));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MorphingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.shapeState != shapeState;
  }
}

/// CurvedLineAnimation
class CurvedLineAnimation extends StatefulWidget {
  const CurvedLineAnimation({super.key});

  @override
  State<CurvedLineAnimation> createState() => _CurvedLineAnimationState();
}

class _CurvedLineAnimationState extends State<CurvedLineAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _shapeState = 0; // 0: Curved Line, 1: Circle, 2: Rectangle

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (_shapeState == 2) {
      _shapeState = 0;
      _controller.reverse();
    } else {
      _shapeState++;
      _controller.forward(from: 0);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Curve → Circle → Rectangle")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(300, 300),
                  painter: CurvedShapePainter(_animation.value, _shapeState),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startAnimation,
            child: Text(
              _shapeState == 2 ? "Reset to Curve" : "Next Shape",
            ),
          ),
        ],
      ),
    );
  }
}

/// 🎨 CustomPainter for Drawing Animated Shapes
class CurvedShapePainter extends CustomPainter {
  final double progress;
  final int shapeState;

  CurvedShapePainter(this.progress, this.shapeState);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Path path = Path();

    if (shapeState == 0) {
      /// 🌀 **Step 1: Draw a Curved Line**
      path.moveTo(0, size.height / 2);
      final double controlX = size.width / 2;
      final double controlY = (size.height / 2) - (100 * (1 - progress));
      final double endX = size.width;
      final double endY = size.height / 2;
      path.quadraticBezierTo(controlX, controlY, endX, endY);
    } else if (shapeState == 1) {
      /// 🔵 **Step 2: Morph into a Circle**
      double radius = lerpDouble(20, 120, progress)!;
      path.addOval(
          Rect.fromCircle(center: size.center(Offset.zero), radius: radius));
    } else {
      /// 🟦 **Step 3: Morph into a Rectangle with Curves**
      double width = lerpDouble(50, 200, progress)!;
      double height = lerpDouble(50, 100, progress)!;
      double curveFactor = lerpDouble(30, 0, progress)!;
      path.moveTo(size.width / 2 - width / 2, size.height / 2 - height / 2);
      path.relativeLineTo(width - curveFactor, 0);
      path.relativeQuadraticBezierTo(curveFactor, 0, curveFactor, curveFactor);
      path.relativeLineTo(0, height - curveFactor);
      path.relativeQuadraticBezierTo(0, curveFactor, -curveFactor, curveFactor);
      path.relativeLineTo(-width + curveFactor, 0);
      path.relativeQuadraticBezierTo(
          -curveFactor, 0, -curveFactor, -curveFactor);
      path.relativeLineTo(0, -height + curveFactor);
      path.relativeQuadraticBezierTo(
          0, -curveFactor, curveFactor, -curveFactor);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvedShapePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.shapeState != shapeState;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final LoginController controller = Get.put(LoginController());

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController with `vsync` from the Stateful widget.
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    // Pass the AnimationController to the LoginController
    controller.setupAnimations(_animationController);

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Opacity(
                opacity: controller.fadeAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, controller.slideAnimation.value),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Email TextField with custom style
                  TextField(
                    controller: controller.emailController,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Password TextField with custom style
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Login Button with left to right progress animation
                  GestureDetector(
                    onTap: () async {
                      await controller.login();
                    },
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              // Progress Bar Fill
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Container(
                                    height: 50,
                                    width: _animationController.value *
                                        MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(
                                          0.5), // Transparent green color
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  );
                                },
                              ),
                              // Text on top of the Progress Bar
                              Center(
                                child: controller.isLoading.value
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                            strokeWidth: 2,
                                          ),
                                          SizedBox(width: 10),
                                          Text("Logging In..."),
                                        ],
                                      )
                                    : Text("Login",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                              ),
                            ],
                          ),
                        );
                      },
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

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: NavigatorState(),
      duration: Duration(milliseconds: 800),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));

    slideAnimation = Tween<double>(begin: 50, end: 0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();
  }

  void setupAnimations(AnimationController controller) {
    animationController = controller;
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));

    slideAnimation = Tween<double>(begin: 50, end: 0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));
  }

  Future<void> login() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    if (emailController.text == "test@gmail.com" &&
        passwordController.text == "123456") {
      Get.snackbar("Success", "Login Successful!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Get.offAllNamed("/home");
    } else {
      Get.snackbar("Error", "Invalid Credentials",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
