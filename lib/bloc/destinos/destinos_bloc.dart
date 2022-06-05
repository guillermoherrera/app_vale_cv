import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import '../../models/destinos.dart';

part 'destinos_state.dart';
part 'destinos_event.dart';

class DestinosBloc extends Bloc<DestinosEvent, DestinosState> {
  DestinosBloc() : super(DestinosIntialState()) {
    on<GetDestinos>((event, emit) => emit(DestinosSetState(event.data)));
  }
}
