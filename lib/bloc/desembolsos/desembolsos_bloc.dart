import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import '../../models/desembolso.dart';

part 'desembolsos_state.dart';
part 'desembolsos_event.dart';

class DesembolsosBloc extends Bloc<DesembolsosEvent, DesembolsosState> {
  DesembolsosBloc() : super(DesembolsosIntialState()) {
    on<GetDesembolsos>((event, emit) => emit(DesembolsosSetState(event.data)));
  }
}
