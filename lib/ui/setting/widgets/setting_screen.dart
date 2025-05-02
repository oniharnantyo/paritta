import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:paritta_app/app/cubit/app_cubit.dart';
import 'package:paritta_app/domain/model/app_config.dart';
import 'package:paritta_app/ui/setting/bloc/setting_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final themeData = SettingsThemeData(
      leadingIconsColor: colorScheme.onSurface,
      tileDescriptionTextColor: colorScheme.onSurfaceVariant,
      dividerColor: colorScheme.outlineVariant,
      trailingTextColor: colorScheme.onSurface,
      settingsListBackground: colorScheme.surface,
      settingsSectionBackground: colorScheme.surfaceContainerLow,
      settingsTileTextColor: colorScheme.onSurface,
      tileHighlightColor: colorScheme.surfaceContainerHighest,
      titleTextColor: colorScheme.onSurface,
      inactiveTitleColor: colorScheme.onSurfaceVariant,
      inactiveSubtitleColor: colorScheme.onSurfaceVariant,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: BlocListener<SettingBloc, SettingState>(
        listener: (context, state) {
          if (state.status == SettingStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error ?? 'Error loading setting')),
              );
          }
        },
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            String themeValue;
            switch (state.appConfig?.theme) {
              case ThemeMode.light:
                themeValue = 'Terang';
              case ThemeMode.dark:
                themeValue = 'Gelap';
              case ThemeMode.system:
                themeValue = 'Sistem';
              case null:
                themeValue = 'Sistem';
            }

            String languageValue;
            switch (state.appConfig?.language) {
              case Language.en:
                languageValue = 'English';
              case Language.id:
                languageValue = 'Bahasa Indonesia';
              case null:
                languageValue = 'Bahasa Indonesia';
            }

            return SettingsList(
              lightTheme: themeData,
              darkTheme: themeData,
              sections: [
                SettingsSection(
                  title: Text('Umum'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.language),
                      title: Text('Language'),
                      value: Text(languageValue),
                      onPressed: (context) {
                        final bloc = context.read<SettingBloc>();
                        final appCubit = context.read<AppCubit>();
                        showModalBottomSheet<void>(
                          context: context,
                          elevation: 10,
                          showDragHandle: true,
                          builder: (modalContext) {
                            return BlocProvider.value(
                              value: bloc,
                              child: _languageBottomSheet(bloc, appCubit),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                SettingsSection(
                  title: Text('Tampilan'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.brightness_4_outlined),
                      title: Text('Tema'),
                      value: Text(themeValue),
                      onPressed: (context) {
                        final bloc = context.read<SettingBloc>();
                        final appCubit = context.read<AppCubit>();
                        showModalBottomSheet<void>(
                          context: context,
                          elevation: 10,
                          showDragHandle: true,
                          builder: (modalContext) {
                            return BlocProvider.value(
                              value: bloc,
                              child: _themeBottomSheet(bloc, appCubit),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                SettingsSection(
                  title: Text('Lain-lain'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.info),
                      title: Text('Tentang'),
                      onPressed: (context) => showAboutDialog(
                        context: context,
                        applicationName: 'Paritta',
                        applicationVersion: '1.0.0',
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _themeBottomSheet(SettingBloc bloc, AppCubit appCubit) {
    bloc.add(const SettingAppConfigRequested());

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: SizedBox(
        width: double.infinity,
        child: BlocListener<SettingBloc, SettingState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == SettingStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.error ?? 'Error saving theme')),
                );
            }
          },
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: Text(
                      'Pilih Tema',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: const Text('Terang'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.light,
                      groupValue: state.appConfig?.theme,
                      onChanged: (ThemeMode? value) {
                        bloc.add(const ThemeSaved(ThemeMode.light));
                        appCubit.updateAppConfig(
                            state.appConfig!.copyWith(theme: ThemeMode.light));
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Gelap'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.dark,
                      groupValue: state.appConfig?.theme,
                      onChanged: (ThemeMode? value) {
                        bloc.add(const ThemeSaved(ThemeMode.dark));
                        appCubit.updateAppConfig(
                            state.appConfig!.copyWith(theme: ThemeMode.dark));
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Sesuai Sistem'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.system,
                      groupValue: state.appConfig?.theme,
                      onChanged: (ThemeMode? value) {
                        bloc.add(const ThemeSaved(ThemeMode.system));
                        appCubit.updateAppConfig(
                            state.appConfig!.copyWith(theme: ThemeMode.system));
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _languageBottomSheet(SettingBloc bloc, AppCubit appCubit) {
    bloc.add(const SettingAppConfigRequested());

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: SizedBox(
        width: double.infinity,
        child: BlocListener<SettingBloc, SettingState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == SettingStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                      content: Text(state.error ?? 'Error saving language')),
                );
            }
          },
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: Text(
                      'Pilih Bahasa',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: const Text('Bahasa Indonesia'),
                    leading: Radio<Language>(
                      value: Language.id,
                      groupValue: state.appConfig?.language,
                      onChanged: (Language? value) {
                        bloc.add(const LanguageSaved(Language.id));
                        appCubit.updateAppConfig(
                            state.appConfig!.copyWith(language: Language.id));
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('English'),
                    leading: Radio<Language>(
                      value: Language.en,
                      groupValue: state.appConfig?.language,
                      onChanged: (Language? value) {
                        bloc.add(const LanguageSaved(Language.en));
                        appCubit.updateAppConfig(
                            state.appConfig!.copyWith(language: Language.en));
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
