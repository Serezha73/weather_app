import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.clearDay).existsSync(), isTrue);
    expect(File(AppImages.clearNight).existsSync(), isTrue);
    expect(File(AppImages.cloudsDay).existsSync(), isTrue);
    expect(File(AppImages.cloudsDayNight).existsSync(), isTrue);
    expect(File(AppImages.feelsLike).existsSync(), isTrue);
    expect(File(AppImages.geolocation).existsSync(), isTrue);
    expect(File(AppImages.humidity).existsSync(), isTrue);
    expect(File(AppImages.iconCloud).existsSync(), isTrue);
    expect(File(AppImages.littleCloudDay).existsSync(), isTrue);
    expect(File(AppImages.littleCloudNight).existsSync(), isTrue);
    expect(File(AppImages.moonCloud).existsSync(), isTrue);
    expect(File(AppImages.rain).existsSync(), isTrue);
    expect(File(AppImages.rainNight).existsSync(), isTrue);
    expect(File(AppImages.search).existsSync(), isTrue);
    expect(File(AppImages.snow).existsSync(), isTrue);
    expect(File(AppImages.snowNight).existsSync(), isTrue);
    expect(File(AppImages.thunderstorm).existsSync(), isTrue);
    expect(File(AppImages.wind).existsSync(), isTrue);
  });
}
