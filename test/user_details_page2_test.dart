import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/models/user_repository.dart';
import 'package:flutter_application_2/presentation/user_details_page.dart';
import 'package:flutter_application_2/repositories/user_details_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockRepository extends Mock implements UserDetailsRepositoryImp{
}

void main() {

  late UserDetailsRepositoryImp repositoryImp;
  late User mockUser;

  setUp(() {
    repositoryImp = MockRepository();
    mockUser = User(
      name: "HelyezerTeofilo-cit", 
      bio: "Testando bio", 
      avatarUrl: "avatarUrl", 
      repositories: [
        Repository(name: 'repo1', url: 'https://github.com/user/repo1'),
        Repository(name: 'repo2', url: 'https://github.com/user/repo2'),
        Repository(name: 'repo3', url: 'https://github.com/user/repo3'),
      ]);
  });

  testWidgets("User details screen displays user's name", (WidgetTester tester) async{

    when(()=> repositoryImp.getUserDataByUsername(any())).thenAnswer((_) async => mockUser);

    await tester.pumpWidget(
        MaterialApp(
          home: UserDetailsPageStV(
            username: "helyezerteofilo-cit", 
            repositoryImp: repositoryImp
            ),
        ),
    );
    await tester.pump();

    expect(find.text("HelyezerTeofilo-cit"),findsOneWidget);
  });

  testWidgets("User details screen displays user's bio", (WidgetTester tester) async{
    
    when(()=> repositoryImp.getUserDataByUsername(any())).thenAnswer((_) async => mockUser);

    await tester.pumpWidget(
        MaterialApp(
          home: UserDetailsPageStV(
            username: "helyezerteofilo-cit", 
            repositoryImp: repositoryImp
            ),
        ),
    );
    await tester.pump();

    expect(find.text("Testando bio"),findsOneWidget);
  });

  testWidgets("User details screen displays user's repositories", (WidgetTester tester) async{
    
    when(()=> repositoryImp.getUserDataByUsername(any())).thenAnswer((_) async => mockUser);

    await tester.pumpWidget(
        MaterialApp(
          home: UserDetailsPageStV(
            username: "helyezerteofilo-cit", 
            repositoryImp: repositoryImp
            ),
        ),
    );
    await tester.pump();
    
    expect(find.text("repo1"),findsOneWidget);
    expect(find.text("repo2"),findsOneWidget);
    expect(find.text("repo3"),findsOneWidget);
  });




}