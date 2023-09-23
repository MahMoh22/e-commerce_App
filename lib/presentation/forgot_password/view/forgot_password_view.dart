import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:e_commerce_app/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/routes_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _forgotPasswordViewModel =
      instance<ForgotPasswordViewModel>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  _bind() {
    _forgotPasswordViewModel.start();
    _emailTextEditingController.addListener(() =>
        _forgotPasswordViewModel.setEmail(_emailTextEditingController.text));
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
          stream: _forgotPasswordViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidgit(), () {}) ??
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
                      stream: _forgotPasswordViewModel.outputIsEmailValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextEditingController,
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
                      stream: _forgotPasswordViewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSizes.s50,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _forgotPasswordViewModel.reset(context);
                                    }
                                  : null,
                              child: Text(AppStrings.resetPassword.tr())),
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
                                .pushReplacementNamed(Routes.loginRoute);
                          },
                          child: Text(
                            AppStrings.login.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.registerRoute);
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
    _forgotPasswordViewModel.dispose();
    super.dispose();
  }
}
