part of 'desembolsos_bloc.dart';

@immutable
abstract class DesembolsosEvent {}

class GetDesembolsos extends DesembolsosEvent {
  final Desembolsos data;

  GetDesembolsos(this.data);
}
