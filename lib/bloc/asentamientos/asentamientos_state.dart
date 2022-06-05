part of 'asentamientos_bloc.dart';

abstract class AsentamientosState {
  final int resultCode;
  final String resultDesc;
  final Asentamientos? data;

  const AsentamientosState(
      {this.resultCode = 0, this.resultDesc = '', this.data});
}

class AsentamientosIntialState extends AsentamientosState {
  AsentamientosIntialState()
      : super(resultCode: 0, resultDesc: '', data: Asentamientos());
}

class AsentamientosSetState extends AsentamientosState {
  final Asentamientos newInfo;
  const AsentamientosSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
