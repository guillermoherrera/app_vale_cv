part of 'desembolsos_bloc.dart';

abstract class DesembolsosState {
  final int resultCode;
  final String resultDesc;
  final Desembolsos? data;

  const DesembolsosState(
      {this.resultCode = 0, this.resultDesc = '', this.data});
}

class DesembolsosIntialState extends DesembolsosState {
  DesembolsosIntialState()
      : super(resultCode: 0, resultDesc: '', data: Desembolsos());
}

class DesembolsosSetState extends DesembolsosState {
  final Desembolsos newInfo;
  const DesembolsosSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
