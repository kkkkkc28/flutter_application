import 'package:flutter/material.dart';

/// 与 web/index.html 静态启动页像素级对齐，确保 HTML → Flutter 无感衔接。
class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
    required this.pulseScale,
  });

  final Animation<double> pulseScale;

  static const _subtitle = '正在加载应用…';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: pulseScale,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.9),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.lock_outline,
                size: 36,
                color: Colors.white.withValues(alpha: 0.95),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '欢迎回来',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: Colors.white.withValues(alpha: 0.85),
              backgroundColor: Colors.white.withValues(alpha: 0.25),
            ),
          ),
        ],
      ),
    );
  }
}
