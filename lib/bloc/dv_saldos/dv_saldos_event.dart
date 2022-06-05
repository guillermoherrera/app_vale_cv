part of 'dv_saldos_bloc.dart';

@immutable
abstract class DvSaldosEvent {}

class GetSld extends DvSaldosEvent {
  final DvSaldos data;
  GetSld(this.data);
}
