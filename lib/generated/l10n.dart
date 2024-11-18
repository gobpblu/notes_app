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

  /// `Заметки`
  String get notes {
    return Intl.message(
      'Заметки',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Напоминания`
  String get reminders {
    return Intl.message(
      'Напоминания',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `Профиль`
  String get profile {
    return Intl.message(
      'Профиль',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Создание заметки`
  String get note_create {
    return Intl.message(
      'Создание заметки',
      name: 'note_create',
      desc: '',
      args: [],
    );
  }

  /// `Редактирование заметки`
  String get note_edit {
    return Intl.message(
      'Редактирование заметки',
      name: 'note_edit',
      desc: '',
      args: [],
    );
  }

  /// `Введите текст`
  String get enter_text {
    return Intl.message(
      'Введите текст',
      name: 'enter_text',
      desc: '',
      args: [],
    );
  }

  /// `Введите заголовок`
  String get enter_title {
    return Intl.message(
      'Введите заголовок',
      name: 'enter_title',
      desc: '',
      args: [],
    );
  }

  /// `Авторизоваться`
  String get login {
    return Intl.message(
      'Авторизоваться',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрироваться`
  String get register {
    return Intl.message(
      'Зарегистрироваться',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Почта`
  String get email {
    return Intl.message(
      'Почта',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Почта введена некорректно`
  String get email_error_text {
    return Intl.message(
      'Почта введена некорректно',
      name: 'email_error_text',
      desc: '',
      args: [],
    );
  }

  /// `Пароль должен содержать минимум 6 символов`
  String get password_error_text {
    return Intl.message(
      'Пароль должен содержать минимум 6 символов',
      name: 'password_error_text',
      desc: '',
      args: [],
    );
  }

  /// `Пользователь успешно зарегистрирован`
  String get successfully_registered {
    return Intl.message(
      'Пользователь успешно зарегистрирован',
      name: 'successfully_registered',
      desc: '',
      args: [],
    );
  }

  /// `ОК`
  String get ok {
    return Intl.message(
      'ОК',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get sign_in {
    return Intl.message(
      'Войти',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Предупреждение`
  String get save_local_data_title {
    return Intl.message(
      'Предупреждение',
      name: 'save_local_data_title',
      desc: '',
      args: [],
    );
  }

  /// `У вас есть локальные заметки, хотите ли вы их сохранить?`
  String get save_local_data_description {
    return Intl.message(
      'У вас есть локальные заметки, хотите ли вы их сохранить?',
      name: 'save_local_data_description',
      desc: '',
      args: [],
    );
  }

  /// `Да`
  String get button_yes {
    return Intl.message(
      'Да',
      name: 'button_yes',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get button_no {
    return Intl.message(
      'Нет',
      name: 'button_no',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get button_save {
    return Intl.message(
      'Сохранить',
      name: 'button_save',
      desc: '',
      args: [],
    );
  }

  /// `Событие`
  String get reminder_event {
    return Intl.message(
      'Событие',
      name: 'reminder_event',
      desc: '',
      args: [],
    );
  }

  /// `Задача`
  String get reminder_task {
    return Intl.message(
      'Задача',
      name: 'reminder_task',
      desc: '',
      args: [],
    );
  }

  /// `Весь день`
  String get reminder_task_all_day {
    return Intl.message(
      'Весь день',
      name: 'reminder_task_all_day',
      desc: '',
      args: [],
    );
  }

  /// `Введите описание`
  String get reminder_task_enter_description {
    return Intl.message(
      'Введите описание',
      name: 'reminder_task_enter_description',
      desc: '',
      args: [],
    );
  }

  /// `Введите заголовок`
  String get reminder_task_enter_title {
    return Intl.message(
      'Введите заголовок',
      name: 'reminder_task_enter_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
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
