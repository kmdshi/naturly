import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:naturly/src/core/common/layout/layout.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/week_ration.dart';
import 'package:naturly/src/feature/schedule/presentation/widgets/dish_dialog.dart';

class CurrentScheduleWidget extends StatefulWidget {
  final WeekRation ration;
  final bool isView;

  const CurrentScheduleWidget({
    super.key,
    required this.ration,
    required this.isView,
  });

  @override
  State<CurrentScheduleWidget> createState() => _CurrentScheduleWidgetState();
}

class _CurrentScheduleWidgetState extends State<CurrentScheduleWidget> {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WindowSizeScope.of(context).isCompact ||
            WindowSizeScope.of(context).isMedium
        ? SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageViewController,
            itemCount: widget.ration.foodData.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final day = widget.ration.foodData[index];
              return Column(
                children: [
                  Text(
                    getDayName(day.day!, true),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Table(
                    border: TableBorder.all(color: Color(0xFFE6E6E6)),
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                    },
                    children: [
                      _buildMobileRow(
                        index,
                        'Завтрак',
                        widget.isView,

                        day.morningDish,
                        context,
                      ),
                      _buildMobileRow(
                        index,
                        'Обед',
                        widget.isView,
                        day.lunchDish,
                        context,
                      ),
                      _buildMobileRow(
                        index,
                        'Перекус',
                        widget.isView,
                        day.snackDish,
                        context,
                      ),
                      _buildMobileRow(
                        index,
                        'Ужин',
                        widget.isView,
                        day.dinnerDish,
                        context,
                      ),
                      _buildMobileRow(
                        index,
                        'Калории',
                        widget.isView,

                        null,
                        context,
                        otherInfo: day.totalCcal.toString(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => _updateCurrentPageIndex(index - 1),
                      ),
                      widget.isView
                          ? SizedBox.shrink()
                          : ElevatedButton(
                            onPressed:
                                () async => Clipboard.setData(
                                  ClipboardData(
                                    text:
                                        "http://kmdshi.github.io/#/schedule/share?id=${widget.ration.shareId}",
                                  ),
                                ),
                            child: Text('Поделиться рационом'),
                          ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () => _updateCurrentPageIndex(index + 1),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        )
        : Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE6E6E6)),
              ),
              child: Table(
                border: TableBorder(
                  verticalInside: BorderSide.none,
                  horizontalInside: BorderSide(color: Color(0xFFE6E6E6)),
                ),
                columnWidths: const {0: IntrinsicColumnWidth()},
                children: [
                  _buildDesktopRow(
                    'День',
                    widget.isView,
                    null,
                    context,
                    staticValues:
                        widget.ration.foodData
                            .map((e) => getDayName(e.day!, true))
                            .toList(),
                  ),
                  _buildDesktopRow(
                    'Завтрак',
                    widget.isView,
                    widget.ration.foodData.map((e) => e.morningDish).toList(),
                    context,
                  ),
                  _buildDesktopRow(
                    'Обед',
                    widget.isView,
                    widget.ration.foodData.map((e) => e.lunchDish).toList(),
                    context,
                  ),
                  _buildDesktopRow(
                    'Перекус',
                    widget.isView,
                    widget.ration.foodData.map((e) => e.snackDish).toList(),
                    context,
                  ),
                  _buildDesktopRow(
                    'Ужин',
                    widget.isView,
                    widget.ration.foodData.map((e) => e.dinnerDish).toList(),
                    context,
                  ),
                  _buildDesktopRow(
                    'Калории',
                    widget.isView,
                    null,
                    context,
                    staticValues:
                        widget.ration.foodData
                            .map((e) => e.totalCcal?.toString())
                            .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            widget.isView
                ? SizedBox.shrink()
                : ElevatedButton(
                  onPressed:
                      () async => Clipboard.setData(
                        ClipboardData(
                          text:
                              "https://kmdshi.github.io/naturly/#/schedule/share?id=${widget.ration.shareId}",
                        ),
                      ),
                  child: Text('Поделиться рационом'),
                ),
          ],
        );
  }

  void _updateCurrentPageIndex(int newIndex) {
    if (newIndex >= 0 && newIndex < widget.ration.foodData.length) {
      _pageViewController.animateToPage(
        newIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  TableRow _buildDesktopRow(
    final String title,
    final bool isView,
    final List<Dish?>? dishes,
    final BuildContext context, {
    final List<String?>? staticValues,
  }) {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        for (int i = 0; i < 7; i++)
          staticValues != null
              ? Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  (i < staticValues.length ? staticValues[i] : '-') ?? '-',
                  style: const TextStyle(color: Color(0xFF636363)),
                ),
              )
              : InkWell(
                onTap:
                    () =>
                        isView
                            ? null
                            : _showDish(
                              dishes[i]?.mealType ?? '',
                              i,
                              i < dishes.length ? dishes[i] : null,
                              context,
                            ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    (i < dishes!.length ? dishes[i]?.toString() : '-') ?? '-',
                    style: const TextStyle(color: Color(0xFF636363)),
                  ),
                ),
              ),
      ],
    );
  }

  TableRow _buildMobileRow(
    final int dayIndex,
    final String title,
    final bool isView,

    final Dish? dish,
    final BuildContext context, {
    final String? otherInfo,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        GestureDetector(
          onTap:
              () => isView ? null : _showDish(title, dayIndex, dish, context),
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: const EdgeInsets.all(8),

            child: Text(
              otherInfo == null ? dish?.toString() ?? '-' : otherInfo,
              style: TextStyle(color: Color(0xFF636363)),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDish(
    final String mealType,
    final int dayIndex,
    final Dish? dish,
    final BuildContext context,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            content: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder:
                      (context) => DishDialog(
                        dish: dish,
                        mealType: mealType,
                        schedule: widget.ration.foodData,
                        dayIndex: dayIndex,
                      ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

String getDayName(final DateTime date, final bool forTable) {
  return forTable
      ? DateFormat('EEE, d').format(date)
      : DateFormat('EEE').format(date);
}
