import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parth_kanjariya_portfolio/screen/project_section.dart';
import 'package:parth_kanjariya_portfolio/screen/skills_section.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'about_section.dart';
import 'contact_section.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  String selectedTab = "Home";

  final List<String> titles = [
    "Flutter Developer",
    "Mobile App Developer",
    "Web Developer",
    "UI/UX Enthusiast",
  ];

  void scrollToSection(GlobalKey key, String tab) {
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );

      setState(() {
        selectedTab = tab;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).smallerThan(TABLET);

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            /// HOME SECTION
            Container(
              key: homeKey,
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
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
                  /// Background Blur Circles
                  Positioned(
                    top: -100,
                    left: -80,
                    child: _circle(
                      size: 300,
                      color: Colors.blue.withOpacity(0.15),
                    ),
                  ),

                  Positioned(
                    bottom: -120,
                    right: -80,
                    child: _circle(
                      size: 350,
                      color: Colors.purple.withOpacity(0.15),
                    ),
                  ),

                  /// Main Content
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mobile ? 24.w : 80.w,
                      vertical: 40.h,
                    ),
                    child: Column(
                      children: [
                        /// Navbar
                        _buildNavbar(mobile),

                        SizedBox(height: mobile ? 60.h : 100.h),

                        /// Hero Section
                        mobile
                            ? Column(
                                children: [
                                  _buildLeftSection(mobile),
                                  SizedBox(height: 50.h),
                                  _buildRightSection(mobile),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: _buildLeftSection(mobile),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: _buildRightSection(mobile),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ABOUT SECTION
            AboutSection(isMobile: mobile, sectionKey: aboutKey),

            /// PROJECTS SECTION
            Container(key: projectsKey, child: const ProjectsSection()),

            /// SKILLS SECTION
            Container(key: skillsKey, child: const SkillSection()),

            /// CONTACT SECTION
            Container(key: contactKey, child: const ContactSection()),
          ],
        ),
      ),
    );
  }

  /// ========================= NAVBAR =========================

  Widget _buildNavbar(bool mobile) {
    final List<String> navItems = [
      "Home",
      "About",
      "Projects",
      "Skills",
      "Contact",
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Parth.",
          style: TextStyle(
            color: Colors.white,
            fontSize: mobile ? 26.sp : 32.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ).animate().fade().slideX(begin: -0.3),

        if (!mobile)
          Row(
            children: navItems.map((item) {
              return _navItem(
                item,
                isActive: selectedTab == item,
                onTap: () {
                  if (item == "Home") {
                    scrollToSection(homeKey, "Home");
                  } else if (item == "About") {
                    scrollToSection(aboutKey, "About");
                  } else if (item == "Projects") {
                    scrollToSection(projectsKey, "Projects");
                  } else if (item == "Skills") {
                    scrollToSection(skillsKey, "Skills");
                  } else if (item == "Contact") {
                    scrollToSection(contactKey, "Contact");
                  }
                },
              );
            }).toList(),
          )
        else
          PopupMenuButton<String>(
            color: const Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            onSelected: (value) {
              if (value == "Home") {
                scrollToSection(homeKey, "Home");
              } else if (value == "About") {
                scrollToSection(aboutKey, "About");
              } else if (value == "Projects") {
                scrollToSection(projectsKey, "Projects");
              } else if (value == "Skills") {
                scrollToSection(skillsKey, "Skills");
              } else if (value == "Contact") {
                scrollToSection(contactKey, "Contact");
              }
            },
            itemBuilder: (context) {
              return navItems.map((item) {
                return _popupItem(item, isActive: selectedTab == item);
              }).toList();
            },
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: const Icon(Icons.menu_rounded, color: Colors.white),
            ),
          ).animate().fade().slideX(begin: 0.3),
      ],
    );
  }

  PopupMenuItem<String> _popupItem(String title, {required bool isActive}) {
    return PopupMenuItem<String>(
      value: title,
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.deepPurpleAccent : Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _navItem(
    String title, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.deepPurpleAccent.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isActive ? Colors.deepPurpleAccent : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.deepPurpleAccent : Colors.white70,
            fontSize: 15.sp,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// ========================= LEFT SECTION =========================

  Widget _buildLeftSection(bool mobile) {
    return Column(
      crossAxisAlignment: mobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Text(
            "Welcome to my portfolio",
            style: TextStyle(
              color: Colors.white70,
              fontSize: mobile ? 13.sp : 14.sp,
            ),
          ),
        ).animate().fade().slideY(begin: -0.4),

        SizedBox(height: 30.h),

        Text(
          "Hi, I'm",
          textAlign: mobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: Colors.white70,
            fontSize: mobile ? 22.sp : 28.sp,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fade(delay: 200.ms),

        SizedBox(height: 8.h),

        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [Color(0xff60a5fa), Color(0xffa78bfa)],
            ).createShader(bounds);
          },
          child: Text(
            "Parth Kanjariya",
            textAlign: mobile ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              height: 1.1,
              fontSize: mobile ? 42.sp : 72.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).animate().fade(delay: 300.ms).slideX(begin: -0.2),

        SizedBox(height: 24.h),

        SizedBox(
          height: 45.h,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: mobile ? 22.sp : 30.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff60a5fa),
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: titles
                  .map(
                    (e) => TypewriterAnimatedText(
                      e,
                      speed: const Duration(milliseconds: 90),
                    ),
                  )
                  .toList(),
            ),
          ),
        ).animate().fade(delay: 500.ms),

        SizedBox(height: 28.h),

        SizedBox(
          width: mobile ? double.infinity : 580.w,
          child: Text(
            "I build modern, fast and beautiful Flutter applications with stunning UI/UX experiences for mobile and web platforms.",
            textAlign: mobile ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              color: Colors.white60,
              fontSize: mobile ? 15.sp : 17.sp,
              height: 1.8,
            ),
          ),
        ).animate().fade(delay: 700.ms),

        SizedBox(height: 40.h),

        Wrap(
          alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 20.w,
          runSpacing: 20.h,
          children: [
            _primaryButton(() => scrollToSection(contactKey, "Contact")),
            _secondaryButton(() {
              // downloadResume();
            }),
          ],
        ).animate().fade(delay: 900.ms).slideY(begin: 0.2),
      ],
    );
  }

  /// ========================= RIGHT SECTION =========================

  Widget _buildRightSection(bool mobile) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: Tween<double>(begin: 0, end: 1).animate(_controller),
            child: Container(
              width: mobile ? 260.w : 430.w,
              height: mobile ? 260.w : 430.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.purple.withOpacity(0.5),
                    Colors.blue.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: mobile ? 220.w : 380.w,
            height: mobile ? 220.w : 380.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.18),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fade().scale(
            duration: 1000.ms,
            curve: Curves.easeOutBack,
          ),
        ],
      ),
    );
  }

  /// ========================= BUTTONS =========================

  Widget _primaryButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            colors: [Color(0xff3b82f6), Color(0xff8b5cf6)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          "Hire Me",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _secondaryButton(VoidCallback onTap) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 18.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Text(
        "Download Resume",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// ========================= SOCIAL ICON =========================

  Widget _socialIcon(IconData icon) {
    return Container(
      width: 55.w,
      height: 55.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.06),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Icon(icon, color: Colors.white, size: 24.sp),
    );
  }

  /// ========================= BLUR CIRCLE =========================

  Widget _circle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
