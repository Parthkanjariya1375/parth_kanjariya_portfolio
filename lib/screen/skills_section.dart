import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

  bool isMobile(BuildContext context) {
    return ResponsiveBreakpoints.of(context).smallerThan(TABLET);
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    final skills = [
      {
        'title': 'Flutter Development',
        'description': 'Building high-performance cross-platform applications with modern UI/UX.',
        'icon': Icons.flutter_dash_rounded,
      },
      {
        'title': 'Backend Integration',
        'description': 'Working with REST APIs, Firebase, authentication, and real-time services.',
        'icon': Icons.cloud_sync_rounded,
      },
      {
        'title': 'Clean Architecture',
        'description': 'Scalable and maintainable project structures using best practices.',
        'icon': Icons.architecture_rounded,
      },
      {
        'title': 'UI / UX Design',
        'description': 'Creating smooth, modern, and responsive user experiences.',
        'icon': Icons.design_services_rounded,
      },
      {
        'title': 'State Management',
        'description': 'Managing app complexity with scalable and organized approaches.',
        'icon': Icons.hub_rounded,
      },
      {
        'title': 'Database & Storage',
        'description': 'Experience with Firebase, SQLite, local caching, and data handling.',
        'icon': Icons.storage_rounded,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 80, vertical: mobile ? 70 : 100),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff0B1120), Color(0xff111827)],
        ),
      ),
      child: Stack(
        children: [
          /// BACKGROUND BLUR CIRCLES
          Positioned(
            top: 0,
            left: -100,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.cyanAccent.withOpacity(0.08)),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: Container(
              height: 260,
              width: 260,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent.withOpacity(0.08)),
            ),
          ),

          Column(
            children: [
              /// HEADING
              Column(
                children: [
                  Text(
                    'WHAT I DO',
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: mobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                  const SizedBox(height: 18),
                  Text(
                    'Skills & Expertise',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: mobile ? 32 : 48,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ).animate().fadeIn(delay: 150.ms, duration: 700.ms).slideY(begin: 0.2),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      'Focused on creating scalable mobile applications with clean architecture, modern design, and seamless performance.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: mobile ? 15 : 17,
                        height: 1.8,
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms, duration: 700.ms),
                ],
              ),
              SizedBox(height: mobile ? 50 : 70),

              /// SKILLS GRID
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: skills.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: mobile ? 1 : 3,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: mobile ? 1.25 : 1.05,
                ),
                itemBuilder: (context, index) {
                  final skill = skills[index];

                  return _SkillCard(
                        title: skill['title'] as String,
                        description: skill['description'] as String,
                        icon: skill['icon'] as IconData,
                      )
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 120 * index),
                        duration: 700.ms,
                      )
                      .slideY(begin: 0.2);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const _SkillCard({required this.title, required this.description, required this.icon});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final mobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(mobile ? 22 : 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isHovering ? Colors.cyanAccent.withOpacity(0.35) : Colors.white.withOpacity(0.06),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white.withOpacity(isHovering ? 0.08 : 0.04), Colors.white.withOpacity(0.02)],
          ),
          boxShadow: [
            BoxShadow(
              color: isHovering ? Colors.cyanAccent.withOpacity(0.12) : Colors.black.withOpacity(0.15),
              blurRadius: 25,
              spreadRadius: 1,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: mobile ? 65 : 75,
              width: mobile ? 65 : 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: [Colors.cyanAccent.withOpacity(0.18), Colors.blueAccent.withOpacity(0.12)],
                ),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.25)),
              ),
              child: Icon(widget.icon, color: Colors.cyanAccent, size: mobile ? 34 : 38),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mobile ? 22 : 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.72),
                    fontSize: mobile ? 14 : 15,
                    height: 1.7,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  'Explore More',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: mobile ? 14 : 15,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(isHovering ? 6 : 0, 0, 0),
                  child: const Icon(Icons.arrow_forward_rounded, color: Colors.cyanAccent, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
