import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper/custom_snack_bar.dart';
import 'package:fruits_hub/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          CustomSnackBar.show(
            context: context,
            message: 'تم التسجيل بنجاح',
            type: SnackBarType.success,
            action: SnackBarAction(
              label: 'متابعة',
              textColor: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          );
        }
        if (state is SignupFailure) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading ? true : false,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
