part of 'vale_detalle_bloc.dart';

@immutable
abstract class ValeDetalleState {
  final int resultCode;
  final String resultDesc;
  final ValeDetalle? data;

  const ValeDetalleState(
      {this.resultCode = 0, this.resultDesc = '', this.data});
}

class ValeDetalleIntialState extends ValeDetalleState {
  const ValeDetalleIntialState()
      : super(resultCode: 0, resultDesc: '', data: null);
}

class ValeDetalleSetState extends ValeDetalleState {
  final ValeDetalle newInfo;
  const ValeDetalleSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
