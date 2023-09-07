import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_commerce_app/app/app_prefs.dart';
import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:e_commerce_app/presentation/register/view_model/regiter_view_model.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/routes_manager.dart';

import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  _bind() {
    _registerViewModel.start();
    _userNameController.addListener(() {
      _registerViewModel.setUserName(_userNameController.text);
    });
    _emailController.addListener(() {
      _registerViewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _registerViewModel.setPassword(_passwordController.text);
    });
    _mobileNumberController.addListener(() {
      _registerViewModel.setMobileNumber(_mobileNumberController.text);
    });
    _registerViewModel.isUserRegisteredSuccessfullyStreamController.stream
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
      appBar: AppBar(
        elevation: AppSizes.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
          stream: _registerViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidgit(),
                    () {
                  _registerViewModel.register();
                }) ??
                _getContentWidgit();
          }),
    );
  }

  Widget _getContentWidgit() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p28),
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
                  child: StreamBuilder<String?>(
                      stream: _registerViewModel.outputErrorUserName,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _userNameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.userName,
                              labelText: AppStrings.userName,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSizes.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onChanged: (value) {
                            _registerViewModel
                                .setCountryMobileCode(value.dialCode ?? '+20');
                          },
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: '+20',
                          hideMainText: true,
                          favorite: const ['+39', 'FR', '+699'],
                          // optional. Shows only country name and flag
                          showCountryOnly: true,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: true,
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: StreamBuilder<String?>(
                              stream:
                                  _registerViewModel.outputErrorMobileNumber,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _mobileNumberController,
                                  decoration: InputDecoration(
                                      hintText: AppStrings.mobileNumber,
                                      labelText: AppStrings.mobileNumber,
                                      errorText: snapshot.data),
                                );
                              }))
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSizes.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _registerViewModel.outputErrorEmail,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: AppStrings.email,
                              labelText: AppStrings.email,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSizes.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _registerViewModel.outputErrorUserPassword,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password,
                              labelText: AppStrings.password,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSizes.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: Container(
                    height: AppSizes.s50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppSizes.s12)),
                        border: Border.all(color: ColorManager.lightGray)),
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: _getMediaWidget(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSizes.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _registerViewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSizes.s50,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _registerViewModel.register();
                                    }
                                  : null,
                              child: const Text(AppStrings.register)),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p28, vertical: AppPadding.p8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppStrings.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text(AppStrings.photoGallery),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text(AppStrings.photoCamera),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _registerViewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.profilePicture)),
          Flexible(
              child: StreamBuilder<File>(
                  stream: _registerViewModel.outputProfilePicture,
                  builder: (context, snapshot) {
                    return _imagePicketByUser(snapshot.data);
                  })),
          Flexible(child: SvgPicture.asset(ImageAssets.phptoCameraIc))
        ],
      ),
    );
  }

  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      // return image
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }
}
