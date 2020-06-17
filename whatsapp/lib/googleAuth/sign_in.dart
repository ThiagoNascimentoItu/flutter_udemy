import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();


Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.email);
  print("Nome " + user.displayName);
  print("UserId " + user.uid);
  return user;
}

// Future<String> signInWithGoogle() async {
//   final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleSignInAuthentication.idToken,
//       idToken: googleSignInAuthentication.accessToken);
//       print('credential'+ credential.providerId);

//   final AuthResult authResult = await _auth.signInWithCredential(credential);
//   final FirebaseUser user = authResult.user;
//   print('authgoogle' + authResult.user.toString());
//   print("FireBase" + user.toString());
//   assert(!user.isAnonymous);
//   assert(await user.getIdToken() != null);

//   final FirebaseUser currentUser = await _auth.currentUser();
//   assert(user.uid == currentUser.uid);

//   return 'signInWhitGoogle suceeded: $user';
// }

void signOutGoogle() async {
  await _googleSignIn.signOut();
  print("User Sign Out");
}
