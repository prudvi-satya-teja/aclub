import 'package:aclub/rollno.dart';
import 'package:flutter/material.dart';
import '../auth/authService.dart';
class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String? selectedRole;
AuthService authService=AuthService();
  final List<String> roles = ['admin', 'coordinator', 'user'];
  void addMember()async{
    final response=await authService.addMember(firstNameController.text, lastNameController.text,rollNumberController.text,selectedRole,Shared().clubId, phoneNumberController.text);
    _submitDetails();
    if(response.containsKey('status')&&response['status']==true){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully added',),backgroundColor: Colors.green,));
    }else{
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['msg'],),backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: Color(0xFF040737),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              _buildTextField('First Name', firstNameController),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Last Name', lastNameController),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Roll Number', rollNumberController),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Phone Number', phoneNumberController, isPhone: true),
              SizedBox(height: screenHeight * 0.02),
              _buildDropdown('Select Role'),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: addMember,
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
                child: Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
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
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        items: roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
        onChanged: (value) {
          setState(() {
            selectedRole = value;
          });
        },
        decoration: InputDecoration(
          labelText: label,
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
      ),
    );
  }

  void _submitDetails() {
    print('First Name: ${firstNameController.text}');
    print('Last Name: ${lastNameController.text}');
    print('Roll Number: ${rollNumberController.text}');
    print('Phone Number: ${phoneNumberController.text}');
    print('Role: ${selectedRole ?? 'No role selected'}');
    print('clubId: ${Shared().clubId}');
  }
}
