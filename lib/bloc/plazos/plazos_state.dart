part of 'plazos_bloc.dart';

abstract class PlazosState {
  final int resultCode;
  final String resultDesc;
  final Plazos? data;

  const PlazosState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class PlazosIntialState extends PlazosState {
  PlazosIntialState() : super(resultCode: 0, resultDesc: '', data: Plazos());
}

class PlazosSetState extends PlazosState {
  final Plazos newInfo;
  const PlazosSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
