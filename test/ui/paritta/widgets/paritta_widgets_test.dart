import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/model/paritta.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_reader_bloc.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_list_screen.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_reader_screen.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_reader_wrapper_screen.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_screen.dart';

class MockParittaBloc extends Mock implements ParittaBloc {}

class MockParittaReaderBloc extends Mock implements ParittaReaderBloc {}

void main() {
  group('Paritta Widgets Tests', () {
    late ParittaBloc parittaBloc;
    late ParittaReaderBloc readerBloc;

    setUp(() {
      parittaBloc = MockParittaBloc();
      readerBloc = MockParittaReaderBloc();
    });

    testWidgets('ParittaScreen renders correctly', (tester) async {
      when(() => parittaBloc.state).thenReturn(
        const ParittaState(
          status: ParittaStatus.success,
          menus: [
            Menu(
              title: 'Test Menu',
              menus: [
                MenuItem(id: 'item1', title: 'Item 1'),
              ],
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: parittaBloc,
            child: const ParittaScreen(),
          ),
        ),
      );

      expect(find.text('Paritta'), findsWidgets);
      expect(find.text('Test Menu'), findsOneWidget);
    });

    testWidgets('ParittaListScreen renders correctly', (tester) async {
      when(() => parittaBloc.state).thenReturn(
        const ParittaState(
          status: ParittaStatus.success,
          menu: Menu(
            title: 'Test Menu',
            menus: [
              MenuItem(id: 'item1', title: 'Item 1', description: 'Description 1'),
            ],
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: parittaBloc,
            child: const ParittaListScreen(menuId: 'test'),
          ),
        ),
      );

      expect(find.text('Test Menu'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Description 1'), findsOneWidget);
    });

    testWidgets('ParittaReaderScreen renders correctly', (tester) async {
      const paritta = Paritta(text: 'Test content');
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: readerBloc,
            child: const ParittaReaderScreen(
              paritta: paritta,
              title: 'Test Reader',
            ),
          ),
        ),
      );

      expect(find.text('Test Reader'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
    });
  });
}