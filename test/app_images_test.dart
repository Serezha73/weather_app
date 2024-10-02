import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.feelsLike).existsSync(), isTrue);
    expect(File(AppImages.geolocation).existsSync(), isTrue);
    expect(File(AppImages.humidity).existsSync(), isTrue);
    expect(File(AppImages.iconCloud).existsSync(), isTrue);
    expect(File(AppImages.moonCloud).existsSync(), isTrue);
    expect(File(AppImages.search).existsSync(), isTrue);
    expect(File(AppImages.wind).existsSync(), isTrue);
  });
}
