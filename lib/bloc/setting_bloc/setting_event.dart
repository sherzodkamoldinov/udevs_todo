part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}
class GetUserInfoEvent extends SettingEvent {}

class RemoveReminderEvent extends SettingEvent {}


class UpdateNameEvent extends SettingEvent {
  final String name;
  
  const UpdateNameEvent({
    required this.name,
  });
  

  @override
  List<Object> get props => [name];
}

class UpdateImagePathEvent extends SettingEvent {
  final String imgPath;
  
  const UpdateImagePathEvent({
    required this.imgPath,
  });
  

  @override
  List<Object> get props => [imgPath];
}


