import '../models/project_model.dart';

const List<ProjectModel> projects = [
  ProjectModel(
    title: 'E-Commerce App',
    description:
    'A modern ecommerce application with clean architecture, cart system, API integration and authentication',
    image: 'assets/ecommerce.jpeg',
    technologies: [
      'Flutter',
      'Firebase',
      'SQLite',
    ],
    githubUrl: 'https://github.com/CygnerParthKanjariya/ecommerce_app_flutter',
  ),
  ProjectModel(
    title: 'Portfolio Website',
    description:
    'A futuristic responsive portfolio website with animations, adaptive layout and beautiful UI/UX.',
    image: 'assets/portfolio.png',
    technologies: [
      'Flutter Web',
      'Responsive UI',
      'Animations',
    ],
    githubUrl: 'https://github.com/Parthkanjariya1375/parth_kanjariya_portfolio',
  ),
  ProjectModel(
    title: 'Weather Application',
    description:
    'Dynamically Search the City name for the current weather and forecast',
    image: 'assets/weather.jpeg',
    technologies: [
      'Flutter',
      'REST API',
      'Bloc',
    ],
    githubUrl: 'https://github.com/',
  ),
];