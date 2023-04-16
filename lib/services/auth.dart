import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/FirebaseUser.dart';
import '../models/loginuser.dart';

class AuthService with ChangeNotifier {
  late String _token;
  late DateTime _expireDate;
  late String _userId;
  static const _apiKey = 'AIzaSyBP2gCBeJtC02dP94Kiqh1__QXtPF0waJA';
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user object base on Firebase User
  FirebaseUser? _firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

//sign in ano
  Future signInAnonymous() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _firebaseUser(user);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  //sign in email and address
  Future signInEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  //register with email and password
  Future registerEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

//   Future<http.Response> _authenticate(
//       String email, String password, String urlSegment) async {
//     final url = Uri.parse(
//         'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_apiKey');
//     final response = await http.post(
//       url,
//       body: json.encode(
//         {
//           'email': "a@gmail.com",
//           'password': "12345678",
//           'returnSecureToken': true,
//         },
//         // {
//         //   'email': email,
//         //   'password': password,
//         //   'returnSecureToken': true,
//         // },
//       ),
//     );

//     final responseData = json.decode(response.body);
//     if (responseData['error'] != null) {
//       throw HttpException(responseData['error']['message']);
//     }

//     _token = responseData['idToken'];
//     _userId = responseData['localId'];
//     _expireDate = DateTime.now().add(
//       Duration(
//         seconds: int.parse(
//           responseData['expiresIn'],
//         ),
//       ),
//     );
//     notifyListeners();
//     return response;
//   }

//   Future<void> signup(
//       String name, String email, String password, String phone) async {
//     await _authenticate(email, password, 'signUp');
//   }

//   Future<void> login(String email, String password) async {
//     await _authenticate(email, password, 'signInWithPassword');
//   }

//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (e) {
//       return null;
//     }
//   }

//   String getToken() {
//     return _token;
//   }
// }
