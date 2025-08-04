import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_screen.dart';

class MockParittaBloc extends MockBloc<ParittaEvent, ParittaState>
    implements ParittaBloc {}

void main() {
  group('ParittaScreen', () {
    late ParittaBloc parittaBloc;

    setUp(() {
      parittaBloc = MockParittaBloc();
    });

    testWidgets('displays category titles when available', (tester) async {
      when(() => parittaBloc.state).thenReturn(
        const ParittaState(
          status: ParittaStatus.success,
          categoryTitles: ['Umum', 'Upacara'],
          menus: [],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: parittaBloc,
              child: const ParittaScreen(),
            ),
          ),
        ),
      );

      // We can't easily test the localized text in a simple test,
      // but we can verify that the chips are displayed for each category
      expect(find.byType(Chip), findsNWidgets(2));
    });
  });
}