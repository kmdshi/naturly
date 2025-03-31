import 'package:flutter_bloc/flutter_bloc.dart';

abstract base class BlocTransformer<Event> {
  Stream<Event> transform(Stream<Event> stream, EventMapper<Event> mapper);
}

final class SequentialBlocTransformer<Event> extends BlocTransformer<Event> {
  @override
  Stream<Event> transform(Stream<Event> stream, EventMapper<Event> mapper) =>
      stream.asyncExpand(mapper);
}
