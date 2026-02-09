import 'dart:io';
import 'dart:typed_data';
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
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text('Договор купли-продажи')),
              pw.Text('г. Москва, ${DateTime.now().year} г.'),
              pw.SizedBox(height: 20),
              pw.Text(
                'Продавец, именуемый в дальнейшем "Продавец", с одной стороны, и',
              ),
              pw.Text(
                '${client.name}, именуемый(ая) в дальнейшем "Покупатель",',
              ),
              pw.Text('заключили настоящий Договор о нижеследующем:'),
              pw.SizedBox(height: 10),
              pw.Text('1. ПРЕДМЕТ ДОГОВОРА'),
              pw.Text(
                '1.1. Продавец обязуется передать в собственность Покупателя, а Покупатель принять и оплатить следующий Товар:',
              ),
              pw.SizedBox(height: 10),
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
              pw.SizedBox(height: 10),
              pw.Text(
                '1.2. Общая сумма договора составляет: ${deal.totalAmount} руб.',
              ),
              pw.SizedBox(height: 20),
              pw.Text('2. АДРЕСА И РЕКВИЗИТЫ СТОРОН'),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Продавец:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text('ООО "Мебель"'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Покупатель:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(client.name),
                      pw.Text(client.address),
                      pw.Text(client.phone),
                    ],
                  ),
                ],
              ),
              if (signature != null) ...[
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text('Подпись Покупателя:'),
                        pw.SizedBox(height: 5),
                        pw.Image(
                          pw.MemoryImage(signature),
                          width: 100,
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/contract_${deal.id}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
