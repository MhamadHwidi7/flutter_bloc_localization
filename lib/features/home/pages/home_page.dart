import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_localization/core/helpers/app_localization_helper.dart';
import 'package:flutter_bloc_localization/core/helpers/shared_preferences_helper.dart';
import 'package:flutter_bloc_localization/core/utils/language_type_enum.dart';
import 'package:flutter_bloc_localization/features/home/manager/localization_cubit.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Flutter Bloc Localization',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LocalizationCubit, LocalizationState>(
              builder: (context, state) {
                return state.when(
                  initial: () {
                    return Text(
                      AppLocalizations.of(context).translate('hello'),
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                  changeLang: (langCode) {
                    AppLocalizations.of(context).locale = Locale(langCode);
                    AppLocalizations.of(context).loadLang();
                    return Text(
                        AppLocalizations.of(context).translate('hello'));
                  },
                );
              },
            ),
            SizedBox(height: 5.h),
            ElevatedButton(
              onPressed: () {
                SharedPreferencesHelper.setData('lang', 'ar');
                context
                    .read<LocalizationCubit>()
                    .appLanguageFunction(LanguageTypeEnum.arabic);
              },
              child: const Text('English'),
            ),
            SizedBox(height: 5.h),
            ElevatedButton(
              onPressed: () {
                SharedPreferencesHelper.setData('lang', 'en');
                context
                    .read<LocalizationCubit>()
                    .appLanguageFunction(LanguageTypeEnum.english);
              },
              child: const Text('Arabic'),
            ),
          ],
        )),
      );
}
