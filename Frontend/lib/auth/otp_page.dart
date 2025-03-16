import 'package:flutter/material.dart';
import 'authService.dart';
import 'password_Reset.dart';

class OtpPage extends StatefulWidget {
  final String rollNumber;

  const OtpPage({super.key, required this.rollNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final AuthService authService = AuthService();

  void _submit() {
    String otp = _otpController.text.trim();

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP is required")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP Submitted for Roll Number: ${widget.rollNumber}!")),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordReset(rollNumber: widget.rollNumber),
      ),
    );
  }

  void resetPassword() async {
    final response = await authService.verifyOtp(_otpController.text.trim(),widget.rollNumber);

    if (response.containsKey('status') && response['status'] == true) {
      _submit();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordReset(rollNumber: widget.rollNumber)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['msg'] ?? "Enter valid OTP")));
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
                  'assets/ACLUB.png'
                  ,
                  height: screenHeight / 10,
                  width: screenWidth / 3,
                ),
              ),
               Positioned(
                left: screenHeight*0.017,
                bottom: screenHeight*0.18,
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
                   SizedBox(height:screenHeight*0.2),
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
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
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height:screenHeight*0.03 ),
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
