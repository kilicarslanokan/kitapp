import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:kitapp/features/auth/presentation/providers/login_provider.dart';
import 'package:kitapp/features/auth/presentation/pages/register_screen.dart';
import 'package:kitapp/widgets/buttons.dart';
import 'package:kitapp/widgets/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/widgets/text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                height: 670.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Center(
                      child: Image.asset(
                        "assets/images/Logo.png",
                        width: 100.w,
                        height: 65.h,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      d.welcomeBack,
                      style: TextStyle(color: Colors.black87, fontSize: 15.sp),
                    ),
                    Text(
                      d.loginMessage,
                      style: TextStyle(
                        color: textRenk,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Text(
                      d.email,
                      style: TextStyle(color: textRenk, fontSize: 20.sp),
                    ),
                    SizedBox(height: 5.h),
                    CostumeTextField(
                      obscureText: false,
                      controller: ref.read(loginRiverpod).email,
                      hintText: "john@mail.com",
                      validator: (value) => validateEmail(value ?? "", context),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      d.password,
                      style: TextStyle(color: textRenk, fontSize: 20.sp),
                    ),
                    SizedBox(height: 5.h),
                    CostumeTextField(
                      obscureText: true,
                      controller: ref.read(loginRiverpod).password,
                      hintText: "●●●●●●●●",
                      validator: (value) => validatePassword(value ?? "", context),
                    ),
                    Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final rememberMe = ref.watch(
                              rememberMeProvider,
                            ); // Provider'dan mevcut state'i oku
                            return Checkbox(
                              value:
                                  rememberMe, // Checkbox'ın mevcut durumunu ata
                              onChanged: (bool? newValue) {
                                ref.read(rememberMeProvider.notifier).state =
                                    newValue!; // Durumu güncelle
                              },
                              activeColor: anaRenk,
                              side: BorderSide(color: anaRenk, width: 2),
                            );
                          },
                        ),
                        Text(
                          d.rememberMe,
                          style: TextStyle(color: anaRenk, fontSize: 15.sp),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            d.register,
                            style: TextStyle(color: anaRenk, fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomButton(
                        child: Text(
                          d.login,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(loginRiverpod).fetch(context, ref);
                          }
                        },
                    ),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    
  }
}
