part of 'cliente_bloc.dart';

@immutable
abstract class ClienteEvent {}

class GetCliente extends ClienteEvent {
  final Cliente data;
  GetCliente(this.data);
}
