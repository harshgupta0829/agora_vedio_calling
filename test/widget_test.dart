
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:talknearn/main.dart';
import 'package:talknearn/screens/auth/login_screen.dart';

class MockAgoraRtmClient extends Mock implements AgoraRtmClient {}

void main() {
  testWidgets('Renders LoginScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(client: MockAgoraRtmClient()));

    // Verify that LoginScreen is rendered.
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
