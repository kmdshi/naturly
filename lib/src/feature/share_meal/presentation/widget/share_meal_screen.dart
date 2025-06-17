import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/widget/current_schedule_widget.dart';
import 'package:naturly/src/feature/share_meal/presentation/bloc/share_meal_bloc.dart';

@RoutePage()
class ShareMealScreen extends StatefulWidget {
  const ShareMealScreen({super.key});

  @override
  State<ShareMealScreen> createState() => _ShareMealScreenState();
}

class _ShareMealScreenState extends State<ShareMealScreen> {
  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShareMealBloc, ShareMealState>(
        builder: (context, state) {
          if (state is ShareMealInitial) {
            return const Center(child: Text('Ожидание...'));
          } else if (state is ShareMealLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShareMealLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Рацион от: ${state.shared_by}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  CurrentScheduleWidget(ration: state.weekRation, isView: true),
                ],
              ),
            );
          } else if (state is ShareMealFailure) {
            return Center(
              child: Text(
                'Ошибка: ${state.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeData = RouteData.of(context);
      final id = routeData.queryParams.get('id');

      if (id != null) {
        context.read<ShareMealBloc>().add(
          GetAnotherRationShareMealEvent(week_key: id),
        );
      }
    });
  }
}
