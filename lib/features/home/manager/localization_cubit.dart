import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_localization/core/helpers/shared_preferences_helper.dart';
import 'package:flutter_bloc_localization/core/utils/language_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'localization_state.dart';
part 'localization_cubit.freezed.dart';

@injectable
class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState.initial());

  void appLanguageFunction(LanguageTypeEnum language) {
    switch (language) {
      case LanguageTypeEnum.initial:
        if (SharedPreferencesHelper.getData('lang') != null) {
          if (SharedPreferencesHelper.getData('lang') == 'ar') {
            emit(const LocalizationState.changeLang('ar'));
          } else {
            emit(const LocalizationState.changeLang('en'));
          }
        }
        break;
      case LanguageTypeEnum.arabic:
        SharedPreferencesHelper.setData('lang', 'ar');
        emit(const LocalizationState.changeLang('ar'));
        break;
      case LanguageTypeEnum.english:
        SharedPreferencesHelper.setData('lang', 'en');
        emit(const LocalizationState.changeLang('en'));
        break;
      default:
        emit(const LocalizationState.changeLang('en'));
    }
  }
}
