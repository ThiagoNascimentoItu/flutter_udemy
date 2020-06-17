import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final _facebookLogin = FacebookLogin();

Future<FirebaseUser> signWithFacebook() async {
  final result = await _facebookLogin.logIn(["email"]);

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      print('SendTokenToServer' + result.accessToken.token);

      final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.toString());

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.email);
      print("Nome " + user.displayName);
      print("UserId " + user.uid);

      break;
    case FacebookLoginStatus.cancelledByUser:
      print('CancelledMessage' + result.toString());
      break;
    case FacebookLoginStatus.error:
      print('Error' + result.errorMessage);
  }

  void signOutFacebook() async {
    await _facebookLogin.logOut();
    print('facebook signOut');
  }
}
