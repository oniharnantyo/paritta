import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:paritta_app/domain/model/paritta.dart';
import 'package:paritta_app/domain/model/reader_config.dart';
import 'package:paritta_app/ui/core/app_constants.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_reader_bloc.dart';

class ParittaReaderScreen extends StatelessWidget {
  const ParittaReaderScreen(
      {required this.paritta, required this.title, super.key});

  final Paritta paritta;
  final String title;

  static const double defaultFontSize = 24;

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(title),
            floating: true,
            snap: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    final bloc = context.read<ParittaReaderBloc>();
                    showModalBottomSheet<void>(
                      context: context,
                      elevation: 10,
                      showDragHandle: true,
                      builder: (modalContext) => BlocProvider.value(
                        value: bloc,
                        child: _bottomSheet(bloc, i10n),
                      ),
                    );
                  },
                  icon: const Icon(Icons.format_size))
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.mobileHorizontalPadding,
                vertical: AppConstants.mobileVerticalPadding / 2),
            sliver: SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  final state = context.watch<ParittaReaderBloc>().state;

                  return MarkdownBlock(
                    data: paritta.text,
                    config: MarkdownConfig(
                      configs: [
                        PConfig(
                          textStyle: TextStyle(
                            fontSize:
                                state.readerConfig?.fontSize ?? defaultFontSize,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet(ParittaReaderBloc bloc, AppLocalizations i10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppConstants.mobileHorizontalPadding, 0, AppConstants.mobileHorizontalPadding, 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              i10n.fontSize,
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.mobileHorizontalPadding),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('T', style: TextStyle(fontSize: 16)),
                  Text('T', style: TextStyle(fontSize: 32)),
                ],
              ),
            ),
            BlocBuilder<ParittaReaderBloc, ParittaReaderState>(
              bloc: bloc,
              builder: (context, state) {
                return Slider(
                  value: state.readerConfig?.fontSize ?? defaultFontSize,
                  min: 16,
                  max: 32,
                  divisions: 6,
                  onChanged: (value) => bloc.add(
                    ParittaReaderConfigSaved(ReaderConfig(fontSize: value)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
