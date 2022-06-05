part of 'vales_bloc.dart';

abstract class ValesState {
  final int resultCode;
  final String resultDesc;
  final Vales? data;

  const ValesState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class ValesIntialState extends ValesState {
  ValesIntialState() : super(resultCode: 0, resultDesc: '', data: Vales());
}

class ValesSetState extends ValesState {
  final Vales newInfo;
  const ValesSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
