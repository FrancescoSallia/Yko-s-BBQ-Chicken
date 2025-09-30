import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/Pages/login/reset_password_page.dart';
import 'package:ykos_bbq_chicken/components/complete_button.dart';
import 'package:ykos_bbq_chicken/components/my_logo.dart';
import 'package:ykos_bbq_chicken/components/my_textfield.dart';
import 'package:ykos_bbq_chicken/navigation/floating_bottom_nav.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginSelected = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _showPasswort = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo Image
            MyLogo(),
            const SizedBox(height: 50),

            // Toggle container
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Animated highlight background
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment:
                        isLoginSelected
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildToggleButton("Log In", true),
                      _buildToggleButton("Sign Up", false),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            MyTextfield(
              controller: _controllerEmail,
              hintText: "E-mail",
              obscure: false,
              icon: Icons.email,
            ),
            SizedBox(height: 10),
            MyTextfield(
              controller: _controllerPassword,
              hintText: "Password",
              obscure: _showPasswort,
              icon: _showPasswort ? Icons.visibility : Icons.visibility_off,
              iconOnPress: () {
                setState(() {
                  _showPasswort = !_showPasswort;
                });
              },
            ),
            SizedBox(height: 10),
            Visibility(
              visible: isLoginSelected == false ? true : false,
              child: MyTextfield(
                controller: _controllerPassword,
                hintText: "Confirm Password",
                obscure: _showPasswort,
                icon: _showPasswort ? Icons.visibility : Icons.visibility_off,
                iconOnPress: () {
                  setState(() {
                    _showPasswort = !_showPasswort;
                  });
                },
              ),
            ),
            Visibility(
              visible: isLoginSelected ? true : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgor Password?",
                        style: TextStyle(
                          color: AppColors.textFieldColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            CompleteButton(
              text: isLoginSelected ? "Log In" : "Sign Up",
              gesture: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => FloatingBottomNav()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isLoginButton) {
    final bool isSelected =
        (isLoginButton && isLoginSelected) ||
        (!isLoginButton && !isLoginSelected);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLoginSelected = isLoginButton;
          });
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
