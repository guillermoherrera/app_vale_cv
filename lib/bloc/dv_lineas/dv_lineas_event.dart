part of 'dv_lineas_bloc.dart';

@immutable
abstract class DvLineasEvent {}

class GetLineas extends DvLineasEvent {
  final DvLineas data;
  GetLineas(this.data);
}
