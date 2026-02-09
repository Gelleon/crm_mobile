enum DealStatus {
  inProgress,
  quoteSent,
  rejected,
  paid,
  completed;

  String get label {
    switch (this) {
      case DealStatus.inProgress: return 'В работе';
      case DealStatus.quoteSent: return 'КП отправлено';
      case DealStatus.rejected: return 'Отказ';
      case DealStatus.paid: return 'Оплата';
      case DealStatus.completed: return 'Выполнено';
    }
  }

  bool get isSuccessful => this == DealStatus.paid || this == DealStatus.completed;
}
