class WelcomeModel {
  // Fields to store welcome screen information
  // URL for an image or background
  final String? welcomeUrl;
  // Title text for the welcome screen
  final String? welcomeTitle;
  // Subtitle text for the welcome screen
  final String? welcomeSubtitle; // Subtitle text for the welcome screen

  // Constructor to initialize the WelcomeModel with required information
  WelcomeModel({
    // Required URL for the welcome screen
    required this.welcomeUrl,
    // Required title text for the welcome screen
    required this.welcomeTitle,
    // Required subtitle text for the welcome screen
    required this.welcomeSubtitle,
  });
}
