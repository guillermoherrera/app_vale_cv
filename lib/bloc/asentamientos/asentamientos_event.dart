part of 'asentamientos_bloc.dart';

@immutable
abstract class AsentamientosEvent {}

class GetAsentamientos extends AsentamientosEvent {
  final Asentamientos data;

  GetAsentamientos(this.data);
}
