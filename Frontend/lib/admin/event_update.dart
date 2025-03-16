//event update
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:aclub/auth/authService.dart';
import 'package:intl/intl.dart';

class UpdateEventScreen extends StatefulWidget {
  final String eventName;
final List<String>list;
  final String location;
  // final String mainTheme;
  final String details;
  final DateTime dateTime;
   File? eventImage;
  UpdateEventScreen({
    required this.eventName,
    required this.list,
    required this.location,
    // required this.mainTheme,
    required this.details,
    required this.dateTime,
    this.eventImage,
  });

  @override
  _UpdateEventScreenState createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  late TextEditingController eventNameController;
  late TextEditingController guestController;
  late TextEditingController locationController;
  // late TextEditingController mainThemeController;
  late TextEditingController detailsController;
  late TextEditingController dateTimeController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    eventNameController = TextEditingController(text: widget.eventName);
    guestController = TextEditingController(text: widget.list[0]);
    locationController = TextEditingController(text: widget.location);
    // mainThemeController = TextEditingController(text: widget.mainTheme);
    detailsController = TextEditingController(text: widget.details);
    dateTimeController = TextEditingController(text: widget.dateTime.toString());
    //_selectedImage = widget.eventImage;
  }
  AuthService authService=AuthService();
  void addEvent()async{
    if (_validateInputs()) {
      DateTime eventDate = widget.dateTime;
      // DateFormat("yyyy-MM-dd").parse(dateTimeController.text);
      final response = await authService.updateEvent(
        widget.eventName,
        eventNameController.text,
        DateFormat("yyyy-MM-dd").format(eventDate),
        guestController.text,
        locationController.text,
        'GDG',
        // mainThemeController.text,
        detailsController.text,
        _selectedImage
      );
      _updateEvent();
      if (response.containsKey('status') && response['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event Successfully updated'),
            backgroundColor: Colors.green,
          ),
        );
        print('respons: $response');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => AdminPage()),
        // );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['msg'] ?? 'Failed to event update'),
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
        // mainThemeController.text.isEmpty ||
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Center(
          child: Text('Update Event', style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
        backgroundColor: Color(0xFF040737),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Event Name', eventNameController),
              SizedBox(height: screenHeight * 0.01),
              _buildTextField('Guest', guestController),
              SizedBox(height: screenHeight * 0.01),
              _buildTextField('Location', locationController),
              SizedBox(height: screenHeight * 0.01),
              // _buildTextField('Main Theme', mainThemeController),
              // SizedBox(height: screenHeight * 0.01),
              _buildTextField('Details', detailsController),
              SizedBox(height: screenHeight * 0.01),
              _buildDateTimePicker(),
              SizedBox(height: screenHeight * 0.01),
              _buildImagePicker(screenHeight, screenWidth),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF040737),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.016,
                    horizontal: screenWidth * 0.3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Update Event', style: TextStyle(color: Colors.white, fontSize: 18)),
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
        textInputAction: TextInputAction.next,
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
    double containerHeight = _selectedImage != null ? screenHeight * 0.2 : screenHeight * 0.06;
    double containerWidth = _selectedImage != null ? screenWidth : screenWidth * 0.9;

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
            color: Colors.white,),
          child: _selectedImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(_selectedImage!,
              width: containerWidth,
              height: containerHeight,
              fit: BoxFit.cover,
            ),
          )
              : widget.eventImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
            widget.eventImage!,
              width:containerWidth ,
              height: containerHeight,
              fit: BoxFit.cover,
            ),
          ) : Center(
            child: Text('Tap to select an image', style: TextStyle(color: Color(0xFF040737)),),
          ),
        ),
      ),
    );
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() { 
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _updateEvent() {
    print('Updated Event Name: ${eventNameController.text}');
  }
}