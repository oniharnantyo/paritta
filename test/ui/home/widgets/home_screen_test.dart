import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/model/quote.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:paritta_app/ui/home/bloc/home_bloc.dart';
import 'package:paritta_app/ui/home/cubit/home_tab_cubit.dart';
import 'package:paritta_app/ui/home/widgets/home_screen.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/setting/bloc/setting_bloc.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockParittaBloc extends MockBloc<ParittaEvent, ParittaState>
    implements ParittaBloc {}

class MockSettingBloc extends MockBloc<SettingEvent, SettingState>
    implements SettingBloc {}

class MockHomeTabCubit extends MockCubit<HomeTabState> implements HomeTabCubit {}

void main() {
  group('HomeScreen', () {
    late HomeBloc homeBloc;
    late ParittaBloc parittaBloc;
    late SettingBloc settingBloc;
    late HomeTabCubit homeTabCubit;

    setUp(() {
      homeBloc = MockHomeBloc();
      parittaBloc = MockParittaBloc();
      settingBloc = MockSettingBloc();
      homeTabCubit = MockHomeTabCubit();

      when(() => homeBloc.state).thenReturn(const HomeState());
      when(() => parittaBloc.state).thenReturn(const ParittaState());
      when(() => settingBloc.state).thenReturn(const SettingState());
    });

    Widget buildWidget() {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: homeBloc),
          BlocProvider.value(value: parittaBloc),
          BlocProvider.value(value: settingBloc),
          BlocProvider.value(value: homeTabCubit),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: HomeScreen()),
        ),
      );
    }

    testWidgets('renders correctly', (WidgetTester tester) async {
      when(() => homeTabCubit.state).thenReturn(const HomeTabState());
      await tester.pumpWidget(buildWidget());
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('taps on Home tab and dispatches correct events',
        (WidgetTester tester) async {
      when(() => homeTabCubit.state).thenReturn(const HomeTabState(tab: HomeTab.paritta));
      when(() => homeTabCubit.setTab(0)).thenReturn(null);

      await tester.pumpWidget(buildWidget());

      await tester.tap(find.byIcon(Icons.home));
      await tester.pump();

      verify(() => homeTabCubit.setTab(0)).called(1);
      verify(() => homeBloc.add(const FavoriteMenusRequested())).called(1);
      verify(() => homeBloc.add(const LastReadMenuRequested())).called(1);
      verify(() => homeBloc.add(const TodayQuoteRequested())).called(1);
    });

    testWidgets('taps on Paritta tab and dispatches correct events',
        (WidgetTester tester) async {
      when(() => homeTabCubit.state).thenReturn(const HomeTabState());
      when(() => homeTabCubit.setTab(1)).thenReturn(null);

      await tester.pumpWidget(buildWidget());

      await tester.tap(find.byIcon(Icons.menu_book));
      await tester.pump();

      verify(() => homeTabCubit.setTab(1)).called(1);
      verify(() => parittaBloc.add(const MainMenuRequested())).called(1);
    });

    testWidgets('taps on Guide tab and dispatches correct events',
        (WidgetTester tester) async {
      when(() => homeTabCubit.state).thenReturn(const HomeTabState());
      when(() => homeTabCubit.setTab(2)).thenReturn(null);

      await tester.pumpWidget(buildWidget());

      await tester.tap(find.byIcon(Icons.map));
      await tester.pump();

      verify(() => homeTabCubit.setTab(2)).called(1);
    });

    testWidgets('taps on Setting tab and dispatches correct events',
        (WidgetTester tester) async {
      when(() => homeTabCubit.state).thenReturn(const HomeTabState());
      when(() => homeTabCubit.setTab(3)).thenReturn(null);
      when(() => settingBloc.add(const SettingAppConfigRequested()))
          .thenReturn(null);

      await tester.pumpWidget(buildWidget());

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pump();

      verify(() => homeTabCubit.setTab(3)).called(1);
      verifyNever(() => settingBloc.add(const SettingAppConfigRequested()));
    });
  });

  group('HomePage', () {
    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = MockHomeBloc();
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: homeBloc,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: HomePage()),
        ),
      );
    }

    testWidgets('renders correctly', (WidgetTester tester) async {
      when(() => homeBloc.state).thenReturn(const HomeState());
      await tester.pumpWidget(buildWidget());
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('shows loading indicator when status is loading',
        (WidgetTester tester) async {
      when(() => homeBloc.state)
          .thenReturn(const HomeState(status: HomeStatus.loading));
      await tester.pumpWidget(buildWidget());
      // Expect three indicators because of the two BlocBuilders plus one from SliverAppBar
      expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
    });

    testWidgets('shows snackbar when status is error',
        (WidgetTester tester) async {
      whenListen(
        homeBloc,
        Stream.fromIterable(
            [const HomeState(status: HomeStatus.error, error: 'error')]),
        initialState: const HomeState(),
      );
      await tester.pumpWidget(buildWidget());
      await tester.pump(); // Pump once for the state change
      await tester.pump(); // Pump again for the snackbar to appear
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('error'), findsOneWidget);
    });

    testWidgets('shows today quote when loaded', (WidgetTester tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeState(
          status: HomeStatus.success,
          todayQuote: Quote(quote: 'Test Quote', source: 'Test Source'),
        ),
      );
      await tester.pumpWidget(buildWidget());
      expect(find.text('"Test Source"'), findsOneWidget);
      expect(find.text('Test Quote'), findsOneWidget);
    });

    testWidgets('shows last read menu when available',
        (WidgetTester tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeState(
          status: HomeStatus.success,
          lastReadMenu:
              MenuItem(id: '1', title: 'Last Read Title', image: 'assets/images/tuntunan_puja_bhakti.png'),
        ),
      );
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle(); // Ensure asset loads
      expect(find.text('Last Read Title'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('shows message when no last read menu',
        (WidgetTester tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeState(status: HomeStatus.success, lastReadMenu: null),
      );
      await tester.pumpWidget(buildWidget());
      expect(find.text('Start reading a Paritta to see it here'), findsOneWidget);
    });

    testWidgets('shows favorite menus when available',
        (WidgetTester tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeState(
          status: HomeStatus.success,
          favoriteMenus: [
            MenuItem(id: '1', title: 'Fav 1', image: 'assets/images/tuntunan_puja_bhakti.png'),
            MenuItem(id: '2', title: 'Fav 2', image: 'assets/images/tuntunan_puja_bhakti.png'),
          ],
        ),
      );
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle(); // Ensure assets load
      expect(find.text('Fav 1'), findsOneWidget);
      expect(find.text('Fav 2'), findsOneWidget);
      expect(find.byType(FilledButton), findsNWidgets(2));
    });

    testWidgets('shows message when no favorite menus',
        (WidgetTester tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeState(status: HomeStatus.success, favoriteMenus: []),
      );
      await tester.pumpWidget(buildWidget());
      expect(find.text('Your favorite Parittas will appear here'), findsOneWidget);
    });
  });
}