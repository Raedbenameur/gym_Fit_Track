import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym/widgets/web_preview_shell.dart';

void main() {
  testWidgets('phone preview can scroll vertically in the canvas', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(760, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: WebPreviewShell(
          child: Scaffold(body: ColoredBox(color: Colors.black)),
        ),
      ),
    );

    final phone = find.byKey(const Key('web-preview-phone'));
    final scrollView = find.byKey(const Key('web-preview-canvas-scroll'));
    expect(tester.getSize(phone).height, greaterThan(640));
    final initialTop = tester.getTopLeft(phone).dy;

    await tester.drag(scrollView, const Offset(0, -160));
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(phone).dy, lessThan(initialTop));
    expect(tester.takeException(), isNull);
  });
}
