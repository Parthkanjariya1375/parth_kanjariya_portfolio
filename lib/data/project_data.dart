import '../models/project_model.dart';

const List<ProjectModel> projects = [
  ProjectModel(
    title: 'E-Commerce App',
    description:
    'A modern ecommerce application with clean architecture, cart system, API integration and authentication',
    image: 'assets/projects/ecommerce.png',
    technologies: [
      'Flutter',
      'Firebase',
      'SQLite',
    ],
    githubUrl: 'https://github.com/',
    liveUrl: 'https://flutter.dev',
  ),
  ProjectModel(
    title: 'Portfolio Website',
    description:
    'A futuristic responsive portfolio website with animations, adaptive layout and beautiful UI/UX.',
    image: 'assets/projects/portfolio.png',
    technologies: [
      'Flutter Web',
      'Responsive UI',
      'Animations',
    ],
    githubUrl: 'https://github.com/',
    liveUrl: 'https://flutter.dev',
  ),
  ProjectModel(
    title: 'Weather Application',
    description:
    '',
    image: 'assets/projects/food.png',
    technologies: [
      'Flutter',
      'REST API',
      'Bloc',
    ],
    githubUrl: 'https://github.com/',
    liveUrl: 'https://flutter.dev',
  ),
];