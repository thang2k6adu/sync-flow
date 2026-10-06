
class ApiEndpoints {
  ApiEndpoints._();

  static const String authRegister = '/auth/register';
  static const String authFirebaseLogin = '/auth/firebase/login';
  static const String authRefresh = '/auth/refresh';
  static const String authLogout = '/auth/logout';


  static const String userProfile = '/users/profile';
  static String getUserById(String userId) => '/users/$userId';

  static const String tasks = '/tasks';
  static String getTaskById(String taskId) => '/tasks/$taskId';

  static const String decks = '/decks';
  static String getDeckById(String deckId) => '/decks/$deckId';

  static const String cards = '/cards';
  static String getCardById(String cardId) => '/cards/$cardId';

  static const String studyQueue = '/study/queue';
  static const String studySubmit = '/study/submit';

  static const String healthCheck = '/health';
  
  static const String versionCheck = '/version';
}
