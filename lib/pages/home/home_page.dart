import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/feature.dart';
import '../../routes.dart';
import '../../widgets/app_nav_bar.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool get _isDesktopOrWeb =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  void _openDetail(BuildContext context, Feature feature) {
    Navigator.pushNamed(context, Routes.detail, arguments: feature);
  }

  Widget _featureCard(BuildContext context, Feature feature) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(feature.icon, color: Colors.blue),
        title: Text(feature.title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openDetail(context, feature),
      ),
    );
  }

  Widget _imagesCarousel(List<String> images) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                images[index],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.cloud, color: Colors.blue),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _featuresList(
    BuildContext context,
    List<Feature> features,
    bool wide,
    double gap,
  ) {
    if (features.isEmpty) {
      return const Center(child: Text('Список пуст'));
    }
    if (wide) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: features.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: gap,
          crossAxisSpacing: 16,
          mainAxisExtent: 72,
        ),
        itemBuilder: (context, index) => _featureCard(context, features[index]),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: features.length,
      separatorBuilder: (_, _) => SizedBox(height: gap),
      itemBuilder: (context, index) => _featureCard(context, features[index]),
    );
  }

  Widget _content(
    BuildContext context,
    HomeState state,
    bool wide,
    double gap,
  ) {
    switch (state) {
      case HomeInitial():
        return const Center(child: Text('Данные ещё не загружены'));
      case HomeLoading():
        return const Center(child: CircularProgressIndicator());
      case HomeError(:final message):
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    context.read<HomeBloc>().add(const LoadFeaturesEvent()),
                child: const Text('Повторить'),
              ),
            ],
          ),
        );
      case HomeLoaded(:final features, :final images):
        return Column(
          children: [
            _imagesCarousel(images),
            SizedBox(height: gap),
            Expanded(child: _featuresList(context, features, wide, gap)),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool wide = width > 600;
    final double gap = _isDesktopOrWeb ? 32 : 12;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cloud Storage',
          style: TextStyle(fontFamily: 'PressStart2P', color: Colors.purple),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Облачные хранилища',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: gap),
                const Text(
                  'Современный сервис для загрузки, скачивания и долгосрочного '
                  'хранения любых типов файлов. Защитите свои данные от утери, '
                  'делитесь ссылками с друзьями и коллегами и синхронизируйте '
                  'информацию между всеми своими устройствами в реальном времени.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) => _content(context, state, wide, gap),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: gap, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, color: Colors.blue, size: 50),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Плотников Максим Павлович',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('ИКБО-60-23', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppNavBar(selectedIndex: 0),
    );
  }
}
