part of 'cliente_bloc.dart';

@immutable
abstract class ClienteState {
  final int resultCode;
  final String resultDesc;
  final Cliente? data;

  const ClienteState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class ClienteIntialState extends ClienteState {
  const ClienteIntialState() : super(resultCode: 0, resultDesc: '', data: null);
}

class ClienteSetState extends ClienteState {
  final Cliente newInfo;
  const ClienteSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
