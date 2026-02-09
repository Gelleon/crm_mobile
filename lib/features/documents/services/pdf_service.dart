import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import '../../deals/domain/entities/deal.dart';
import '../../clients/domain/entities/client.dart';

@lazySingleton
class PdfService {
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
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();
    final dateFormat = DateFormat('dd.MM.yyyy');
    final currencyFormat = NumberFormat.currency(
      locale: 'ru',
      symbol: '₽',
      decimalDigits: 2,
    );
    final percentFormat = NumberFormat.decimalPattern('ru');

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (context) {
          return [
            pw.Header(level: 0, child: pw.Text('Отчет по продажам')),
            pw.Text(
              'Период: ${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Сводка',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
            ),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              context: context,
              headers: ['Показатель', 'Значение'],
              data: [
                ['Оборот', currencyFormat.format(totalTurnover)],
                ['Прибыль', currencyFormat.format(totalProfit)],
                ['Маржа', '${percentFormat.format(averageMargin)} %'],
                ['Количество сделок', dealsCount.toString()],
                ['Средний чек', currencyFormat.format(averageCheck)],
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Детализация сделок',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
            ),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              context: context,
              headers: ['Дата', 'Название', 'Сумма', 'Прибыль'],
              data: deals.map((deal) {
                double dealProfit = 0;
                for (final p in deal.products) {
                  // Calculate profit manually if extension not available in this context
                  // But I imported product.dart so it should work if extension is on Product
                  dealProfit += p.profit;
                }

                return [
                  deal.paymentDate != null
                      ? dateFormat.format(deal.paymentDate!)
                      : '-',
                  deal.title,
                  currencyFormat.format(deal.totalAmount),
                  currencyFormat.format(dealProfit),
                ];
              }).toList(),
            ),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
      '${output.path}/analytics_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File> generateQuote(Deal deal, Client client) async {
    final pdf = pw.Document();

    // Load fonts (required for Russian)
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text('Коммерческое предложение')),
              pw.Text('Клиент: ${client.name}'),
              pw.Text('Дата: ${deal.createdAt}'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Товар', 'Кол-во', 'Цена', 'Сумма'],
                  ...deal.products.map(
                    (p) => [
                      p.name,
                      p.quantity.toString(),
                      p.price.toString(),
                      p.total.toString(),
                    ],
                  ),
                ],
              ),
              pw.Divider(),
              pw.Text(
                'Итого: ${deal.totalAmount}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/quote_${deal.id}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File> generateContract(
    Deal deal,
    Client client, {
    Uint8List? signature,
    String? conditions,
    DateTime? date,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();
    final dateFormat = DateFormat('dd.MM.yyyy');
    final contractDate = date ?? DateTime.now();
    final currencyFormat = NumberFormat.currency(
      locale: 'ru',
      symbol: '₽',
      decimalDigits: 2,
    );

    // Load images
    final logoImage = await _loadAssetImage('assets/images/logo.jpeg');
    final stampImage = await _loadAssetImage('assets/images/stamp.jpeg');
    final sellerSignatureImage = await _loadAssetImage(
      'assets/images/signature.jpeg',
    );

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            // Header with Logo
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                if (logoImage != null)
                  pw.Container(
                    width: 100,
                    height: 100,
                    child: pw.Image(logoImage, fit: pw.BoxFit.contain),
                  )
                else
                  pw.SizedBox(width: 100, height: 100),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'ДОГОВОР № ${deal.id.substring(0, 8)}',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    pw.Text('г. Москва, ${dateFormat.format(contractDate)}'),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // Intro
            pw.RichText(
              text: pw.TextSpan(
                children: [
                  const pw.TextSpan(
                    text:
                        'ИП "Продавец", именуемый в дальнейшем "Продавец", действующий на основании Свидетельства, с одной стороны, и ',
                  ),
                  pw.TextSpan(
                    text: client.name,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  const pw.TextSpan(
                    text:
                        ', именуемый(ая) в дальнейшем "Покупатель", с другой стороны, заключили настоящий Договор о нижеследующем:',
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // 1. Subject
            pw.Header(level: 1, child: pw.Text('1. ПРЕДМЕТ ДОГОВОРА')),
            pw.Text(
              '1.1. Продавец обязуется передать в собственность Покупателя, а Покупатель принять и оплатить следующий Товар:',
            ),
            pw.SizedBox(height: 10),

            // Table
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: ['Наименование', 'Кол-во', 'Цена', 'Сумма'],
              data: [
                ...deal.products.map(
                  (p) => [
                    p.name,
                    '${p.quantity}',
                    currencyFormat.format(p.price),
                    currencyFormat.format(p.total),
                  ],
                ),
                ['ИТОГО', '', '', currencyFormat.format(deal.totalAmount)],
              ],
            ),
            pw.SizedBox(height: 20),

            // 2. Terms
            pw.Header(
              level: 1,
              child: pw.Text('2. СТОИМОСТЬ И ПОРЯДОК РАСЧЕТОВ'),
            ),
            pw.Text(
              '2.1. Общая стоимость Товара составляет ${currencyFormat.format(deal.totalAmount)}.',
            ),
            pw.Text('2.2. Оплата производится в рублях.'),
            if (conditions != null && conditions.isNotEmpty) ...[
              pw.SizedBox(height: 10),
              pw.Text('2.3. Дополнительные условия: $conditions'),
            ],
            pw.SizedBox(height: 20),

            // 3. Addresses and Signatures
            pw.Header(level: 1, child: pw.Text('3. АДРЕСА И РЕКВИЗИТЫ СТОРОН')),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Seller
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'ПРОДАВЕЦ:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text('ИП "Продавец"'),
                      pw.Text('ИНН: 1234567890'),
                      pw.Text('г. Москва, ул. Ленина, 1'),
                      pw.SizedBox(height: 20),
                      if (sellerSignatureImage != null && stampImage != null)
                        pw.Stack(
                          children: [
                            pw.Image(sellerSignatureImage, width: 100),
                            pw.Positioned(
                              left: 20,
                              top: -10,
                              child: pw.Image(stampImage, width: 100),
                            ),
                          ],
                        )
                      else
                        pw.SizedBox(height: 100),
                      pw.Divider(),
                      pw.Text('Подпись'),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
                // Buyer
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'ПОКУПАТЕЛЬ:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(client.name),
                      pw.Text('Тел: ${client.phone}'),
                      pw.Text('Email: ${client.email}'),
                      pw.SizedBox(height: 20),
                      if (signature != null)
                        pw.Image(pw.MemoryImage(signature), width: 100)
                      else
                        pw.SizedBox(height: 100),
                      pw.Divider(),
                      pw.Text('Подпись'),
                    ],
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/contract_${deal.id}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<pw.MemoryImage?> _loadAssetImage(String path) async {
    try {
      final data = await rootBundle.load(path);
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      debugPrint('Error loading asset $path: $e');
      return null;
    }
  }
}
