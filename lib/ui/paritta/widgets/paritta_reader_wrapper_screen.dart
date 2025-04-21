import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_reader_bloc.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_reader_screen.dart';

class ParittaReaderWrapperScreen extends StatefulWidget {
  const ParittaReaderWrapperScreen({
    required this.initialPage,
    super.key,
  });

  final int initialPage;

  @override
  State<ParittaReaderWrapperScreen> createState() =>
      _ParittaReaderWrapperScreenState();
}

class _ParittaReaderWrapperScreenState
    extends State<ParittaReaderWrapperScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(widget.initialPage);
      }
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ParittaBloc, ParittaState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ParittaStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error ?? 'Error loading paritta')),
              );
          }
        },
        child: BlocBuilder<ParittaBloc, ParittaState>(
          builder: (context, state) {
            if (state.status == ParittaStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status != ParittaStatus.success) {
              return const SizedBox();
            }

            return PageView.builder(
              controller: _pageController,
              itemCount: state.parittas.length,
              itemBuilder: (context, index) {
                return Builder(
                  builder: (context) => BlocProvider.value(
                    value: context.read<ParittaReaderBloc>(),
                    child: ParittaReaderScreen(
                      title: state.menu?.menus[index].title ?? '',
                      paritta: state.parittas[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
