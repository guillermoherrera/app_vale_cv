part of 'plazos_bloc.dart';

@immutable
abstract class PlazosEvent {}

class GetPlazos extends PlazosEvent {
  final Plazos data;

  GetPlazos(this.data);
}
