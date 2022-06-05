import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import '../../models/vales.dart';

part 'vales_state.dart';
part 'vales_event.dart';

class ValesBloc extends Bloc<ValesEvent, ValesState> {
  ValesBloc() : super(ValesIntialState()) {
    on<GetVales>((event, emit) => emit(ValesSetState(event.data)));
  }
}
