import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({
    super.key,
    required this.isMobile,
    required this.sectionKey,
  });

  final bool isMobile;
  final Key sectionKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.w : 80.w,
        vertical: 80.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff0f172a),
            Color(0xff111827),
            Color(0xff020617),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          /// Blur Circle 1
          Positioned(
            top: -80,
            right: -60,
            child: _circle(
              size: 260,
              color: Colors.blue.withOpacity(0.12),
            ),
          ),

          /// Blur Circle 2
          Positioned(
            bottom: -100,
            left: -80,
            child: _circle(
              size: 320,
              color: Colors.purple.withOpacity(0.12),
            ),
          ),

          /// Main Content
          isMobile
              ? Column(
            children: [
              _aboutCards(),
              SizedBox(height: 40.h),
              _aboutContent(),
            ],
          )
              : Row(
            children: [
              Expanded(
                child: _aboutContent(),
              ),
              SizedBox(width: 60.w),
              Expanded(
                child:  _aboutCards(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Me",
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: isMobile ? 32.sp : 42.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 20.h),

        Text(
          "Flutter Developer",
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 22.sp : 30.sp,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 20.h),

        Text(
          "I build high-performance Flutter applications "
              "with beautiful UI/UX and scalable architecture. "
              "Passionate about clean code, animations, "
              "responsive design, and modern app experiences.",
          style: TextStyle(
            color: Colors.white70,
            height: 1.8,
            fontSize: isMobile ? 15.sp : 17.sp,
          ),
        ),
      ],
    );
  }

  Widget _aboutCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _infoCard(
                icon: Icons.code_rounded,
                title: "1 Years",
                subtitle: "Flutter Experience",
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: _infoCard(
                icon: Icons.phone_android_rounded,
                title: "4",
                subtitle: "Apps Built",
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        Row(
          children: [
            Expanded(
              child: _infoCard(
                icon: Icons.web_rounded,
                title: "Responsive",
                subtitle: "Web Development",
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: _infoCard(
                icon: Icons.flash_on_rounded,
                title: "Clean",
                subtitle: "Architecture",
              ),
            ),
          ],
        ),

        SizedBox(height: 24.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tech Stack",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20.h),

              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _techBadge("Flutter"),
                  _techBadge("Dart"),
                  _techBadge("Firebase"),
                  _techBadge("REST API"),
                  _techBadge("Git"),
                  _techBadge("Figma"),
                  _techBadge("State Management (Bloc)"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.deepPurpleAccent,
            size: 34.sp,
          ),

          SizedBox(height: 16.h),

          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _techBadge(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  Widget _circle({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 120,
            spreadRadius: 40,
          ),
        ],
      ),
    );
  }
}