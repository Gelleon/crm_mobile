// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get authenticating => 'Аутентификация...';

  @override
  String get authFailed => 'Ошибка аутентификации. Нажмите, чтобы повторить.';

  @override
  String get retry => 'Повторить';

  @override
  String get clients => 'Клиенты';

  @override
  String get deals => 'Сделки';

  @override
  String get analytics => 'Аналитика';

  @override
  String get settings => 'Настройки';

  @override
  String get enableBiometric => 'Включить вход по биометрии';

  @override
  String get openaiApiKey => 'OpenAI API Ключ';

  @override
  String get enterApiKey => 'Введите ваш OpenAI API Ключ';

  @override
  String get save => 'Сохранить';

  @override
  String get apiKeySaved => 'API Ключ сохранен';

  @override
  String get clientName => 'Имя';

  @override
  String get clientPhone => 'Телефон';

  @override
  String get clientEmail => 'Email';

  @override
  String get clientAddress => 'Адрес';

  @override
  String get clientComment => 'Комментарий';

  @override
  String get addClient => 'Добавить клиента';

  @override
  String get editClient => 'Редактировать клиента';

  @override
  String get deleteClient => 'Удалить клиента';

  @override
  String get saveClient => 'Сохранить клиента';

  @override
  String get dealStatus => 'Статус';

  @override
  String get dealAmount => 'Сумма';

  @override
  String get dealProducts => 'Товары';

  @override
  String get addDeal => 'Добавить сделку';

  @override
  String get deleteDeal => 'Удалить сделку';

  @override
  String get saveDeal => 'Сохранить сделку';

  @override
  String get totalTurnover => 'Оборот';

  @override
  String get totalProfit => 'Прибыль';

  @override
  String get averageMargin => 'Маржа';

  @override
  String get dealsCount => 'Количество сделок';

  @override
  String get averageCheck => 'Средний чек';

  @override
  String get salesReport => 'Отчет по продажам';

  @override
  String get summary => 'Сводка';

  @override
  String get indicator => 'Показатель';

  @override
  String get value => 'Значение';

  @override
  String get details => 'Детализация';

  @override
  String get productName => 'Название товара';

  @override
  String get quantity => 'Количество';

  @override
  String get price => 'Цена';

  @override
  String get tax => 'Налог (%)';

  @override
  String get addProduct => 'Добавить товар';

  @override
  String get editProduct => 'Редактировать товар';

  @override
  String get searchHint => 'Поиск по имени, телефону или email';

  @override
  String get noClientsFound => 'Клиенты не найдены';

  @override
  String error(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get dealTitle => 'Сделка';

  @override
  String get exportPdf => 'Экспорт в PDF';

  @override
  String get exportExcel => 'Экспорт в Excel';

  @override
  String exportError(Object error) {
    return 'Ошибка экспорта: $error';
  }

  @override
  String get newClient => 'Новый клиент';

  @override
  String get newDeal => 'Новая сделка';

  @override
  String get editDeal => 'Редактировать сделку';

  @override
  String get client => 'Клиент';

  @override
  String errorLoadingClients(String error) {
    return 'Ошибка загрузки клиентов: $error';
  }

  @override
  String get monthlyGoal => 'Цель на месяц';

  @override
  String get setMonthlyGoal => 'Установить цель';

  @override
  String get targetTurnoverLabel => 'Целевой оборот';

  @override
  String get cancel => 'Отмена';

  @override
  String get maxDeal => 'Макс. сделка';

  @override
  String get turnoverDynamics => 'Динамика оборота';

  @override
  String get noDataForPeriod => 'Нет данных за период';

  @override
  String get dealsDetails => 'Детализация сделок';

  @override
  String get language => 'Язык';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get history => 'История';

  @override
  String get documents => 'Документы';

  @override
  String get quote => 'КП (Quote)';

  @override
  String get contract => 'Договор';

  @override
  String get historyOfChanges => 'История изменений';

  @override
  String get noHistoryFound => 'История не найдена';

  @override
  String get costPrice => 'Себестоимость';

  @override
  String get description => 'Описание';

  @override
  String get info => 'Инфо';

  @override
  String get createdAt => 'Создан';

  @override
  String get noInteractionHistory => 'Нет истории взаимодействий';

  @override
  String get addInteraction => 'Добавить взаимодействие';

  @override
  String get type => 'Тип';

  @override
  String get notes => 'Заметки';

  @override
  String get dateTime => 'Дата и время';

  @override
  String get remindMe => 'Напомнить мне';

  @override
  String total(String amount) {
    return 'Итого: $amount';
  }

  @override
  String interactionReminder(String type) {
    return 'Напоминание: $type';
  }

  @override
  String get add => 'Добавить';

  @override
  String get periodToday => 'Сегодня';

  @override
  String get periodWeek => 'Неделя';

  @override
  String get periodMonth => 'Месяц';

  @override
  String get periodCustom => 'Период';

  @override
  String get interactionCall => 'Звонок';

  @override
  String get interactionMeeting => 'Встреча';

  @override
  String get interactionNote => 'Заметка';

  @override
  String get interactionOther => 'Другое';

  @override
  String get dealStatusInProgress => 'В работе';

  @override
  String get dealStatusQuoteSent => 'КП отправлено';

  @override
  String get dealStatusRejected => 'Отказ';

  @override
  String get dealStatusPaid => 'Оплата';

  @override
  String get dealStatusCompleted => 'Выполнено';

  @override
  String get noDealsFound => 'Сделки не найдены';

  @override
  String get discount => 'Скидка';

  @override
  String get signContract => 'Подписать договор';

  @override
  String get clear => 'Очистить';

  @override
  String get signAndGenerate => 'Подписать и создать';

  @override
  String get deleteDealTitle => 'Удалить сделку';

  @override
  String get deleteDealConfirmation =>
      'Вы уверены, что хотите удалить эту сделку?';

  @override
  String get dealDeleted => 'Сделка удалена';

  @override
  String get dealRestored => 'Сделка восстановлена';

  @override
  String get foundSavedDraft => 'Найдена сохраненная копия. Восстановить?';

  @override
  String get restore => 'Восстановить';

  @override
  String get undo => 'Отменить';

  @override
  String get fieldRequired => 'Поле обязательно';

  @override
  String get invalidNumber => 'Неверное число';

  @override
  String get openFile => 'Открыть';

  @override
  String get shareFile => 'Поделиться';

  @override
  String contractFor(String title) {
    return 'Договор для $title';
  }

  @override
  String quoteFor(String title) {
    return 'КП для $title';
  }

  @override
  String get draftRestored => 'Черновик восстановлен';

  @override
  String get errorRestoringDraft => 'Ошибка восстановления черновика';

  @override
  String get dealTitleTemplate => 'Шаблон названия сделки';

  @override
  String get dealTitleTemplateHint => 'Переменные: id, date, client, amount';

  @override
  String get resetToDefault => 'Сбросить';

  @override
  String get templateSaved => 'Шаблон сохранен';
}
