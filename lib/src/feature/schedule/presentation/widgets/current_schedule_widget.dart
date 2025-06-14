import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naturly/src/core/common/layout/layout.dart';
import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/feature/schedule/presentation/widgets/dish_dialog.dart';

class CurrentScheduleWidget extends StatefulWidget {
  final List<DayRation> schedule;

  const CurrentScheduleWidget({super.key, required this.schedule});

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
            itemCount: widget.schedule.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final day = widget.schedule[index];

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
                      _buildMobileRow('Завтрак', day.morningDish, context),
                      _buildMobileRow('Обед', day.lunchDish, context),
                      _buildMobileRow('Перекус', day.snackDish, context),
                      _buildMobileRow('Ужин', day.dinnerDish, context),
                      _buildMobileRow(
                        'Калории',
                        null,
                        otherInfo: day.totalCcal.toString(),
                        context,
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
        : Container(
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
                null,
                context,
                staticValues:
                    widget.schedule
                        .map((e) => getDayName(e.day!, true))
                        .toList(),
              ),
              _buildDesktopRow(
                'Завтрак',
                widget.schedule.map((e) => e.morningDish).toList(),
                context,
              ),
              _buildDesktopRow(
                'Завтрак',
                widget.schedule.map((e) => e.morningDish).toList(),
                context,
              ),
              _buildDesktopRow(
                'Обед',
                widget.schedule.map((e) => e.lunchDish).toList(),
                context,
              ),
              _buildDesktopRow(
                'Перекус',
                widget.schedule.map((e) => e.snackDish).toList(),
                context,
              ),
              _buildDesktopRow(
                'Ужин',
                widget.schedule.map((e) => e.dinnerDish).toList(),
                context,
              ),
              _buildDesktopRow(
                'Калории',
                null,
                context,
                staticValues:
                    widget.schedule
                        .map((e) => e.totalCcal?.toString())
                        .toList(),
              ),
            ],
          ),
        );
  }

  void _updateCurrentPageIndex(int newIndex) {
    if (newIndex >= 0 && newIndex < widget.schedule.length) {
      _pageViewController.animateToPage(
        newIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  TableRow _buildDesktopRow(
    String title,
    List<Dish?>? dishes,
    BuildContext context, {
    List<String?>? staticValues,
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
                    () => _showDish(
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
    String title,
    Dish? dish,
    BuildContext context, {
    String? otherInfo,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        GestureDetector(
          onTap: () => _showDish(dish, context),
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

  Future<void> _showDish(Dish? dish, BuildContext context) async {
    if (dish == null) return;
    return await showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            content: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (context) => DishDialog(dish: dish),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

String getDayName(DateTime date, bool forTable) {
  return forTable
      ? DateFormat('EEE, d').format(date)
      : DateFormat('EEE').format(date);
}
