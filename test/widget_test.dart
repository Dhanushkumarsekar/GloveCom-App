// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:glovecom/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }





import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import the home screen directly
import 'package:glovecom/screens/home_screen.dart';

void main() {
  testWidgets('App launches successfully and shows title', (WidgetTester tester) async {
    // Wrap the HomeScreen with MaterialApp so AppBar, theme and Navigator work.
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    // let animations/timers run a bit (if any)
    await tester.pump(const Duration(seconds: 1));

    // Verify that the AppBar title 'GloveCom' is present.
    expect(find.text('GloveCom'), findsOneWidget);
  });
}