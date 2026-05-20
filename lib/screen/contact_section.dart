import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool isLoading = false;

  bool isMobile(BuildContext context) {
    return ResponsiveBreakpoints.of(context).smallerThan(TABLET);
  }

  Future<void> sendEmail() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'kanjariyaparth967@gmail.com',
      query:
      'subject=Portfolio Contact From $name&body=Name: $name\nEmail: $email\n\n$message',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email app opened successfully'),
            ),
          );
        }

        nameController.clear();
        emailController.clear();
        messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 20 : 80,
        vertical: mobile ? 70 : 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0B1120),
            Color(0xff111827),
          ],
        ),
      ),
      child: Stack(
        children: [
          /// BACKGROUND EFFECTS
          Positioned(
            top: -80,
            right: -50,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -70,
            child: Container(
              height: 260,
              width: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.08),
              ),
            ),
          ),

          Column(
            children: [
              /// HEADER
              Column(
                children: [
                  Text(
                    'CONTACT',
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600,
                      fontSize: mobile ? 14 : 16,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2),
                  const SizedBox(height: 18),
                  Text(
                    'Let’s Work Together',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: mobile ? 34 : 52,
                      height: 1.2,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 150.ms, duration: 700.ms)
                      .slideY(begin: 0.2),
                  const SizedBox(height: 18),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      'Have a project idea, freelance work, or collaboration in mind? Feel free to reach out anytime.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: mobile ? 15 : 17,
                        height: 1.8,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 700.ms),
                ],
              ),
              SizedBox(height: mobile ? 50 : 70),

              /// CONTENT
              Flex(
                direction: mobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LEFT INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ContactInfoTile(
                          icon: Icons.email_rounded,
                          title: 'Email',
                          subtitle: 'kanjariyaparth967@gmail.com',
                        ),
                        const SizedBox(height: 24),
                        _ContactInfoTile(
                          icon: Icons.phone_rounded,
                          title: 'Phone',
                          subtitle: '+91 90545 94195',
                        ),
                        const SizedBox(height: 24),
                        _ContactInfoTile(
                          icon: Icons.location_on_rounded,
                          title: 'Location',
                          subtitle: 'Rajkot, Gujarat, India',
                        ),
                        SizedBox(height: mobile ? 40 : 50),

                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            _SocialButton(
                              icon: Icons.code,
                              label: 'GitHub',
                              onTap: () async {
                                final uri = Uri.parse(
                                  'https://github.com/Parthkanjariya1375',
                                );
                                await launchUrl(uri);
                              },
                            ),
                            _SocialButton(
                              icon: Icons.work,
                              label: 'LinkedIn',
                              onTap: () async {
                                final uri = Uri.parse(
                                  'www.linkedin.com/in/parth-kanjariya-693104354',
                                );
                                await launchUrl(uri);
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideX(begin: -0.1),
                  ),

                  SizedBox(
                    width: mobile ? 0 : 50,
                    height: mobile ? 50 : 0,
                  ),

                  /// RIGHT FORM
                  Expanded(
                    flex: mobile ? 0 : 2,
                    child: Container(
                      padding: EdgeInsets.all(mobile ? 24 : 34),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.02),
                          ],
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            _CustomTextField(
                              controller: nameController,
                              hint: 'Your Name',
                              icon: Icons.person_outline_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 22),
                            _CustomTextField(
                              controller: emailController,
                              hint: 'Your Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your email';
                                }

                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );

                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter valid email';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 22),
                            _CustomTextField(
                              controller: messageController,
                              hint: 'Write Your Message',
                              icon: Icons.chat_bubble_outline_rounded,
                              maxLines: 6,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Write your message';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            /// SEND BUTTON
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: isLoading ? null : sendEmail,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.cyanAccent,
                                      Colors.blueAccent,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyanAccent.withOpacity(0.25),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: isLoading
                                      ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                      : const Text(
                                    'Send Message',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 700.ms)
                        .slideX(begin: 0.1),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ContactInfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.cyanAccent.withOpacity(0.18),
                Colors.blueAccent.withOpacity(0.12),
              ],
            ),
            border: Border.all(
              color: Colors.cyanAccent.withOpacity(0.25),
            ),
          ),
          child: Icon(
            icon,
            color: Colors.cyanAccent,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isHovering
                  ? Colors.cyanAccent.withOpacity(0.35)
                  : Colors.white.withOpacity(0.08),
            ),
            color: Colors.white.withOpacity(isHovering ? 0.06 : 0.03),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: Colors.cyanAccent,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _CustomTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\t')),
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.45),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.cyanAccent,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.04),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.cyanAccent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
