import 'login.dart';
import 'package:flutter/material.dart';
import 'authService.dart';
import 'otp_page.dart';
//changepassword
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _rollNumberController = TextEditingController();
  final AuthService authService = AuthService();

  void _sendOtp() {
    String rollNumber = _rollNumberController.text.trim();
    if (rollNumber.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpPage(rollNumber: rollNumber),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your roll number")),
      );
    }
  }

  void forgotPass() async {
    final response = await authService.forgotPass(_rollNumberController.text.trim());
    if (response.containsKey('status') && response['status'] == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("OTP Sent Successfully")));
      _sendOtp();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['msg'] ?? "Unknown error")));
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(height: screenHeight*0.2,),
                    TextField(
                      controller: _rollNumberController,
                      decoration: InputDecoration(
                        labelText: 'Enter Roll Number',
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
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 40),
                   ElevatedButton(
  onPressed: forgotPass,
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF040737),
    padding: EdgeInsets.symmetric(
      vertical: screenHeight * 0.016,
    ),
    minimumSize: Size(screenWidth * 0.8, 50), // Ensures proper width
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: const Text(
    'Submit',
    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
  ),
),

                  ],
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
