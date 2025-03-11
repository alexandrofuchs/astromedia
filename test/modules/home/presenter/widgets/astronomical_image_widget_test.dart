import 'package:astromedia/modules/home/presenter/widgets/astronomical_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('astronomical image widget ...', (tester) async {
    await tester.pumpWidget(AstronomicalImageWidget(uri: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo3EwEdzdUs6GtLmGyFLcClr-UipWleLJApA&s',));
    await tester.pumpAndSettle();
    final clipFinder = find.byType(ClipRRect);
    expect(clipFinder, findsOneWidget);
    await tester.pumpAndSettle();
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });
}