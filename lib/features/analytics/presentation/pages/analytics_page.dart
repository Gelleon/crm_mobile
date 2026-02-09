import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:open_file/open_file.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';
import '../providers/analytics_provider.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../../../deals/domain/entities/deal.dart';
import 'package:crm_mobile/features/documents/services/pdf_service.dart';
import 'package:crm_mobile/features/documents/services/excel_service.dart';

@RoutePage()
class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(analyticsProvider);
    final settingsState = ref.watch(settingsProvider);
    final clientsAsync = ref.watch(clientsProvider);
    final notifier = ref.read(analyticsProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final currencyFormat = NumberFormat.currency(
      locale: 'ru',
      symbol: '₽',
      decimalDigits: 0,
    );
    final percentFormat = NumberFormat.decimalPattern('ru');

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.analytics),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.download),
            onSelected: (value) async {
              if (state.isLoading) return;
              try {
                if (value == 'pdf') {
                  final pdfService = GetIt.I<PdfService>();
                  final file = await pdfService.generateAnalyticsReport(
                    startDate: state.startDate,
                    endDate: state.endDate,
                    totalTurnover: state.totalTurnover,
                    totalProfit: state.totalProfit,
                    dealsCount: state.successfulDealsCount,
                    averageCheck: state.averageCheck,
                    averageMargin: state.averageMargin,
                    deals: state.deals,
                  );
                  await OpenFile.open(file.path);
                } else if (value == 'excel') {
                  final excelService = GetIt.I<ExcelService>();
                  final file = await excelService.generateAnalyticsReport(
                    startDate: state.startDate,
                    endDate: state.endDate,
                    totalTurnover: state.totalTurnover,
                    totalProfit: state.totalProfit,
                    dealsCount: state.successfulDealsCount,
                    averageCheck: state.averageCheck,
                    averageMargin: state.averageMargin,
                    deals: state.deals,
                  );
                  await OpenFile.open(file.path);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.exportError(e.toString()))),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'pdf',
                child: ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: Text(l10n.exportPdf),
                ),
              ),
              PopupMenuItem<String>(
                value: 'excel',
                child: ListTile(
                  leading: const Icon(Icons.table_chart),
                  title: Text(l10n.exportExcel),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Period Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: AnalyticsPeriod.values.map((period) {
                  final isSelected = state.period == period;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(switch (period) {
                        AnalyticsPeriod.today => l10n.periodToday,
                        AnalyticsPeriod.week => l10n.periodWeek,
                        AnalyticsPeriod.month => l10n.periodMonth,
                        AnalyticsPeriod.custom => l10n.periodCustom,
                      }),
                      selected: isSelected,
                      onSelected: (val) async {
                        if (val) {
                          if (period == AnalyticsPeriod.custom) {
                            final range = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (range != null) {
                              notifier.setPeriod(
                                period,
                                start: range.start,
                                end: range.end,
                              );
                            }
                          } else {
                            notifier.setPeriod(period);
                          }
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const Gap(16),

            // Target Progress
            if (!state.isLoading) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.monthlyGoal,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () {
                              _showEditTargetDialog(
                                context,
                                state.targetTurnover,
                                notifier,
                                l10n,
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(8),
                      LinearProgressIndicator(
                        value: state.targetTurnover > 0
                            ? (state.totalTurnover / state.targetTurnover)
                                  .clamp(0.0, 1.0)
                            : 0,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      const Gap(8),
                      Text(
                        '${currencyFormat.format(state.totalTurnover)} / ${currencyFormat.format(state.targetTurnover)} (${state.targetTurnover > 0 ? percentFormat.format((state.totalTurnover / state.targetTurnover) * 100) : 0}%)',
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(16),
            ],

            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              // Summary Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _StatCard(
                    title: l10n.totalTurnover,
                    value: currencyFormat.format(state.totalTurnover),
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                  _StatCard(
                    title: l10n.dealsCount,
                    value: state.successfulDealsCount.toString(),
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  _StatCard(
                    title: l10n.averageCheck,
                    value: currencyFormat.format(state.averageCheck),
                    icon: Icons.analytics,
                    color: Colors.orange,
                  ),
                  _StatCard(
                    title: l10n.maxDeal,
                    value: currencyFormat.format(state.maxDeal),
                    icon: Icons.arrow_upward,
                    color: Colors.purple,
                  ),
                  _StatCard(
                    title: l10n.totalProfit,
                    value: currencyFormat.format(state.totalProfit),
                    icon: Icons.monetization_on,
                    color: Colors.teal,
                  ),
                  _StatCard(
                    title: l10n.averageMargin,
                    value: '${percentFormat.format(state.averageMargin)} %',
                    icon: Icons.percent,
                    color: Colors.indigo,
                  ),
                ],
              ),
              const Gap(24),

              // Chart
              Text(
                l10n.turnoverDynamics,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              SizedBox(
                height: 200,
                child: state.deals.isEmpty
                    ? Center(child: Text(l10n.noDataForPeriod))
                    : LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _getSpots(state),
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              const Gap(24),
              Text(
                l10n.dealsDetails,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.deals.length,
                itemBuilder: (context, index) {
                  final deal = state.deals[index];

                  // Resolve Client Name
                  final client = clientsAsync.valueOrNull
                      ?.where((c) => c.id == deal.clientId)
                      .firstOrNull;
                  final clientName = client?.name;

                  // Resolve Title
                  String title;
                  final template = settingsState.dealTitleTemplate;
                  if (template.isNotEmpty) {
                    title = _formatDealTitle(template, deal, clientName);
                  } else {
                    title = '${l10n.dealTitle}-${clientName ?? "?"}';
                  }

                  return ListTile(
                    title: Text(DateFormat.yMMMd().format(deal.paymentDate!)),
                    trailing: Text(
                      '${deal.totalAmount} ₽',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(title),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDealTitle(String template, Deal deal, String? clientName) {
    var title = template;
    title = title.replaceAll('{id}', deal.id.substring(0, 8));
    title = title.replaceAll(
      '{date}',
      DateFormat('yyyy-MM-dd').format(deal.createdAt),
    );
    title = title.replaceAll('{client}', clientName ?? '?');
    title = title.replaceAll('{amount}', deal.totalAmount.toStringAsFixed(0));
    return title;
  }

  List<FlSpot> _getSpots(AnalyticsState state) {
    if (state.deals.isEmpty) return [];

    return state.deals.map((e) {
      return FlSpot(
        e.paymentDate!.millisecondsSinceEpoch.toDouble(),
        e.totalAmount,
      );
    }).toList();
  }

  Future<void> _showEditTargetDialog(
    BuildContext context,
    double currentTarget,
    Analytics notifier,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController(text: currentTarget.toString());
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.setMonthlyGoal),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: l10n.targetTurnoverLabel),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(controller.text) ?? 0;
              notifier.updateTarget(val);
              Navigator.pop(context);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const Gap(8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
