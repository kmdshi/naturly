part of 'metrics_bloc.dart';

sealed class MetricsState extends Equatable {
  const MetricsState();
  
  @override
  List<Object> get props => [];
}

final class MetricsInitial extends MetricsState {}
