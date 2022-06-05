part of 'historial_bloc.dart';

@immutable
abstract class HistorialEvent {}

class GetHistorial extends HistorialEvent {
  final Historial data;
  GetHistorial(this.data);
}
