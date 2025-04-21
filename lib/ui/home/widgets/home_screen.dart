import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:paritta_app/ui/home/cubit/home_cubit.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [HomePage(), ParittaScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab.index,
        onTap: (index) {
          switch (index) {
            case 1:
              context.read<ParittaBloc>().add(const MainMenuRequested());
          }
          context.read<HomeCubit>().setTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Paritta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Panduan',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverAppBar(
            expandedHeight: 80,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMEEEEd('id').format(DateTime.now()),
                      style: textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        Text(
                          '${DateTime.now().year + 544} BE',
                          style: textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '-',
                          style: textTheme.titleSmall,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Lunar ${Lunar.fromDate(DateTime.now()).getDay()}',
                          style: textTheme.titleSmall,
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.nightlight,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              )
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/quote_background.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '"Karaniyametta Sutta"',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tak bergaul dengan orang yang tak bijaksana\n'
                                  'Bergaul dengan mereka yang bijaksana\n'
                                  'Menghormat mereka yang patut dihormat\n'
                                  'Itulah Berkah Utama',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Terakhir Dibaca')],
                ),
                Card.outlined(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Tuntunan Puja Bhakti'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              'assets/images/tuntunan_puja_bhakti.png'),
                        ),
                        trailing: FilledButton(
                            onPressed: () {}, child: const Text('Mulai')),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Favorit')],
                ),
                Card.outlined(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Tuntunan Puja Bhakti'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              'assets/images/tuntunan_puja_bhakti.png'),
                        ),
                        trailing: FilledButton(
                            onPressed: () {}, child: const Text('Mulai')),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: Column(),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  height: 225,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/quote_background.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '"Karaniyametta Sutta"',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Tak bergaul dengan orang yang tak bijaksana\n'
                                'Bergaul dengan mereka yang bijaksana\n'
                                'Menghormat mereka yang patut dihormat\n'
                                'Itulah Berkah Utama',
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Terakhir Dibaca')],
              ),
              Card.outlined(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Tuntunan Puja Bhakti'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                            'assets/images/tuntunan_puja_bhakti.png'),
                      ),
                      trailing: FilledButton(
                          onPressed: () {}, child: const Text('Mulai')),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Favorit')],
              ),
              Card.outlined(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Tuntunan Puja Bhakti'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                            'assets/images/tuntunan_puja_bhakti.png'),
                      ),
                      trailing: FilledButton(
                          onPressed: () {}, child: const Text('Mulai')),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
