import 'dart:convert';
import 'package:aclub/rollno.dart';
import 'dart:io';

import '../admin/event_selection.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =// 'https://lh8bs0gl-3001.inc1.devtunnels.ms';
  'https://auclub.onrender.com';
  // 'https://lh8bs0gl-3001.inc1.devtunnels.ms';
  //'https://aclub.onrender.com';

Future<Map<String, dynamic>> registerUser(
    String first, String last, String roll, String phone, String pass) async {
  final res = await http.post(
    Uri.parse('$baseUrl/auth/signup'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "firstName": first,
      "lastName": last,
      "rollNo": roll,
      "phoneNo": phone,
      "password": pass
    }),
  );

  print("Response Code: ${res.statusCode}");
  print("Response Body: ${res.body}");

  return jsonDecode(res.body);
}
Future<Map<String,dynamic>>signUser(String rollNumber,String password)async{
final res=await http.post(
  Uri.parse('$baseUrl/auth/login'),
  headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "rollNo":rollNumber,
      "password":password
    }),
);
print("response code:${res.statusCode}");
print("response code:${res.body}");
return jsonDecode(res.body);
}
Future<Map<String,dynamic>>forgotPass(String roll)async{
  final res=await http.post(
    Uri.parse('$baseUrl/auth/forgot-password'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "rollNo":roll
     })
  );
  print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//verify Otp
Future<Map<String,dynamic>>verifyOtp(String otp,String rollNo)async{
  final res=await http.post(
    Uri.parse('$baseUrl/auth/verify-otp'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "rollNo":rollNo,
      "otp":otp,
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

Future<Map<String,dynamic>>resetPass(String password,String rollNo)async{
  final res=await http.post(
    Uri.parse('$baseUrl/auth/set-forgot-password'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "rollNo":rollNo,
      "password":password
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
Future<Map<String,dynamic>>allPastEvents()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-past-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//event regestered members
Future<Map<String,dynamic>>allRegesteredStudents(String eventName)async{
  // print(eventName);
  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
  final res=await http.get(
    
    Uri.parse('$baseUrl/registrations/registered-users?eventName=$eventName'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');

  // return jsonDecode(eventName);
  return jsonDecode(res.body);
}
//post feedback
Future<Map<String,dynamic>>giveFeedBack(String eventName,String feedback,int rating,String rollNo)async{
  
  // eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");

  final res=await http.post(
    Uri.parse('$baseUrl/registrations/give-feedback'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "eventName":eventName,
      "feedback":feedback,
      'rating':rating,
      'token':Shared().token,
      'rollNo':Shared().rollNo
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  print('${eventName}');
  return jsonDecode(res.body);
}
//get feedback
Future<Map<String,dynamic>>getFeedBack(String eventName)async{
  
  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
  final res=await http.get(
    Uri.parse('$baseUrl/registrations/get-feedback?eventName=$eventName'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//event regestration 
Future<Map<String,dynamic>>registerEvent(String eventName,String rollNo)async{
  final res=await http.post(
    // Uri.parse('$baseUrl/registrations/register-event'),
    Uri.parse('$baseUrl/registrations/register-event'),
     headers: {
      "Authorization":"Bearer ${Shared().token}",
      'Content-Type': 'application/json'},
     body: jsonEncode({
      "eventName":eventName
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//regestration status
Future<Map<String,dynamic>>regestrationStatus(String eventName,String rollNo)async{

  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
  final res=await http.get(
    Uri.parse('$baseUrl/registrations/registration-status?eventName=$eventName}'),
    headers: {
      "Authorization":"Bearer ${Shared().token}",
      'Content-Type': 'application/json'},

 );
   print('response code:${res.statusCode}');
   print('response body:${res.body}');
   return jsonDecode(res.body);
 }
 //get all clubs data 
 Future<Map<String,dynamic>>getAllClubsData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/clubs/get-all-clubs'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

//get live events
 Future<Map<String,dynamic>>getLiveData(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/ongoing-events?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//get Live upcoming data
 Future<Map<String,dynamic>>getupComingData(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/upcoming-events?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

//get past events
 Future<Map<String,dynamic>>getPastData(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/past-events?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
 Future<Map<String,dynamic>>getEventDetailsByName(String eventName)async{
  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
  final res=await http.get(
    Uri.parse('$baseUrl/events/get-event-details?eventName=$eventName'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}, , eventname : ${eventName}');
  return jsonDecode(res.body);
}


//get all live events
 Future<Map<String,dynamic>>getAllLiveData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-ongoing-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//get all Live upcoming data
 Future<Map<String,dynamic>>getAllupComingData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-upcoming-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

//get all past events
 Future<Map<String,dynamic>>getAllPastData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-past-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

//getClubMembers
 Future<Map<String,dynamic>>getClubMembers(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/participation/get-club-members?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}


// to add memeber to a club
Future<Map<String, dynamic>> addMember(
    String first, String last, String roll, String? role, String clubId, String phoneNo) async {
  final res = await http.post(
    Uri.parse('$baseUrl/users/add-user'),
    // Uri.parse('https://lh8bs0gl-3001.inc1.devtunnels.ms/user/add-user'),
    headers: {
      "Authorization":"Bearer ${Shared().token}",
      'Content-Type': 'application/json'},
    body: jsonEncode({
      "firstName": first,
      "lastName": last,
      "rollNo": roll,
      "role": role,
      "clubId": clubId,
      "phoneNo": phoneNo
    }),
  );

  print("Response Code: ${res.statusCode}");
  print("Response Body: ${res.body}");

  return jsonDecode(res.body);
}


 Future<Map<String,dynamic>>getUserDetails(String token)async{
  final res=await http.get(
    Uri.parse('$baseUrl/users/user-details'),
     headers: {
      "Authorization":"Bearer $token",
      'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
Future<Map<String, dynamic>> eventCreation(
        String eventName,
        String date, // Changed to String to match the expected type
        String guest,
        String location,
        String clubId,
        String mainTheme,
        String details,
        File? image, // Keep this as File? for optional image uploads
        ) async {
      // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzhhMTA2MWJlZGRmZmE4ZGVmMTIxYTQiLCJhZG1pbiI6dHJ1ZSwicm9sbE5vIjoiMjJhOTFhMDU3MCIsImlhdCI6MTc0MTk1Njk2OCwiZXhwIjoxNzUwNTk2OTY4fQ.Msj8rmceN-rO4MnRs8xOJNPv1QhQD7ULSYEuSUy2-G0"; // Replace with actual token logic
      String token = Shared().token;
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/events/create-event'),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        'Content-Type': 'multipart/form-data',
      });

      request.fields.addAll({
        "eventName": eventName,
        "date": date,
        "guest": guest,
        "location": location,
        "clubId": clubId,
        "mainTheme": mainTheme,
        "details": details,
      });

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('eventImage', image.path),
        );
      }

      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

      print("Response Code: ${res.statusCode}");
      print("Response Body: ${res.body}");

      return jsonDecode(res.body);
    }
//update User details
Future<Map<String, dynamic>> UpdateUser(String rollNo,String role
    ) async {
  final res = await http.post(
    Uri.parse('$baseUrl/users/update-user'),
    // Uri.parse('https://lh8bs0gl-3001.inc1.devtunnels.ms/user/add-user'),
    headers: {
      "Authorization":"Bearer ${Shared().token}",
      'Content-Type': 'application/json'},
    body: jsonEncode({
     "rollNo":rollNo,
     "role":role,
     "clubId":Shared().clubId
    }),
  );

  print("Response Code: ${res.statusCode}");
  print("Response Body: ${res.body}");

  return jsonDecode(res.body);
}

//get All ClubMembers
 Future<Map<String,dynamic>>getAllClubMembers(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/users/get-all-users?clubId=$clubId'),
     headers: {
       "Authorization":"Bearer ${Shared().token}",
      'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//delete the club members
Future<Map<String, dynamic>> deleteClubMember(String rollNo,String role
    ) async {
  final res = await http.post(
    Uri.parse('$baseUrl/users/delete-user'),
    // Uri.parse('https://lh8bs0gl-3001.inc1.devtunnels.ms/user/add-user'),
    headers: {
      "Authorization":"Bearer ${Shared().token}",
      'Content-Type': 'application/json'},
    body: jsonEncode({
     "rollNo":rollNo,
     "role":role,
     "clubId":Shared().clubId
    }),
  );

  print("Response Code: ${res.statusCode}");
  print("Response Body: ${res.body}");

  return jsonDecode(res.body);
}


//delete the event
Future<Map<String, dynamic>> deleteEvent(String eventName) async {
  final res = await http.post(
    Uri.parse('$baseUrl/events/delete-event'),
    // Uri.parse('https://lh8bs0gl-3001.inc1.devtunnels.ms/user/add-user'),
    headers: {
      "Authorization":"Bearer ${Shared().token}",
      'Content-Type': 'application/json'},
    body: jsonEncode({
    //  "rollNo":rollNo,
    //  "role":role,
     "clubId":Shared().clubId,
     "eventName": eventName
    }),
  );

  print("Response Code: ${res.statusCode}");
  print("Response Body: ${res.body}");

  return jsonDecode(res.body);
}


// update event
    Future<Map<String, dynamic>> updateEvent(
        String eventName,
        String neweventName,
        String date,
        String guest,
        String location,
        String clubId,
        String details,
        File? image,
        ) async {
      String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzhhMTA2MWJlZGRmZmE4ZGVmMTIxYTQiLCJhZG1pbiI6dHJ1ZSwicm9sbE5vIjoiMjJhOTFhMDU3MCIsImlhdCI6MTc0MTk1Njk2OCwiZXhwIjoxNzUwNTk2OTY4fQ.Msj8rmceN-rO4MnRs8xOJNPv1QhQD7ULSYEuSUy2-G0"; // Replace with actual token logic

      final request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/events/update-event'),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        'Content-Type': 'multipart/form-data',
      });
      request.fields.addAll({
        "eventName": eventName,
        "newEventName": neweventName,
        "newDate": date,
        "newGuest": guest,
        "newLocation": location,
        "clubId": clubId,
        // "mainTheme": mainTheme,
        "newDetails": details,
      });

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('eventImage', image.path),
        );
      }

      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

      print("Response Code: ${res.statusCode}");
      print("Response Body: ${res.body}");

      return jsonDecode(res.body);
    }

}