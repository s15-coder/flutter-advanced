import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingIn {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      GoogleSignInAccount? account = await GoogleSingIn._googleSignIn.signIn();
      final googleKey = await account!.authentication;
      print("Id Token:${googleKey.idToken}");
      //Verify idToken is backend service
      return account;
    } catch (e) {
      print('Google sign in error: $e');
      return null;
    }
  }

  static Future signOut() async => await _googleSignIn.signOut();
}
