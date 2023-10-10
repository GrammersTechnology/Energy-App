import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: background,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: background,
    titleTextStyle: labelMedium,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: onSurface),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelStyle: labelSmall,
    labelStyle: labelSmall,
    dividerColor: Colors.transparent,
    labelColor: surface,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: const BoxDecoration(
      color: onSurface,
    ),
    unselectedLabelColor: onSurface,
    labelPadding: const EdgeInsets.symmetric(vertical: 0),
    overlayColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: surface,
    selectedItemColor: onSurface,
    unselectedItemColor: onSurfaceVariant,
    unselectedLabelStyle: labelSmall,
    selectedLabelStyle: labelSmall,
  ),
  iconTheme: const IconThemeData(color: onSurface),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: primary,
  ).copyWith(
    primary: primary,
    primaryContainer: primaryContainer,
    onPrimary: onPrimary,
    surface: surface,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    secondary: secondary,
    outline: outline,
    background: background,
  ),
  textTheme: TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  ),
);

//TODO: Implement darkmode theme
final darkTheme = ThemeData(
  scaffoldBackgroundColor: backgroundDark,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: background,
    titleTextStyle: labelMedium,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: onSurface),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelStyle: labelSmall,
    labelStyle: labelSmall,
    dividerColor: Colors.transparent,
    labelColor: surface,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: const BoxDecoration(
      color: onSurface,
    ),
    unselectedLabelColor: onSurface,
    labelPadding: const EdgeInsets.symmetric(vertical: 0),
    overlayColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: surface,
    selectedItemColor: onSurface,
    unselectedItemColor: onSurfaceVariant,
    unselectedLabelStyle: labelSmall,
    selectedLabelStyle: labelSmall,
  ),
  iconTheme: const IconThemeData(color: onSurfaceDark),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: primaryDark,
  ).copyWith(
    primary: primaryDark,
    primaryContainer: primaryContainerDark,
    onPrimary: onPrimaryDark,
    surface: surfaceDark,
    onSurface: onSurfaceDark,
    onSurfaceVariant: onSurfaceVariantDark,
    secondary: secondaryDark,
    outline: outlineDark,
    background: backgroundDark,
  ),
  textTheme: TextTheme(
    displayLarge: displayLarge.copyWith(color: onSurfaceDark),
    displayMedium: displayMedium.copyWith(color: onSurfaceDark),
    displaySmall: displaySmall.copyWith(color: onSurfaceDark),
    headlineLarge: headlineLarge.copyWith(color: onSurfaceDark),
    headlineMedium: headlineMedium.copyWith(color: onSurfaceDark),
    headlineSmall: headlineSmall.copyWith(color: onSurfaceDark),
    titleLarge: titleLarge.copyWith(color: onSurfaceDark),
    titleMedium: titleMedium.copyWith(color: onSurfaceDark),
    titleSmall: titleSmall.copyWith(color: onSurfaceDark),
    labelLarge: labelLarge.copyWith(color: onSurfaceDark),
    labelMedium: labelMedium.copyWith(color: onSurfaceDark),
    labelSmall: labelSmall.copyWith(color: onSurfaceDark),
    bodyLarge: bodyLarge.copyWith(color: onSurfaceDark),
    bodyMedium: bodyMedium.copyWith(color: onSurfaceDark),
    bodySmall: bodySmall.copyWith(color: onSurfaceDark),
  ),
);
