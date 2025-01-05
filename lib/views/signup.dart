import 'package:flutter/material.dart';
// Import your home screen
import 'login.dart'; // Import your login screen

class SimpleRegisterScreen extends StatefulWidget {
  const SimpleRegisterScreen({Key? key}) : super(key: key);

  @override
  State<SimpleRegisterScreen> createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
  late String email, password, confirmPassword, name, rollNo;
  String? emailError, passwordError, confirmPasswordError, nameError, rollNoError;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    confirmPassword = '';
    name = '';
    rollNo = '';
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
      nameError = null;
      rollNoError = null;
    });
  }

  bool validateInputs() {
    resetErrorText();
    bool isValid = true;
    final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|aec\.edu\.in|outlook\.com)$");

    if (name.isEmpty) {
      setState(() => nameError = 'Name is required');
      isValid = false;
    }

    if (rollNo.isEmpty || !RegExp(r"^\d{2}(A9|P3|MH)\d{1}[a-zA-Z]\d{4}$").hasMatch(rollNo)) {
      setState(() => rollNoError = 'Enter a valid roll number');
      isValid = false;
    }

    if (email.isEmpty || !emailRegExp.hasMatch(email)) {
      setState(() => emailError = 'Enter a valid email');
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() => passwordError = 'Password is required');
      isValid = false;
    }

    if (password != confirmPassword) {
      setState(() => confirmPasswordError = 'Passwords do not match');
      isValid = false;
    }

    return isValid;
  }

  Future<void> submit() async {
    if (validateInputs()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SimpleLoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD5D5), Color(0xFFFFA07A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Image.asset(
                'assets/logo/AU.png',
                height: 100,
              ),
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'Create Account,',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started!',
                style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildInputField(
                label: 'Name',
                errorText: nameError,
                onChanged: (value) => setState(() => name = value),
              ),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(
                label: 'Roll Number',
                errorText: rollNoError,
                onChanged: (value) => setState(() => rollNo = value),
              ),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(
                label: 'Email',
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => setState(() => email = value),
              ),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(
                label: 'Password',
                errorText: passwordError,
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
              ),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(
                label: 'Confirm Password',
                errorText: confirmPasswordError,
                obscureText: true,
                onSubmitted: (_) => submit(),
                onChanged: (value) => setState(() => confirmPassword = value),
              ),
              SizedBox(height: screenHeight * 0.025),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        minimumSize: Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSignInText(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    String? errorText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    required void Function(String) onChanged,
    void Function(String)? onSubmitted,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SimpleLoginScreen()),
      ),
      child: RichText(
        text: const TextSpan(
          text: "I'm already a member, ",
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
