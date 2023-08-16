import 'package:e_commerce_app/presentation/login/view_model/login_view_model.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = LoginViewModel(/*_loginUsecase*/);
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  _bind() {
    _loginViewModel.start();
    _userNameController.addListener(
        () => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidgit();
  }

  Widget _getContentWidgit() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
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
                                hintText: AppStrings.userName,
                                labelText: AppStrings.userName,
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : AppStrings.userNameError),
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
                                hintText: AppStrings.password,
                                labelText: AppStrings.password,
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : AppStrings.passwordError),
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
                                child: const Text(AppStrings.login)),
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
                            onPressed: () {},
                            child: Text(
                              AppStrings.forgetPassword,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              AppStrings.registerText,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
