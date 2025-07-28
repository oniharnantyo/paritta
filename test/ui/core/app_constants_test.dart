import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paritta_app/ui/core/app_constants.dart';

void main() {
  group('AppConstants Tests', () {
    test('Mobile constants have correct values', () {
      expect(AppConstants.mobileIconSize, 14.0);
      expect(AppConstants.mobileHorizontalPadding, 16.0);
      expect(AppConstants.mobileVerticalPadding, 16.0);
      expect(AppConstants.mobileAppBarHeight, 80.0);
    });

    test('Tablet constants have correct values', () {
      expect(AppConstants.tabletIconSize, 18.0);
      expect(AppConstants.tabletHorizontalPadding, 32.0);
      expect(AppConstants.tabletVerticalPadding, 24.0);
      expect(AppConstants.tabletAppBarHeight, 100.0);
    });
  });
}