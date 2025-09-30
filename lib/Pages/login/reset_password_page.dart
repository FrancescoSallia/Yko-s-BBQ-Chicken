import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/components/complete_button.dart';
import 'package:ykos_bbq_chicken/components/my_logo.dart';
import 'package:ykos_bbq_chicken/components/my_textfield.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
  final TextEditingController _resetPasswordController =
      TextEditingController();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.secondary,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [MyLogo(), SizedBox(width: 15)],
          ),
          SizedBox(height: 100),
          MyTextfield(
            controller: widget._resetPasswordController,
            hintText: "E-mail",
            obscure: false,
            icon: Icons.email_outlined,
          ),
          SizedBox(height: 50),
          CompleteButton(text: "Send E-mail", gesture: () {}),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
