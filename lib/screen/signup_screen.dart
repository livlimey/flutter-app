import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/style.dart';
import '../helper/pos_textform_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFff512f),
              Color(0xFFdd2476),
            ], // orange-pink gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 20,
              color: Colors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon or Logo
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFFdd2476), Color(0xFFff512f)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Title
                      Text(
                        "Create Account",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: StyleColor.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Join us and explore amazing opportunities",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email Field
                      PosTextformField(
                        controller: emailController,
                        label: "Email",
                        placeholder: "Enter your email",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.deepOrange,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required!";
                          }
                          final regex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!regex.hasMatch(value)) {
                            return "Enter a valid email!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Phone Number Field
                      PosTextformField(
                        controller: phoneController,
                        label: "Phone Number",
                        placeholder: "Enter your phone number",
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.deepOrange,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number is required!";
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Phone number must be numeric!";
                          }
                          if (value.length < 8) {
                            return "Phone number must be at least 8 digits!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      PosTextformField(
                        controller: passwordController,
                        label: "Password",
                        placeholder: "Enter your password",
                        obscureText: isPassword,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.deepOrange,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPassword
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required!";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      PosTextformField(
                        controller: confirmPasswordController,
                        label: "Confirm Password",
                        placeholder: "Re-enter your password",
                        obscureText: isConfirmPassword,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.deepOrange,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmPassword
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPassword = !isConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password!";
                          }
                          if (value != passwordController.text) {
                            return "Passwords do not match!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Registration successful!"),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xFFdd2476),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 10,
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(color: Colors.grey[700]),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFff512f),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
