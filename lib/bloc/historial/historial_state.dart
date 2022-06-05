part of 'historial_bloc.dart';

@immutable
abstract class HistorialState {
  final int resultCode;
  final String resultDesc;
  final Historial? data;

  const HistorialState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class HistorialIntialState extends HistorialState {
  const HistorialIntialState()
      : super(resultCode: 0, resultDesc: '', data: null);
}

class HistorialSetState extends HistorialState {
  final Historial newInfo;
  const HistorialSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
