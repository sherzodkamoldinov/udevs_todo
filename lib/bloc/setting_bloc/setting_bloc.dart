import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/data/models/user_model.dart';
import 'package:udevs_todo/data/repositories/shared_pref.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<RemoveReminderEvent>((event, emit) {
      // emit(state.copyWith())
    });
    
    on<UserInfoUpdateEvent>((event, emit) {});

    on<GetUserInfoEvent>((event, emit) {
      var name = StorageRepository.getString(key: StorageKeys.userName);
      var imgPath = StorageRepository.getString(key: StorageKeys.userImgPath);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        user: UserModel(name: name ?? 'Unknown', imgPath: imgPath ?? ''),
      ));
    });
  }
}
