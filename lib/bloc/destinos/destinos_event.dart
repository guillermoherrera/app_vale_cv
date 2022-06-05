part of 'destinos_bloc.dart';

@immutable
abstract class DestinosEvent {}

class GetDestinos extends DestinosEvent {
  final Destinos data;

  GetDestinos(this.data);
}
