import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'metrics_event.dart';
part 'metrics_state.dart';

class MetricsBloc extends Bloc<MetricsEvent, MetricsState> {
  MetricsBloc() : super(MetricsInitial()) {
    on<MetricsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
