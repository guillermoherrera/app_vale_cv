part of 'vales_bloc.dart';

@immutable
abstract class ValesEvent {}

class GetVales extends ValesEvent {
  final Vales data;

  GetVales(this.data);
}
