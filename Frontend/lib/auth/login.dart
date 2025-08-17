import 'authService.dart';
import 'forgot.dart';
import '../home/homepage.dart';
import '../rollno.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../home/bottom_Navbar.dart';

class SimpleLoginScreen extends StatefulWidget {
  final Function(String? rollNumber, String? password)? onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, super.key});

  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  late String rollNumber, password;
  String? rollNumberError, passwordError;
  bool _obscurePassword = true;
  AuthService authService = AuthService();

  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    rollNumber = '';
    password = '';
  }

  void _resetErrorText() {
    setState(() {
      rollNumberError = null;
      passwordError = null;
    });
  }

  bool _validateInputs() {
    _resetErrorText();
    bool isValid = true;

    if (rollNumber.isEmpty) {
      setState(() => rollNumberError = 'Please enter your roll number');
      isValid = false;
    }
    if (password.isEmpty) {
      setState(() => passwordError = 'Please enter your password');
      isValid = false;
    }
    return isValid;
  }

  void login() async {
    _validateInputs(); // Ensure validation is synchronous or await if needed
    print(rollNumber);
    print(password);

    final response = await authService.signUser(rollNumber.trim(), password);

    if (response.containsKey('status') && response['status'] == true) {
      Shared shared = Shared();

      await shared.saveRollNo(rollNumber);
      await shared.saveToken(response['token']);

      // Ensure Shared Preferences are updated before fetching details
      await shared.init();
      String token = shared.token;

      final res = await authService.getUserDetails(token);
      print(res);

      List<dynamic> details = res['details'];
      List<dynamic> clubs =
          details.isNotEmpty && details[0].containsKey('clubs')
              ? details[0]['clubs']
              : [];

      bool isAdmin = false;

      for (var club in clubs) {
        if (club is Map && club['role'] == 'admin') {
          String clubId = club['clubId'];
          await shared.saveClubId(clubId, true);
          isAdmin = true;
          break;
        }
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Successfully logged in")));

      if (!context.mounted) return;

      // 🔥 Use pushReplacement to remove login screen from the stack
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isAdmin ? Nav_Bar(val: 1) : Nav_Bar(val: 0)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${response['msg']}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: screenHeight * 0.24,
                  width: screenWidth,
                  color: Color(0xFF040737),
                ),
              ),
              Positioned(
                top: screenHeight * 0.05,
                left: screenWidth * 0.30,
                child: Image.asset(
                  'assets/ACLUB.png',
                  height: screenHeight / 10,
                  width: screenWidth / 3,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Welcome,',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Sign in to continue!',
                      style: TextStyle(
                          fontSize: 18, color: Colors.black.withOpacity(0.8))),
                ),
                SizedBox(height: screenHeight * 0.08),
                _buildTextField(
                  label: 'Roll Number',
                  errorText: rollNumberError,
                  onChanged: (value) => setState(() => rollNumber = value),
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildTextField(
                  label: 'Password',
                  errorText: passwordError,
                  obscureText: true,
                  isPasswordField: true,
                  onChanged: (value) => setState(() => password = value),
                ),
                SizedBox(height: screenHeight * 0.01),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                    child: const Text('Forgot Password?',
                        style:
                            TextStyle(color: Color(0xFF3B7CD6), fontSize: 14)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF040737),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.016,
                            horizontal: screenWidth * 0.37,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                _buildSignUpText(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? errorText,
    bool obscureText = false,
    bool isPasswordField = false,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFF040737), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFF040737), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFF040737), width: 1),
        ),
        suffixIcon: isPasswordField
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFF040737),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
      obscureText: isPasswordField ? _obscurePassword : obscureText,
      onChanged: onChanged,
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SimpleRegisterScreen()),
          ),
          child: Text(
            ' Sign Up',
            style: TextStyle(
                fontSize: 17,
                color: Color(0xFF3B7CD6),
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 50);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height - 100, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
