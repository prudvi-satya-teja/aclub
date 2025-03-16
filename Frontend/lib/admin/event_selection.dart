//event creation
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../auth/authService.dart';
import 'package:intl/intl.dart';
// import 'event_update.dart ';
import 'admin_page.dart';

class EventCreation extends StatefulWidget {
  @override
  _EventCreationState createState() => _EventCreationState();
}

class _EventCreationState extends State<EventCreation> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController guestController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController mainThemeController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  File? _selectedImage;
  bool _imageSelected = false;
  AuthService authService=AuthService();
  void addEvent()async{
    if (_validateInputs()) {
      DateTime eventDate = DateFormat("yyyy-MM-dd").parse(dateTimeController.text);
      final response = await authService.eventCreation(
        eventNameController.text,
        DateFormat("yyyy-MM-dd").format(eventDate),
        guestController.text,
        locationController.text,
        'GDG',
        mainThemeController.text,
        detailsController.text,
        _selectedImage,
      );
      _submitDetails();
      if (response.containsKey('status') && response['status'] == true) {
        // eventNameController.text = '';
        // dateTimeController.text = '';
        // guestController.text = '';
        // locationController.text = '';
        // mainThemeController.text = '';
        // detailsController.text = '';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event Successfully created'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['msg'] ?? 'Failed to create event'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  bool _validateInputs() {
    if (eventNameController.text.isEmpty ||
        dateTimeController.text.isEmpty ||
        guestController.text.isEmpty ||
        locationController.text.isEmpty ||
        mainThemeController.text.isEmpty ||
        detailsController.text.isEmpty ||
        _selectedImage == null) {
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
        title: Center(
          child: Text(
            'Event Creation',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        
        backgroundColor: Color(0xFF040737),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Event Name', eventNameController),
              _buildTextField('Guest', guestController),
              _buildTextField('Location', locationController),
              _buildTextField('Main Theme', mainThemeController),
              _buildTextField('Details', detailsController),
              _buildDateTimePicker(),
              SizedBox(height: screenHeight * 0.02),
              _buildImagePicker(screenHeight, screenWidth),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: addEvent,
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
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFF040737), width: 1),
          ),
        ),
      ),
    );
  }
  Widget _buildDateTimePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedTime != null) {
            setState(() {
              final DateTime selectedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
              dateTimeController.text = selectedDateTime.toString();
            });
          }
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: dateTimeController,
          decoration: InputDecoration(
            labelText: 'Date & Time',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xFF040737), width: 1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(double screenHeight, double screenWidth) {
    double containerHeight = _imageSelected ? screenHeight * 0.2 : screenHeight*0.06;
    double containerWidth = _imageSelected ? screenWidth : screenWidth*0.9;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: _pickImage,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF040737), width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: _selectedImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              _selectedImage!,
              width: double.infinity,
              height: containerHeight,
              fit: BoxFit.cover,
            ),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tap to select an image',
                style: TextStyle(color: Color(0xFF040737)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _imageSelected = true;
      });
    }
  }

  void _submitDetails() {
    print('Event Name: ${eventNameController.text}');
    print('Guest: ${guestController.text}');
    print('Location: ${locationController.text}');
    print('Main Theme: ${mainThemeController.text}');
    print('Details: ${detailsController.text}');
    print('Date: ${dateTimeController.text}');

    print('Image: ${_selectedImage?.path ?? 'No image selected'}');
  }

  @override
  void dispose() {
    eventNameController.dispose();
    guestController.dispose();
    locationController.dispose();
    mainThemeController.dispose();
    detailsController.dispose();
    dateTimeController.dispose();
    super.dispose();
  }
}