import 'package:e_commerce_app/app/app_prefs.dart';
import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:e_commerce_app/presentation/login/view_model/login_view_model.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/routes_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  _bind() {
    _loginViewModel.start();
    _userNameController.addListener(
        () => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));
    _loginViewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedin) {
      if (isLoggedin) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setuserLoggedin();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _loginViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidgit(),
                    () {
                  _loginViewModel.login();
                }) ??
                _getContentWidgit();
          }),
    );
  }

  Widget _getContentWidgit() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Image.asset(ImageAssets.splashLogo),
                ),
                const SizedBox(
                  height: AppSizes.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _loginViewModel.outputIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.userName.tr(),
                              labelText: AppStrings.userName.tr(),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.userNameError.tr()),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSizes.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _loginViewModel.outputIspasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password.tr(),
                              labelText: AppStrings.password.tr(),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.passwordError.tr()),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSizes.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _loginViewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSizes.s50,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _loginViewModel.login();
                                    }
                                  : null,
                              child: Text(AppStrings.login.tr())),
                        );
                      }),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p28, vertical: AppPadding.p8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.forgotPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerText.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
