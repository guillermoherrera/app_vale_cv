part of 'clientes_bloc.dart';

abstract class ClientesState {
  final int resultCode;
  final String resultDesc;
  final Clientes? data;

  const ClientesState({this.resultCode = 0, this.resultDesc = '', this.data});
}

class ClientesIntialState extends ClientesState {
  ClientesIntialState()
      : super(resultCode: 0, resultDesc: '', data: Clientes());
}

class ClientesSetState extends ClientesState {
  final Clientes newInfo;
  const ClientesSetState(this.newInfo)
      : super(resultCode: 0, resultDesc: 'Oks.', data: newInfo);
}
