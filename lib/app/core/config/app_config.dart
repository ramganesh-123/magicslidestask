class AppConstants {
  static const String supabaseUrl = 'https://trtnmfidylmnxvspsjqi.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRydG5tZmlkeWxtbnh2c3BzanFpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzNjgzOTUsImV4cCI6MjA3OTk0NDM5NX0.ETPyAKNRilDDnE9dT8oIdU5xkyr05Tndkfm9IOIHGoE';

  static const String magicSlidesApiUrl =
      'https://api.magicslides.app/public/api/ppt_from_topic';
  static const String magicSlidesAccessId =
      '1f95df31-357f-47f9-b61c-6dcacc54e346';

  static const String appName = 'MagicSlides';
  static const int defaultSlideCount = 10;
  static const String defaultLanguage = 'en';
  static const String defaultTemplate = 'bullet-point1';
  static const String defaultModel = 'gpt-4';

  static const String themeKey = 'theme_mode';
  static const String userKey = 'user_data';
}

class AppStrings {
  static const String appTitle = 'MagicSlides Generator';
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String enterTopic = 'Enter your topic...';
  static const String generate = 'Generate Presentation';
  static const String download = 'Download';
  static const String logout = 'Logout';

  // Error Messages
  static const String emptyTopic = 'Please enter a topic';
  static const String noInternet = 'No internet connection';
  static const String apiError = 'Failed to generate presentation';
  static const String invalidEmail = 'Please enter a valid email';
  static const String weakPassword = 'Password must be at least 6 characters';
}

class TemplateList {
  static const List<String> editableTemplates = [
    'ed-bullet-point9',
    'ed-bullet-point7',
    'ed-bullet-point6',
    'ed-bullet-point5',
    'ed-bullet-point2',
    'ed-bullet-point4',
    'custom gold 1',
    'custom Dark 1',
    'custom sync 1',
    'custom sync 2',
    'custom sync 3',
    'custom sync 4',
    'custom sync 5',
    'custom sync 6',
    'custom-ed-7',
    'custom-ed-8',
    'custom-ed-9',
    'custom-ed-10',
    'custom-ed-11',
    'custom-ed-12',
    'pitchdeckorignal',
    'pitch-deck-2',
    'pitch-deck-3',
    'ed-bullet-point1',
  ];

  static const List<String> defaultTemplates = [
    'bullet-point1',
    'bullet-point2',
    'bullet-point4',
    'bullet-point5',
    'bullet-point6',
    'bullet-point7',
    'bullet-point8',
    'bullet-point9',
    'bullet-point10',
    'custom2',
    'custom3',
    'custom4',
    'custom5',
    'custom6',
    'custom7',
    'custom8',
    'custom9',
    'verticalBulletPoint1',
    'verticalCustom1',
  ];
}

class PresentationAudience {
  static const List<String> audiences = [
    'student',
    'teacher',
    'business',
    'healthcare professionals',
    'general audience',
    'technical audience',
    'sales team',
    'marketing team',
  ];
}

class ModelOptions {
  static const String gpt4 = 'gpt-4';
  static const String gpt35 = 'gpt-3.5';

  static const List<String> models = [gpt4, gpt35];
}
