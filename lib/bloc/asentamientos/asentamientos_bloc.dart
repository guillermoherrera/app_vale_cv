import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:app_vale_cv/models/asentamientos.dart';

part 'asentamientos_state.dart';
part 'asentamientos_event.dart';

class AsentamientosBloc extends Bloc<AsentamientosEvent, AsentamientosState> {
  AsentamientosBloc() : super(AsentamientosIntialState()) {
    on<GetAsentamientos>(
        (event, emit) => emit(AsentamientosSetState(event.data)));
  }
}
