import 'package:fruits_hub/exports.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  AutovalidateMode autovaildateMode = AutovalidateMode.disabled;
  String? email;
  String? password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovaildateMode,
          child: Column(
            children: [
              CustomTextFormField(
                onSaved: (value) {
                  email = value?.trim();
                },
                hintText: 'البريد الإلكتروني',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                onSaved: (value) {
                  password = value?.trim();
                },
                hintText: 'كلمة المرور',
                isPasswordField: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyles.semiBold13
                      .copyWith(color: AppColors.lightPrimaryColor),
                ),
              ]),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    if (email != null && password != null) {
                      context
                          .read<SigninCubit>()
                          .signInWithEmailAndPassword(email!, password!);
                    }
                  } else {
                    setState(() {
                      autovaildateMode = AutovalidateMode.always;
                    });
                  }
                },
                text: 'تسجيل دخول',
              ),
              const SizedBox(
                height: 30,
              ),
              const DontHaveAccountSection(),
              const SizedBox(
                height: 70,
              ),
              const OrDivider(),
              const SizedBox(
                height: 40,
              ),
              SocialLoginButton(
                label: 'تسجيل بواسطة جوجل',
                assetPath: Assets.assetsImagesGoogle,
                onPressed: () {
                  context.read<SigninCubit>().signinWithGoogle();
                },
              ),
              // Apple Sign-In hidden on web (only works on iOS)
              // TODO: Add Platform.isIOS check for mobile when needed
              const SizedBox(
                height: 16,
              ),
              SocialLoginButton(
                label: 'تسجيل بواسطة فيسبوك',
                assetPath: Assets.assetsImagesFacebook,
                onPressed: () {
                  // context.read<SigninCubit>().signinWithFacebook();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DontHaveAccountSection extends StatelessWidget {
  const DontHaveAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: '  لا تمتلك حساب؟',
            style: TextStyle(
              color: Color(0xFF949D9E),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 0.09,
            ),
          ),
          const TextSpan(
            text: ' ',
            style: TextStyle(
              color: Color(0xFF616A6B),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 0.09,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, SignupView.routeName);
              },
            text: 'قم بإنشاء حساب',
            style: const TextStyle(
              color: Color(0xFF1B5E37),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 0.09,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
