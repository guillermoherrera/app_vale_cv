part of 'dvinfo_bloc.dart';

@immutable
abstract class DvinfoEvent {}

class GetDvInfo extends DvinfoEvent {
  final Dvinfo data;
  GetDvInfo(this.data);
}
