part of 'dv_lineas_bloc.dart';

@immutable
abstract class DvLineasState {
  final int resultCode;
  final String resultDesc;
  final DvLineas? data;

  const DvLineasState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class DvLineasIntialState extends DvLineasState {
  DvLineasIntialState()
      : super(resultCode: 0, resultDesc: '', data: DvLineas());
}

class DvLineasSetState extends DvLineasState {
  final DvLineas newInfo;
  const DvLineasSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
