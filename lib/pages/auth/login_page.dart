import 'package:airbnb_portfolio/constant/text/strings.dart';
import 'package:airbnb_portfolio/models/user_object.dart';
import 'package:airbnb_portfolio/pages/auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/common_functions.dart';
import '../../widgets/custom_text_field.dart';
import '../guest/guest_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static final routeName = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Contact contact = Contact();

  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      UserCredential firebaseUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (firebaseUser.user != null) {
        final userID = firebaseUser.user!.uid;
        TStrings.currentUser.id = userID;
        await TStrings.currentUser.getPersonalInfoFromFirestore();

        if (!context.mounted) return;
        TCommonFunctions.showSnackbar(
          context,
          'You are Logged-in sucessfully.',
        );

        await FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => GuestHomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter valid email address';
          break;
        case 'weak-password':
          errorMessage =
              'Password is too weak. Please use atleast 6 characters';
          break;
        default:
          errorMessage = 'Sign up failed. Please try again later.';
      }
      TCommonFunctions.showSnackbar(context, errorMessage);
    } catch (e) {
      if (!context.mounted) return;
      TCommonFunctions.showSnackbar(
        context,
        e.toString(),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signup() {
    Navigator.pushNamed(context, SignupPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png'),

                Text(
                  'Find Stats & Rentals with ${TStrings.AppName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26.0),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email,
                      ),

                      // Password
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        icon: Icons.lock,
                        isPassword: true,
                        maxLines: 1,
                      ),

                      SizedBox(height: 35),

                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 15,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(fontSize: 22),
                                ),
                        ),
                      ),

                      SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 15,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _isLoading ? null : _signup,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
