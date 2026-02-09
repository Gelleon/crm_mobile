import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import '../../deals/domain/entities/deal.dart';

@lazySingleton
class ExcelService {
  Future<File> generateAnalyticsReport({
    required DateTime startDate,
    required DateTime endDate,
    required double totalTurnover,
    required double totalProfit,
    required int dealsCount,
    required double averageCheck,
    required double averageMargin,
    required List<Deal> deals,
  }) async {
    final excel = Excel.createExcel();
    final sheet = excel['Analytics'];
    final dateFormat = DateFormat('dd.MM.yyyy');

    // Headers
    sheet.appendRow([
      TextCellValue('Отчет по продажам'),
      TextCellValue(
        '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
      ),
    ]);
    sheet.appendRow([TextCellValue('')]);

    // Summary
    sheet.appendRow([TextCellValue('Сводка')]);
    sheet.appendRow([TextCellValue('Показатель'), TextCellValue('Значение')]);
    sheet.appendRow([TextCellValue('Оборот'), DoubleCellValue(totalTurnover)]);
    sheet.appendRow([TextCellValue('Прибыль'), DoubleCellValue(totalProfit)]);
    sheet.appendRow([
      TextCellValue('Маржа (%)'),
      DoubleCellValue(averageMargin),
    ]);
    sheet.appendRow([
      TextCellValue('Количество сделок'),
      IntCellValue(dealsCount),
    ]);
    sheet.appendRow([
      TextCellValue('Средний чек'),
      DoubleCellValue(averageCheck),
    ]);

    sheet.appendRow([TextCellValue('')]);

    // Details
    sheet.appendRow([TextCellValue('Детализация сделок')]);
    sheet.appendRow([
      TextCellValue('Дата'),
      TextCellValue('Название'),
      TextCellValue('Сумма'),
      TextCellValue('Прибыль'),
    ]);

    for (final deal in deals) {
      double dealProfit = 0;
      for (final p in deal.products) {
        dealProfit += p.profit;
      }

      sheet.appendRow([
        TextCellValue(
          deal.paymentDate != null ? dateFormat.format(deal.paymentDate!) : '-',
        ),
        TextCellValue(deal.title),
        DoubleCellValue(deal.totalAmount),
        DoubleCellValue(dealProfit),
      ]);
    }

    // Save
    final fileBytes = excel.save();
    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/analytics_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
    );

    if (fileBytes != null) {
      await file.writeAsBytes(fileBytes);
    }

    return file;
  }
}
