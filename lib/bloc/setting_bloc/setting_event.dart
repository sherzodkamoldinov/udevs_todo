part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}
class GetUserInfoEvent extends SettingEvent {}

class RemoveReminderEvent extends SettingEvent {}

class UserInfoUpdateEvent extends SettingEvent {
  final UserModel userModel;
  
  const UserInfoUpdateEvent({
    required this.userModel,
  });
  

  @override
  List<Object> get props => [userModel];
}
