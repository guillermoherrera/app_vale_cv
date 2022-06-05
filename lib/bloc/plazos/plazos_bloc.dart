import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:app_vale_cv/models/plazos.dart';

part 'plazos_state.dart';
part 'plazos_event.dart';

class PlazosBloc extends Bloc<PlazosEvent, PlazosState> {
  PlazosBloc() : super(PlazosIntialState()) {
    on<GetPlazos>((event, emit) => emit(PlazosSetState(event.data)));
  }
}
