part of 'dv_saldos_bloc.dart';

@immutable
abstract class DvSaldosState {
  final int resultCode;
  final String resultDesc;
  final DvSaldos? data;

  const DvSaldosState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class DvSaldosIntialState extends DvSaldosState {
  DvSaldosIntialState()
      : super(resultCode: 0, resultDesc: '', data: DvSaldos());
}

class DvSaldosSetState extends DvSaldosState {
  final DvSaldos newInfo;
  const DvSaldosSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
