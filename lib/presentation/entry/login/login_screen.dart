import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:selorg/presentation/widgets/network_image.dart';
import 'package:selorgweb_main/presentation/entry/login/login_bloc.dart';
import 'package:selorgweb_main/presentation/general/privacy_policy.dart';
import 'package:selorgweb_main/presentation/general/terms_conditions.dart';
import 'package:selorgweb_main/utils/constant.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static TextEditingController phoneNumberController = TextEditingController();
  static bool isButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    var size = 400.0;
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is PhoneNumberSuccessState) {
            isButtonEnable = state.isEnable;
            phoneNumber = phoneNumberController.text;
          } else if (state is OtpSuccessState) {
            context.push('/otp');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            phoneNumberController.clear();
            context.read<LoginBloc>().add(
              ClearCartDataEvent(mobileNumber: phoneNumber),
            );
          } else if (state is OtpErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // constraints: BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: appColor,
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: AssetImage(bgImage),

                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 40),
                            SvgPicture.asset(
                              "assets/Frame 7680.svg",
                              height: 180,
                            ),
                            SizedBox(height: 30),
                            Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enter your 10 digits number',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                // SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: size,
                                  height: null,
                                  child: Row(
                                    children: [
                                      ImageNetwork(
                                        url:
                                            'https://flagcdn.com/w40/in.png', // Indian Flag
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "+91  ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 28,
                                        color: Color(0xFFC6C5C5),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: TextFormField(
                                          cursorColor: appColor,
                                          controller: phoneNumberController,
                                          keyboardType: TextInputType.phone,
                                          maxLength: 10,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.displayMedium,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            if (value.length == 10) {
                                              context.read<LoginBloc>().add(
                                                PhoneNumberEnteredvent(
                                                  isEnable: true,
                                                ),
                                              );
                                            } else {
                                              context.read<LoginBloc>().add(
                                                PhoneNumberEnteredvent(
                                                  isEnable: false,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    if (isButtonEnable) {
                                      context.read<LoginBloc>().add(
                                        SendOtpEvent(
                                          mobileNumber:
                                              phoneNumberController.text,
                                        ),
                                      );
                                      //  Navigator.pushNamed(context, '/otp');
                                    } else {}
                                  },
                                  child: Container(
                                    width: size,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color:
                                          isButtonEnable
                                              ? greenColor
                                              : greyColor,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "By Continuing , You agree to our",
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TermsConditions(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Terms of Use",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(" & ", textAlign: TextAlign.center),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PrivacyPolicy(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Privacy Policy",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
