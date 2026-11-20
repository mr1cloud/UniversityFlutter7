import 'package:flutter/material.dart';

import '../models/feature.dart';

const List<String> images = [
  'assets/images/cloud-storage.png',
  'assets/images/amazon-cloud.png',
  'assets/images/azure-cloud.png',
  'assets/images/cloudflare-cloud.png',
  'assets/images/google-cloud.png',
];

const List<Feature> features = [
  Feature(
    title: 'Удобный интерфейс',
    icon: Icons.touch_app,
    image: 'assets/images/cloud-storage.png',
    description:
        'Простой и понятный интерфейс: загружайте, скачивайте и '
        'упорядочивайте файлы в несколько касаний.',
  ),
  Feature(
    title: 'Контроль доступа',
    icon: Icons.lock,
    image: 'assets/images/amazon-cloud.png',
    description:
        'Настраивайте, кто может просматривать и редактировать ваши файлы. '
        'Делитесь ссылками с друзьями и коллегами.',
  ),
  Feature(
    title: 'Бесплатно до 1ТБ',
    icon: Icons.sd_storage,
    image: 'assets/images/azure-cloud.png',
    description:
        'Бесплатный тариф включает до 1 ТБ места для долгосрочного '
        'хранения любых типов файлов.',
  ),
  Feature(
    title: 'Синхронизация',
    icon: Icons.sync,
    image: 'assets/images/google-cloud.png',
    description:
        'Информация синхронизируется между всеми вашими устройствами '
        'в реальном времени.',
  ),
];
