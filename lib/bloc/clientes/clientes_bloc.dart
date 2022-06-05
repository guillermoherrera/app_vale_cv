import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import '../../models/clientes.dart';

part 'clientes_state.dart';
part 'clientes_event.dart';

class ClientesBloc extends Bloc<ClientesEvent, ClientesState> {
  ClientesBloc() : super(ClientesIntialState()) {
    on<GetClientes>((event, emit) => emit(ClientesSetState(event.data)));
  }
}
