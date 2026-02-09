import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @authenticating.
  ///
  /// In ru, this message translates to:
  /// **'Аутентификация...'**
  String get authenticating;

  /// No description provided for @authFailed.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка аутентификации. Нажмите, чтобы повторить.'**
  String get authFailed;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @clients.
  ///
  /// In ru, this message translates to:
  /// **'Клиенты'**
  String get clients;

  /// No description provided for @deals.
  ///
  /// In ru, this message translates to:
  /// **'Сделки'**
  String get deals;

  /// No description provided for @analytics.
  ///
  /// In ru, this message translates to:
  /// **'Аналитика'**
  String get analytics;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @enableBiometric.
  ///
  /// In ru, this message translates to:
  /// **'Включить вход по биометрии'**
  String get enableBiometric;

  /// No description provided for @openaiApiKey.
  ///
  /// In ru, this message translates to:
  /// **'OpenAI API Ключ'**
  String get openaiApiKey;

  /// No description provided for @enterApiKey.
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш OpenAI API Ключ'**
  String get enterApiKey;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @apiKeySaved.
  ///
  /// In ru, this message translates to:
  /// **'API Ключ сохранен'**
  String get apiKeySaved;

  /// No description provided for @clientName.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get clientName;

  /// No description provided for @clientPhone.
  ///
  /// In ru, this message translates to:
  /// **'Телефон'**
  String get clientPhone;

  /// No description provided for @clientEmail.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get clientEmail;

  /// No description provided for @clientAddress.
  ///
  /// In ru, this message translates to:
  /// **'Адрес'**
  String get clientAddress;

  /// No description provided for @clientComment.
  ///
  /// In ru, this message translates to:
  /// **'Комментарий'**
  String get clientComment;

  /// No description provided for @addClient.
  ///
  /// In ru, this message translates to:
  /// **'Добавить клиента'**
  String get addClient;

  /// No description provided for @editClient.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать клиента'**
  String get editClient;

  /// No description provided for @deleteClient.
  ///
  /// In ru, this message translates to:
  /// **'Удалить клиента'**
  String get deleteClient;

  /// No description provided for @saveClient.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить клиента'**
  String get saveClient;

  /// No description provided for @dealStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get dealStatus;

  /// No description provided for @dealAmount.
  ///
  /// In ru, this message translates to:
  /// **'Сумма'**
  String get dealAmount;

  /// No description provided for @dealProducts.
  ///
  /// In ru, this message translates to:
  /// **'Товары'**
  String get dealProducts;

  /// No description provided for @addDeal.
  ///
  /// In ru, this message translates to:
  /// **'Добавить сделку'**
  String get addDeal;

  /// No description provided for @deleteDeal.
  ///
  /// In ru, this message translates to:
  /// **'Удалить сделку'**
  String get deleteDeal;

  /// No description provided for @saveDeal.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить сделку'**
  String get saveDeal;

  /// No description provided for @totalTurnover.
  ///
  /// In ru, this message translates to:
  /// **'Оборот'**
  String get totalTurnover;

  /// No description provided for @totalProfit.
  ///
  /// In ru, this message translates to:
  /// **'Прибыль'**
  String get totalProfit;

  /// No description provided for @averageMargin.
  ///
  /// In ru, this message translates to:
  /// **'Маржа'**
  String get averageMargin;

  /// No description provided for @dealsCount.
  ///
  /// In ru, this message translates to:
  /// **'Количество сделок'**
  String get dealsCount;

  /// No description provided for @averageCheck.
  ///
  /// In ru, this message translates to:
  /// **'Средний чек'**
  String get averageCheck;

  /// No description provided for @salesReport.
  ///
  /// In ru, this message translates to:
  /// **'Отчет по продажам'**
  String get salesReport;

  /// No description provided for @summary.
  ///
  /// In ru, this message translates to:
  /// **'Сводка'**
  String get summary;

  /// No description provided for @indicator.
  ///
  /// In ru, this message translates to:
  /// **'Показатель'**
  String get indicator;

  /// No description provided for @value.
  ///
  /// In ru, this message translates to:
  /// **'Значение'**
  String get value;

  /// No description provided for @details.
  ///
  /// In ru, this message translates to:
  /// **'Детализация'**
  String get details;

  /// No description provided for @productName.
  ///
  /// In ru, this message translates to:
  /// **'Название товара'**
  String get productName;

  /// No description provided for @quantity.
  ///
  /// In ru, this message translates to:
  /// **'Количество'**
  String get quantity;

  /// No description provided for @price.
  ///
  /// In ru, this message translates to:
  /// **'Цена'**
  String get price;

  /// No description provided for @tax.
  ///
  /// In ru, this message translates to:
  /// **'Налог (%)'**
  String get tax;

  /// No description provided for @addProduct.
  ///
  /// In ru, this message translates to:
  /// **'Добавить товар'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать товар'**
  String get editProduct;

  /// No description provided for @searchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по имени, телефону или email'**
  String get searchHint;

  /// No description provided for @noClientsFound.
  ///
  /// In ru, this message translates to:
  /// **'Клиенты не найдены'**
  String get noClientsFound;

  /// No description provided for @error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: {error}'**
  String error(Object error);

  /// Заголовок сделки без ID
  ///
  /// In ru, this message translates to:
  /// **'Сделка'**
  String get dealTitle;

  /// No description provided for @exportPdf.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт в PDF'**
  String get exportPdf;

  /// No description provided for @exportExcel.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт в Excel'**
  String get exportExcel;

  /// No description provided for @exportError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка экспорта: {error}'**
  String exportError(Object error);

  /// No description provided for @newClient.
  ///
  /// In ru, this message translates to:
  /// **'Новый клиент'**
  String get newClient;

  /// No description provided for @newDeal.
  ///
  /// In ru, this message translates to:
  /// **'Новая сделка'**
  String get newDeal;

  /// No description provided for @editDeal.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать сделку'**
  String get editDeal;

  /// No description provided for @client.
  ///
  /// In ru, this message translates to:
  /// **'Клиент'**
  String get client;

  /// No description provided for @errorLoadingClients.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки клиентов: {error}'**
  String errorLoadingClients(String error);

  /// No description provided for @monthlyGoal.
  ///
  /// In ru, this message translates to:
  /// **'Цель на месяц'**
  String get monthlyGoal;

  /// No description provided for @setMonthlyGoal.
  ///
  /// In ru, this message translates to:
  /// **'Установить цель'**
  String get setMonthlyGoal;

  /// No description provided for @targetTurnoverLabel.
  ///
  /// In ru, this message translates to:
  /// **'Целевой оборот'**
  String get targetTurnoverLabel;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @maxDeal.
  ///
  /// In ru, this message translates to:
  /// **'Макс. сделка'**
  String get maxDeal;

  /// No description provided for @turnoverDynamics.
  ///
  /// In ru, this message translates to:
  /// **'Динамика оборота'**
  String get turnoverDynamics;

  /// No description provided for @noDataForPeriod.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных за период'**
  String get noDataForPeriod;

  /// No description provided for @dealsDetails.
  ///
  /// In ru, this message translates to:
  /// **'Детализация сделок'**
  String get dealsDetails;

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get language;

  /// No description provided for @english.
  ///
  /// In ru, this message translates to:
  /// **'Английский'**
  String get english;

  /// No description provided for @russian.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @history.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get history;

  /// No description provided for @documents.
  ///
  /// In ru, this message translates to:
  /// **'Документы'**
  String get documents;

  /// No description provided for @quote.
  ///
  /// In ru, this message translates to:
  /// **'КП (Quote)'**
  String get quote;

  /// No description provided for @contract.
  ///
  /// In ru, this message translates to:
  /// **'Договор'**
  String get contract;

  /// No description provided for @historyOfChanges.
  ///
  /// In ru, this message translates to:
  /// **'История изменений'**
  String get historyOfChanges;

  /// No description provided for @noHistoryFound.
  ///
  /// In ru, this message translates to:
  /// **'История не найдена'**
  String get noHistoryFound;

  /// No description provided for @costPrice.
  ///
  /// In ru, this message translates to:
  /// **'Себестоимость'**
  String get costPrice;

  /// No description provided for @description.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get description;

  /// No description provided for @info.
  ///
  /// In ru, this message translates to:
  /// **'Инфо'**
  String get info;

  /// No description provided for @createdAt.
  ///
  /// In ru, this message translates to:
  /// **'Создан'**
  String get createdAt;

  /// No description provided for @noInteractionHistory.
  ///
  /// In ru, this message translates to:
  /// **'Нет истории взаимодействий'**
  String get noInteractionHistory;

  /// No description provided for @addInteraction.
  ///
  /// In ru, this message translates to:
  /// **'Добавить взаимодействие'**
  String get addInteraction;

  /// No description provided for @type.
  ///
  /// In ru, this message translates to:
  /// **'Тип'**
  String get type;

  /// No description provided for @notes.
  ///
  /// In ru, this message translates to:
  /// **'Заметки'**
  String get notes;

  /// No description provided for @dateTime.
  ///
  /// In ru, this message translates to:
  /// **'Дата и время'**
  String get dateTime;

  /// No description provided for @remindMe.
  ///
  /// In ru, this message translates to:
  /// **'Напомнить мне'**
  String get remindMe;

  /// No description provided for @total.
  ///
  /// In ru, this message translates to:
  /// **'Итого: {amount}'**
  String total(String amount);

  /// No description provided for @interactionReminder.
  ///
  /// In ru, this message translates to:
  /// **'Напоминание: {type}'**
  String interactionReminder(String type);

  /// No description provided for @add.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get add;

  /// No description provided for @periodToday.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get periodToday;

  /// No description provided for @periodWeek.
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In ru, this message translates to:
  /// **'Месяц'**
  String get periodMonth;

  /// No description provided for @periodCustom.
  ///
  /// In ru, this message translates to:
  /// **'Период'**
  String get periodCustom;

  /// No description provided for @interactionCall.
  ///
  /// In ru, this message translates to:
  /// **'Звонок'**
  String get interactionCall;

  /// No description provided for @interactionMeeting.
  ///
  /// In ru, this message translates to:
  /// **'Встреча'**
  String get interactionMeeting;

  /// No description provided for @interactionNote.
  ///
  /// In ru, this message translates to:
  /// **'Заметка'**
  String get interactionNote;

  /// No description provided for @interactionOther.
  ///
  /// In ru, this message translates to:
  /// **'Другое'**
  String get interactionOther;

  /// No description provided for @dealStatusInProgress.
  ///
  /// In ru, this message translates to:
  /// **'В работе'**
  String get dealStatusInProgress;

  /// No description provided for @dealStatusQuoteSent.
  ///
  /// In ru, this message translates to:
  /// **'КП отправлено'**
  String get dealStatusQuoteSent;

  /// No description provided for @dealStatusRejected.
  ///
  /// In ru, this message translates to:
  /// **'Отказ'**
  String get dealStatusRejected;

  /// No description provided for @dealStatusPaid.
  ///
  /// In ru, this message translates to:
  /// **'Оплата'**
  String get dealStatusPaid;

  /// No description provided for @dealStatusCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Выполнено'**
  String get dealStatusCompleted;

  /// No description provided for @noDealsFound.
  ///
  /// In ru, this message translates to:
  /// **'Сделки не найдены'**
  String get noDealsFound;

  /// No description provided for @discount.
  ///
  /// In ru, this message translates to:
  /// **'Скидка'**
  String get discount;

  /// No description provided for @signContract.
  ///
  /// In ru, this message translates to:
  /// **'Подписать договор'**
  String get signContract;

  /// No description provided for @clear.
  ///
  /// In ru, this message translates to:
  /// **'Очистить'**
  String get clear;

  /// No description provided for @signAndGenerate.
  ///
  /// In ru, this message translates to:
  /// **'Подписать и создать'**
  String get signAndGenerate;

  /// No description provided for @deleteDealTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить сделку'**
  String get deleteDealTitle;

  /// No description provided for @deleteDealConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить эту сделку?'**
  String get deleteDealConfirmation;

  /// No description provided for @dealDeleted.
  ///
  /// In ru, this message translates to:
  /// **'Сделка удалена'**
  String get dealDeleted;

  /// No description provided for @dealRestored.
  ///
  /// In ru, this message translates to:
  /// **'Сделка восстановлена'**
  String get dealRestored;

  /// No description provided for @foundSavedDraft.
  ///
  /// In ru, this message translates to:
  /// **'Найдена сохраненная копия. Восстановить?'**
  String get foundSavedDraft;

  /// No description provided for @restore.
  ///
  /// In ru, this message translates to:
  /// **'Восстановить'**
  String get restore;

  /// No description provided for @undo.
  ///
  /// In ru, this message translates to:
  /// **'Отменить'**
  String get undo;

  /// No description provided for @fieldRequired.
  ///
  /// In ru, this message translates to:
  /// **'Поле обязательно'**
  String get fieldRequired;

  /// No description provided for @invalidNumber.
  ///
  /// In ru, this message translates to:
  /// **'Неверное число'**
  String get invalidNumber;

  /// No description provided for @openFile.
  ///
  /// In ru, this message translates to:
  /// **'Открыть'**
  String get openFile;

  /// No description provided for @shareFile.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get shareFile;

  /// No description provided for @contractFor.
  ///
  /// In ru, this message translates to:
  /// **'Договор для {title}'**
  String contractFor(String title);

  /// No description provided for @quoteFor.
  ///
  /// In ru, this message translates to:
  /// **'КП для {title}'**
  String quoteFor(String title);

  /// No description provided for @draftRestored.
  ///
  /// In ru, this message translates to:
  /// **'Черновик восстановлен'**
  String get draftRestored;

  /// No description provided for @errorRestoringDraft.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка восстановления черновика'**
  String get errorRestoringDraft;

  /// No description provided for @dealTitleTemplate.
  ///
  /// In ru, this message translates to:
  /// **'Шаблон названия сделки'**
  String get dealTitleTemplate;

  /// No description provided for @dealTitleTemplateHint.
  ///
  /// In ru, this message translates to:
  /// **'Переменные: id, date, client, amount'**
  String get dealTitleTemplateHint;

  /// No description provided for @resetToDefault.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить'**
  String get resetToDefault;

  /// No description provided for @templateSaved.
  ///
  /// In ru, this message translates to:
  /// **'Шаблон сохранен'**
  String get templateSaved;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
