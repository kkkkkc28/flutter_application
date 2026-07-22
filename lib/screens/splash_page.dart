import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utils/web_splash_bridge.dart';
import '../widgets/auth_background.dart';
import '../widgets/splash_content.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  static const _pulseDuration = Duration(milliseconds: 1400);

  late final AnimationController _transitionController;
  late final AnimationController _pulseController;
  late final Animation<double> _loginFade;
  late final Animation<Offset> _loginSlide;
  late final Animation<double> _splashFade;
  late final Animation<double> _pulseScale;

  bool _showLogin = false;
  bool _splashVisible = true;
  bool _nativeSplashRemoved = false;

  @override
  void initState() {
    super.initState();

    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: _pulseDuration,
    );

    _syncNativeAnimationPhase();
    _pulseController.repeat(reverse: true);

    final curved = CurvedAnimation(
      parent: _transitionController,
      curve: Curves.easeInOutCubic,
    );

    _loginFade = Tween<double>(begin: 0, end: 1).animate(curved);
    _loginSlide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(curved);
    _splashFade = Tween<double>(begin: 1, end: 0).animate(curved);
    _pulseScale = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _removeNativeSplashWhenReady();
      });
      _bootstrap();
    });
  }

  void _syncNativeAnimationPhase() {
    final startMs = nativeSplashAnimationStartMs();
    if (startMs == null) return;

    final elapsed = DateTime.now().millisecondsSinceEpoch - startMs;
    _pulseController.value = (elapsed % _pulseDuration.inMilliseconds) /
        _pulseDuration.inMilliseconds;
  }

  void _removeNativeSplashWhenReady() {
    if (_nativeSplashRemoved) return;
    _nativeSplashRemoved = true;
    removeNativeSplash();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    setState(() => _showLogin = true);
    await _transitionController.forward();
    if (!mounted) return;
    setState(() => _splashVisible = false);
  }

  @override
  void dispose() {
    _transitionController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F766E),
      body: AuthBackground(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_showLogin)
              FadeTransition(
                opacity: _loginFade,
                child: SlideTransition(
                  position: _loginSlide,
                  child: const LoginPage(embedded: true),
                ),
              ),
            if (_splashVisible)
              IgnorePointer(
                ignoring: _transitionController.isCompleted,
                child: FadeTransition(
                  opacity: _splashFade,
                  child: SplashContent(
                    pulseScale: _pulseScale,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
