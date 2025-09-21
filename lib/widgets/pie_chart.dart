import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class ExpensePieChart extends StatelessWidget {
  final Map<String, double> data;

  const ExpensePieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Aucune donnée à afficher'));
    }

    final total = data.values.reduce((a, b) => a + b);
    final chartData = data.entries.toList();

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: CustomPaint(painter: _PieChartPainter(chartData, total)),
        ),
        const SizedBox(height: 16),
        ...chartData.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final percentage = (item.value / total * 100).toStringAsFixed(1);

          return ListTile(
            leading: Container(
              width: 16,
              height: 16,
              color: AppConstants
                  .chartColors[index % AppConstants.chartColors.length],
            ),
            title: Text(item.key),
            trailing: Text(
              '${Helpers.formatCurrency(item.value)} ($percentage%)',
            ),
          );
        }),
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<MapEntry<String, double>> data;
  final double total;

  _PieChartPainter(this.data, this.total);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.8;
    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -90 * (3.1415926535 / 180);

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i].value / total) * 360 * (3.1415926535 / 180);
      final paint = Paint()
        ..color = AppConstants.chartColors[i % AppConstants.chartColors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
