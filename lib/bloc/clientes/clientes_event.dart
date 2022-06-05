part of 'clientes_bloc.dart';

@immutable
abstract class ClientesEvent {}

class GetClientes extends ClientesEvent {
  final Clientes data;

  GetClientes(this.data);
}
