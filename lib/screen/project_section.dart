import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/project_data.dart';
import '../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 3;

    if (width < 1200) {
      crossAxisCount = 2;
    }

    if (width < 700) {
      crossAxisCount = 1;
    }

    final bool isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 80.w,
        vertical: isMobile ? 60.0 : 100.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff07111F), Color(0xff0B1627)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Featured Projects',
                  style: TextStyle(
                    fontSize: isMobile ? 32.0 : 50.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fade(duration: 700.ms).slideY(begin: .3),

                SizedBox(height: isMobile ? 16.0 : 16.h),

                Container(
                  width: isMobile ? 60.0 : 100.w,
                  height: isMobile ? 4.0 : 4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: const LinearGradient(
                      colors: [Color(0xff00D1FF), Color(0xff7A5FFF)],
                    ),
                  ),
                ).animate().fade(delay: 300.ms).scale(),

                SizedBox(height: isMobile ? 20.0 : 20.h),

                SizedBox(
                  width: 700.w,
                  child: Text(
                    'A collection of projects focused on scalable architecture, smooth performance and modern UI/UX.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 16.0 : 16.sp,
                      height: 1.7,
                    ),
                  ),
                ).animate().fade(delay: 500.ms).slideY(begin: .2),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 50.0 : 70.h),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: width < 700 ? .78 : .75,
            ),
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index])
                  .animate(delay: Duration(milliseconds: 200 * index))
                  .fade(duration: 700.ms)
                  .slideY(begin: .2);
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0.0, isHover ? -12 : 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isHover
                ? const Color(0xff00D1FF)
                : Colors.white.withOpacity(.08),
          ),
          boxShadow: [
            BoxShadow(
              color: isHover
                  ? const Color(0xff00D1FF).withOpacity(.15)
                  : Colors.black.withOpacity(.2),
              blurRadius: 30,
              spreadRadius: 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(.04)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: isHover ? 1.05 : 1,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.project.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(.7),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 16.0 : 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 22.0 : 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: isMobile ? 8.0 : 14.h),

                          Text(
                            widget.project.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isMobile ? 14.0 : 14.sp,
                              height: 1.7,
                            ),
                          ),

                          SizedBox(height: isMobile ? 12.0 : 20.h),

                          Wrap(
                            spacing: isMobile ? 8.0 : 10.0,
                            runSpacing: isMobile ? 8.0 : 10.0,
                            children: widget.project.technologies
                                .map(
                                  (tech) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 10.0 : 14.w,
                                      vertical: isMobile ? 6.0 : 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(
                                        0xff00D1FF,
                                      ).withOpacity(.12),
                                      border: Border.all(
                                        color: const Color(
                                          0xff00D1FF,
                                        ).withOpacity(.3),
                                      ),
                                    ),
                                    child: Text(
                                      tech,
                                      style: TextStyle(
                                        color: const Color(0xff8BE9FF),
                                        fontSize: isMobile ? 12.0 : 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),

                          const Spacer(),

                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                await launchUrl(
                                  Uri.parse(widget.project.githubUrl),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.white.withOpacity(.2),
                                ),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: isMobile ? 12.0 : 18.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Github',
                                style: TextStyle(
                                  fontSize: isMobile ? 13.0 : 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
