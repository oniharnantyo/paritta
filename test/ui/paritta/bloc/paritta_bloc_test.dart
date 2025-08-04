import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';
import 'package:paritta_app/domain/repository/paritta_repository.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';

class MockMenuRepository extends Mock implements MenuRepository {}

class MockParittaRepository extends Mock implements ParittaRepository {}

class FakeMenu extends Fake implements Menu {}

class FakeMenuItem extends Fake implements MenuItem {}

void main() {
  group('ParittaBloc', () {
    late MenuRepository menuRepository;
    late ParittaRepository parittaRepository;
    late ParittaBloc parittaBloc;

    setUpAll(() {
      registerFallbackValue(FakeMenu());
      registerFallbackValue(FakeMenuItem());
    });

    setUp(() {
      menuRepository = MockMenuRepository();
      parittaRepository = MockParittaRepository();
      parittaBloc = ParittaBloc(
        menuRepository: menuRepository,
        parittaRepository: parittaRepository,
      );
    });

    tearDown(() {
      parittaBloc.close();
    });

    test('initial state is correct', () {
      expect(parittaBloc.state.status, equals(ParittaStatus.initial));
    });

    blocTest<ParittaBloc, ParittaState>(
      'emits category titles when CategoryTitlesRequested is added',
      build: () {
        when(() => menuRepository.getMainMenus())
            .thenAnswer((_) async => [
                  const Menu(
                    title: 'Umum',
                    menus: [],
                  ),
                  const Menu(
                    title: 'Upacara',
                    menus: [],
                  ),
                ]);
        return parittaBloc;
      },
      act: (bloc) => bloc.add(const CategoryTitlesRequested()),
      expect: () => [
        const ParittaState(status: ParittaStatus.loading),
        const ParittaState(
          status: ParittaStatus.success,
          categoryTitles: ['Umum', 'Upacara'],
        ),
      ],
    );
  });
}