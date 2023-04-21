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

    on<UpdateNameEvent>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        // save new name to cache
        await StorageRepository.putString(key: StorageKeys.userName, value: event.name);

        emit(state.copyWith(user: state.user.copyWith(name: event.name), status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(errMessage: e.toString(), status: FormzStatus.submissionFailure));
      }
    });

    on<UpdateImagePathEvent>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        // save new imgPath to cache
        await StorageRepository.putString(key: StorageKeys.userImgPath, value: event.imgPath);

        emit(state.copyWith(user: state.user.copyWith(imgPath: event.imgPath), status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(errMessage: e.toString(), status: FormzStatus.submissionFailure));
      }
    });

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
