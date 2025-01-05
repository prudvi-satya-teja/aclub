import 'package:flutter/material.dart';

// Import all the necessary screens from features folder
import '../features/splash/presentation/splash_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/clubs/presentation/clubs_list_screen.dart';
import '../features/clubs/presentation/club_details_screen.dart';
import '../features/clubs/presentation/add_club_screen.dart';
import '../features/clubs/presentation/edit_club_screen.dart';
import '../features/clubs/presentation/manage_club_members_screen.dart';
import '../features/clubs/presentation/club_calendar_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/auth/presentation/reset_password_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/otp_verification_screen.dart';
import '../features/user/presentation/user_dashboard_screen.dart';
import '../features/user/presentation/user_clubs_list_screen.dart';
import '../features/user/presentation/club_details_screen.dart';
import '../features/user/presentation/user_profile_screen.dart';
import '../features/user/presentation/user_notifications_screen.dart';
import '../features/member/presentation/member_dashboard_screen.dart';
import '../features/member/presentation/member_club_screen.dart';
import '../features/member/presentation/member_chat_screen.dart';
import '../features/member/presentation/club_events_screen.dart';
import '../features/member/presentation/faq_screen.dart';
import '../features/admin/presentation/admin_dashboard_screen.dart';
import '../features/admin/presentation/manage_users_screen.dart';
import '../features/admin/presentation/manage_clubs_screen.dart';
import '../features/admin/presentation/admin_chat_screen.dart';
import '../features/admin/presentation/admin_reports_screen.dart';
import '../features/faq/presentation/faq_list_screen.dart';
import '../features/faq/presentation/faq_details_screen.dart';

class AppRoutes {
  // Define static routes to be used throughout the app
  static const String splashScreen = '/splash';
  static const String homeScreen = '/home';
  static const String clubsListScreen = '/clubs-list';
  static const String clubDetailsScreen = '/club-details';
  static const String addClubScreen = '/add-club';
  static const String editClubScreen = '/edit-club';
  static const String manageClubMembersScreen = '/manage-club-members';
  static const String clubCalendarScreen = '/club-calendar';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String resetPasswordScreen = '/reset-password';
  static const String forgotPasswordScreen = '/forgot-password';
  static const String otpVerificationScreen = '/otp-verification';
  static const String userDashboardScreen = '/user-dashboard';
  static const String userClubsListScreen = '/user-clubs-list';
  static const String userProfileScreen = '/user-profile';
  static const String userNotificationsScreen = '/user-notifications';
  static const String memberDashboardScreen = '/member-dashboard';
  static const String memberClubScreen = '/member-club';
  static const String memberChatScreen = '/member-chat';
  static const String clubEventsScreen = '/club-events';
  static const String faqScreen = '/faq';
  static const String adminDashboardScreen = '/admin-dashboard';
  static const String manageUsersScreen = '/manage-users';
  static const String manageClubsScreen = '/manage-clubs';
  static const String adminChatScreen = '/admin-chat';
  static const String adminReportsScreen = '/admin-reports';
  static const String faqListScreen = '/faq-list';
  static const String faqDetailsScreen = '/faq-details';
  static const String splash = '/splash';


  static Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => SplashScreen(),
    homeScreen: (context) => HomeScreen(),
    clubsListScreen: (context) => ClubsListScreen(),
    clubDetailsScreen: (context) => ClubDetailsScreen(),
    addClubScreen: (context) => AddClubScreen(),
    editClubScreen: (context) => EditClubScreen(),
    manageClubMembersScreen: (context) => ManageClubMembersScreen(),
    clubCalendarScreen: (context) => ClubCalendarScreen(),
    loginScreen: (context) => LoginScreen(),
    signupScreen: (context) => SignupScreen(),
    resetPasswordScreen: (context) => ResetPasswordScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    otpVerificationScreen: (context) => OtpVerificationScreen(),
    userDashboardScreen: (context) => UserDashboardScreen(),
    userClubsListScreen: (context) => UserClubsListScreen(),
    userProfileScreen: (context) => UserProfileScreen(),
    userNotificationsScreen: (context) => UserNotificationsScreen(),
    memberDashboardScreen: (context) => MemberDashboardScreen(),
    memberClubScreen: (context) => MemberClubScreen(),
    memberChatScreen: (context) => MemberChatScreen(),
    clubEventsScreen: (context) => ClubEventsScreen(),
    faqScreen: (context) => FaqScreen(),
    adminDashboardScreen: (context) => AdminDashboardScreen(),
    manageUsersScreen: (context) => ManageUsersScreen(),
    manageClubsScreen: (context) => ManageClubsScreen(),
    adminChatScreen: (context) => AdminChatScreen(),
    adminReportsScreen: (context) => AdminReportsScreen(),
    faqListScreen: (context) => FaqListScreen(),
    faqDetailsScreen: (context) => FaqDetailsScreen(),
  };
}
