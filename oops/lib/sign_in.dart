import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oops/Globals.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();

void initializeUserDocument(String number, String profession) {
  Map<String, dynamic> userData = new Map();
  userData["name"] = Globals.auth.currentUser.displayName;
  userData["email"] = Globals.auth.currentUser.email;
  userData["number"]=number;
  userData[profession]=profession;
  Globals.firestore.collection("users").doc(Globals.auth.currentUser.uid).set(userData);
}

Future<String> signInWithGoogle(String number,String profession) async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await Globals.auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = Globals.auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');
    initializeUserDocument(number,profession);
    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}