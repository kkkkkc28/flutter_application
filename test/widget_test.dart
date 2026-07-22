import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Splash transitions to login page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('正在加载应用…'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pump();

    expect(find.text('请登录以继续使用'), findsOneWidget);
    expect(find.text('登 录'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
