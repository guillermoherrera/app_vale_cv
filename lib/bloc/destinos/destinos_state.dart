part of 'destinos_bloc.dart';

abstract class DestinosState {
  final int resultCode;
  final String resultDesc;
  final Destinos? data;

  const DestinosState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class DestinosIntialState extends DestinosState {
  DestinosIntialState()
      : super(resultCode: 0, resultDesc: '', data: Destinos());
}

class DestinosSetState extends DestinosState {
  final Destinos newInfo;
  const DestinosSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
