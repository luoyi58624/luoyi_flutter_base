// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Base App`
  String get title {
    return Intl.message(
      'Flutter Base App',
      name: 'title',
      desc: 'App title',
      args: [],
    );
  }

  /// `Hello World!`
  String get helloWorld {
    return Intl.message(
      'Hello World!',
      name: 'helloWorld',
      desc: 'The conventional newborn programmer greeting',
      args: [],
    );
  }

  /// `Home`
  String get bottomLabelHome {
    return Intl.message(
      'Home',
      name: 'bottomLabelHome',
      desc: 'Bottom navbar label - Home',
      args: [],
    );
  }

  /// `Material`
  String get bottomLabelMaterial {
    return Intl.message(
      'Material',
      name: 'bottomLabelMaterial',
      desc: 'Bottom navbar label - Material',
      args: [],
    );
  }

  /// `Cupertino`
  String get bottomLabelCupertino {
    return Intl.message(
      'Cupertino',
      name: 'bottomLabelCupertino',
      desc: 'Bottom navbar label - Cupertino',
      args: [],
    );
  }

  /// `Custom`
  String get bottomLabelCustom {
    return Intl.message(
      'Custom',
      name: 'bottomLabelCustom',
      desc: 'Bottom navbar label - Home',
      args: [],
    );
  }

  /// `User`
  String get bottomLabelUser {
    return Intl.message(
      'User',
      name: 'bottomLabelUser',
      desc: 'Bottom navbar label - User',
      args: [],
    );
  }

  /// `Material Components`
  String get appbarLabelMaterial {
    return Intl.message(
      'Material Components',
      name: 'appbarLabelMaterial',
      desc: 'appbar label - Material',
      args: [],
    );
  }

  /// `Cupertino Components`
  String get appbarLabelCupertino {
    return Intl.message(
      'Cupertino Components',
      name: 'appbarLabelCupertino',
      desc: 'appbar label - Cupertino',
      args: [],
    );
  }

  /// `Custom Components`
  String get appbarLabelCustom {
    return Intl.message(
      'Custom Components',
      name: 'appbarLabelCustom',
      desc: 'appbar label - Custom',
      args: [],
    );
  }

  /// `Hihi, Luoyi`
  String get appbarLabelUser {
    return Intl.message(
      'Hihi, Luoyi',
      name: 'appbarLabelUser',
      desc: 'appbar label - User',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
