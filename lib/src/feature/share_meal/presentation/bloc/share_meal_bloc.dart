import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:naturly/src/core/common/models/week_ration.dart';
import 'package:naturly/src/feature/share_meal/domain/repository/share_meal_repository.dart';

part 'share_meal_event.dart';
part 'share_meal_state.dart';

class ShareMealBloc extends Bloc<ShareMealEvent, ShareMealState> {
  final ShareMealRepository shareMealRepository;
  ShareMealBloc({required this.shareMealRepository})
    : super(ShareMealInitial()) {
    on<GetAnotherRationShareMealEvent>(_getAnotherRation);
  }

  Future<void> _getAnotherRation(
    GetAnotherRationShareMealEvent event,
    Emitter<ShareMealState> emit,
  ) async {
    emit(ShareMealLoading());

    try {
      final ration = await shareMealRepository.getAnotherWeekRation(
        event.week_key,
      );

      emit(
        ShareMealLoaded(weekRation: ration.ration, shared_by: ration.sharedBy),
      );
    } catch (e) {
      emit(ShareMealFailure('Ошибка при загрузке: ${e.toString()}'));
    }
  }
}
