import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class UtilFuncs {
  static String getUUID() => (const Uuid()).v4();
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future logOut() {
    return _googleSignIn.signOut();
  }

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}
