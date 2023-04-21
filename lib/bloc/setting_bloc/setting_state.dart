part of 'setting_bloc.dart';

class SettingState extends Equatable {
  const SettingState({
    this.status = FormzStatus.pure,
    this.user = const UserModel(),
    this.errMessage = '',
    this.isReminderShow = true,
  });

  final FormzStatus status;
  final UserModel user;
  final bool isReminderShow;
  final String errMessage;

  SettingState copyWith({
    FormzStatus? status,
    UserModel? user,
    String? errMessage,
    bool? isReminderShow,
  }) =>
      SettingState(
        errMessage: errMessage ?? this.errMessage,
        status: status ?? this.status,
        user: user ?? this.user,
        isReminderShow: isReminderShow ?? this.isReminderShow,
      );

  @override
  List<Object?> get props => [user, status, errMessage, isReminderShow];
}
