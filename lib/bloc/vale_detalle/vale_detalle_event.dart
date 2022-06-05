part of 'vale_detalle_bloc.dart';

@immutable
abstract class ValeDetalleEvent {}

class GetValeDetalle extends ValeDetalleEvent {
  final ValeDetalle data;
  GetValeDetalle(this.data);
}
