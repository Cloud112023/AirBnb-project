import 'dart:io';
import 'package:airbnb_portfolio/common/common_functions.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:airbnb_portfolio/constant/text/strings.dart';
import 'package:airbnb_portfolio/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static final routeName = '/SignupPage';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imageFile;
  bool _isLoading = false;

  void _chooseImage() async {
    print('Choose Image');
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      //Convert XFile to File
      File originalFile = File(pickedImage.path);

      //Create temp dir for Compressed file
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(
        tempDir.path,
        "compressed_${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      //Compressed Image
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        originalFile.path,
        quality: 25, //25% quality
      );

      if (compressedBytes != null) {
        final compressedFile = File(targetPath)
          ..writeAsBytesSync(compressedBytes);

        setState(() {
          _imageFile = compressedFile;
        });
      }
    }
  }

  void _createAccount() async {
    if (!_formKey.currentState!.validate() || _imageFile == null) {
      TCommonFunctions.showSnackbar(
        context,
        'Please Fill all fields and choose a profile Image',
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      UserCredential firebaseUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (firebaseUser.user != null) {
        final userID = firebaseUser.user!.uid;

        TStrings.currentUser.id = userID;
        TStrings.currentUser.firstName = _firstNameController.text.trim();
        TStrings.currentUser.lastName = _lastNameController.text.trim();
        TStrings.currentUser.city = _cityController.text.trim();
        TStrings.currentUser.country = _countryController.text.trim();
        TStrings.currentUser.bio = _bioController.text.trim();
        TStrings.currentUser.email = email;
        TStrings.currentUser.password = password;

        TStrings.currentUser.addToFireStore();

        if (!context.mounted) return;
        TCommonFunctions.showSnackbar(
          context,
          'your account created successfully.',
        );

        await FirebaseAuth.instance.signOut();
        Navigator.pop(context);
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            //Image
            Image.asset(
              'assets/images/signup.png',
              width: MediaQuery.of(context).size.width * .8,
            ),

            SizedBox(height: 15),

            Text(
              'Start Your Journey \n${TStrings.AppName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
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
                    icon: Icons.email,
                    isPassword: true,
                    maxLines: 1,
                  ),

                  // First Name
                  CustomTextField(
                    controller: _firstNameController,
                    label: 'First Name',
                    icon: Icons.person,
                  ),

                  // Last Name
                  CustomTextField(
                    controller: _lastNameController,
                    label: 'Last Name',
                    icon: Icons.email,
                  ),

                  // City
                  CustomTextField(
                    controller: _cityController,
                    label: 'City',
                    icon: Icons.location_city,
                  ),

                  // Country
                  CustomTextField(
                    controller: _countryController,
                    label: 'Country',
                    icon: Icons.flag,
                  ),

                  CustomTextField(
                    controller: _bioController,
                    label: 'Tell Us a  Little About You',
                    icon: Icons.info,
                    maxLines: 3,
                  ),

                  SizedBox(height: 25),

                  //Button
                  MaterialButton(
                    onPressed: _chooseImage,
                    child: _imageFile == null
                        ? Icon(Icons.add_a_photo)
                        : CircleAvatar(
                            backgroundImage: FileImage(_imageFile!),
                            radius: 60,
                          ),
                  ),

                  SizedBox(height: 30),

                  _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : MaterialButton(
                          color: Colors.white,
                          height: 55,
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onPressed: _createAccount,
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
