import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final _authInstance = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? user;

  //  CREATE NEW USER
  Future<User?> createUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _authInstance
        .createUserWithEmailAndPassword(email: email, password: password);

    user = userCredential.user;

    FirestoreUserService _firestoreUserService =
        FirestoreUserService(user: user);

    await _firestoreUserService.createUser();

    return user;
  }

  //  LOGIN EXISTING USER
  Future<User?> signupWithEmailPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _authInstance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  // LOGIN USING GOOGLE
  Future<User?> googleSignIn() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return null;
    }
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential userCredential =
        await _authInstance.signInWithCredential(authCredential);

    user = userCredential.user;
    FirestoreUserService userService = FirestoreUserService(user: user);
    await userService.createUser();

    return user;
  }

  Future<void> signOut() async {
    await _authInstance.signOut();
    await _googleSignIn.signOut();
  }

  Stream<User?> get userStream {
    return _authInstance.authStateChanges();
  }
}
