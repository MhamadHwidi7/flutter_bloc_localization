// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/shared_preferences_helper.dart' as _i5;
import 'features/home/manager/localization_cubit.dart' as _i4;
import 'features/splash/manager/animation_splash_cubit.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AnimationSplashCubit>(() => _i3.AnimationSplashCubit());
    gh.factory<_i4.LocalizationCubit>(() => _i4.LocalizationCubit());
    gh.singleton<_i5.SharedPreferencesHelper>(_i5.SharedPreferencesHelper());
    return this;
  }
}
