import 'dart:math' as math;

import 'package:calorie_tracker/notifications/basicinfoprovider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class WeightChartPage extends StatelessWidget {
  const WeightChartPage({super.key});

  @override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final cs = theme.colorScheme;

  return Consumer<BasicInfoProvider>(
    builder: (context, value, child) {
      final sorted = value.weightList;

      if (sorted.isEmpty) {
        return Scaffold(
          appBar: AppBar(title: const Text("Weight Trend")),
          body: const Center(child: Text("No weight data")),
        );
      }

      const int windowSize = 5;

      // ✅ 只取最后5个
      final start = sorted.length > windowSize
          ? sorted.length - windowSize
          : 0;

      final visible = sorted.sublist(start);

      // ✅ 点
      final spots = List.generate(
        visible.length,
        (i) => FlSpot(i.toDouble(), visible[i].weight.toDouble()),
      );

      // ✅ Y轴范围
      final weights = visible.map((e) => e.weight.toDouble()).toList();
      final minW = weights.reduce((a, b) => a < b ? a : b);
      final maxW = weights.reduce((a, b) => a > b ? a : b);

      final minY = (minW - 1).clamp(0, double.infinity).toDouble();
      final maxY = (maxW + 1).toDouble();

      return Scaffold(
        appBar: AppBar(title: const Text("Weight Trend")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface, // 👈 黑色背景
              borderRadius: BorderRadius.circular(16),
            ),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 4, // 👈 固定5个槽位

                minY: minY,
                maxY: maxY,

                borderData: FlBorderData(show: false),

                gridData: FlGridData(
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: cs.onSurface.withValues(alpha: 0.1),
                      strokeWidth: 1,
                    );
                  },
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  // ✅ X轴
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();

                        if (i < 0 || i >= visible.length) {
                          return const SizedBox();
                        }

                        final d = visible[i].date;

                        return Text(
                          "${d.month}/${d.day}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurface.withValues(alpha: 0.7),
                          ),
                        );
                      },
                    ),
                  ),

                  // ✅ Y轴
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(0),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurface.withValues(alpha: 0.7),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: spots,

                    isCurved: true,
                    curveSmoothness: 0.3,
                    barWidth: 3,

                    // ✅ 用 theme 主色（不会再紫）
                    gradient: LinearGradient(
                      colors: [
                        cs.onSurface,
                        cs.onSurface.withValues(alpha: 0.6),
                      ],
                    ),

                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: cs.surface, // 👈 黑底
                          strokeWidth: 2,
                          strokeColor: cs.primary,
                        );
                      },
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          cs.surface.withValues(alpha: 0.25),
                          cs.surface.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],

                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        return LineTooltipItem(
                          "${spot.y.toStringAsFixed(1)} kg",
                          theme.textTheme.bodySmall!.copyWith(
                            color: cs.onPrimary,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
}
