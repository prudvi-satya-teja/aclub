import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart' as flutter_animate;
import 'package:smooth_page_indicator/smooth_page_indicator.dart' as smooth_page;


class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late int activeTabIndex;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    activeTabIndex = 0;
  }

  void setActiveTabIndex(int index) {
    setState(() {
      activeTabIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  Widget _buildMessagesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You have no unread messages',
          style: GoogleFonts.lato(
            fontSize: 10.sp, // Enhanced text size
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.85),
          ),
        ),
        SizedBox(height: 12.h), // Enhanced spacing
        Animate(
          effects: const [FadeEffect(), MoveEffect()],
          child: Text(
            "When you contact a host or send a reservation request, your messages will appear here.",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w300,
              height: 1.5,
              fontSize: 12.sp, // Enhanced text size
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        SizedBox(height: 18.h),
        Center(
          child: Icon(
            Icons.inbox_rounded,
            size: 90.sp, // Cool icon to illustrate empty inbox
            color: Colors.grey.withOpacity(0.4),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scaleXY(end: 1.1),
        ),
      ],
    );
  }

  Widget _buildNotificationsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Animate(
          effects: [flutter_animate.FadeEffect(), flutter_animate.ScaleEffect()],
          child: Icon(
            Icons.notifications_active_rounded,
            size: 90.sp,
            color: Colors.greenAccent.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "You're all caught up!",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: Colors.black.withOpacity(0.85),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "No new notifications",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(context, designSize: const Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 4.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cool animated title
              Animate(
                effects: const [FadeEffect(duration: Duration(milliseconds: 800)), MoveEffect()],
                child: Text(
                  'Inbox',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Tab Controller with smooth transitions
              SimpleTextTabs(
                labels: const ['Messages', 'Notifications'],
                onTabChange: setActiveTabIndex,
                activeTabIndex: activeTabIndex,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => setActiveTabIndex(index),
                  children: [
                    _buildMessagesTab(),
                    _buildNotificationsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleTextTabs extends StatelessWidget {
  final List<String> labels;
  final Function(int) onTabChange;
  final int activeTabIndex;

  const SimpleTextTabs({
    Key? key,
    required this.labels,
    required this.onTabChange,
    this.activeTabIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        labels.length,
            (index) => Expanded(
          child: GestureDetector(
            onTap: () => onTabChange(index),
            child: Column(
              children: [
                Text(
                  labels[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: activeTabIndex == index ? Colors.blueAccent : Colors.grey,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 4.h,
                  color: activeTabIndex == index ? Colors.blueAccent : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
