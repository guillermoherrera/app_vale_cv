part of 'dvinfo_bloc.dart';

@immutable
abstract class DvinfoState {
  final int resultCode;
  final String resultDesc;
  final Dvinfo? data;

  const DvinfoState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class DvinfoIntialState extends DvinfoState {
  const DvinfoIntialState() : super(resultCode: 0, resultDesc: '', data: null);
}

class DvinfoSetState extends DvinfoState {
  final Dvinfo newInfo;
  const DvinfoSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
