import 'package:flutter/material.dart';
import 'authService.dart';
import 'login.dart';

class PasswordReset extends StatefulWidget {
  final String? rollNumber; // Make rollNumber optional

  const PasswordReset({super.key, this.rollNumber});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final AuthService authService = AuthService();

  void _submit() {
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            widget.rollNumber != null && widget.rollNumber!.isNotEmpty
                ? "Password Reset Successful for Roll Number: ${widget.rollNumber}!"
                : "Password Reset Successful!"
        ),
      ),

    );
      MaterialApp(
        routes: {
          '/': (context) => PasswordReset(),
          '/login': (context) => SimpleLoginScreen(),
        },
      );

    }


    void resetPassword() async {
    final response = await authService.resetPass(
        widget.rollNumber ?? "",
         _newPasswordController.text.trim(),// Use an empty string if rollNumber is null
    );

    if (response.containsKey('status') && response['status'] == true) {
      _submit();
      Navigator.push(context,MaterialPageRoute(builder: (context)=>(SimpleLoginScreen())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['msg'] ?? "Enter valid details")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
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
                  'assets/ACLUB.png'
                  ,
                  height: screenHeight / 10,
                  width: screenWidth / 3,
                ),
              ),
              Positioned(
                left: screenHeight*0.017,
                bottom: screenHeight*0.14,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },child: Icon(Icons.arrow_back,size: 30,color: Colors.white,)
                ),
              )
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                   SizedBox(height:screenHeight*0.15),
                  TextField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Enter New Password',
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
                        borderSide: BorderSide(color: Color(0xFF040737),width: 1),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xFF040737),
                        ),
                        onPressed: () {
                          setState(() {
                            _isNewPasswordVisible = !_isNewPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isNewPasswordVisible,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Color(0xFF040737),
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isConfirmPasswordVisible,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: resetPassword,
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
                    child: const Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height - 50);
    path.quadraticBezierTo(3 * size.width / 4, size.height - 100, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
