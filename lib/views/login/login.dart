import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

//TODO(chris): adding comments

/// enum FromMode for clarify the Login and signup form
enum FormMode { LOGIN, SIGNUP }

class Login extends StatefulWidget {
  static const String id = "login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance; //initial constant for firebase

  final _formKey = new GlobalKey<
      FormState>(); //get a key that is unique across the entire app

  String _email;
  String _password;
  String _errorMessage;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return SafeArea(
      child: new Scaffold(
          appBar: new AppBar(
            title: Center(
                child: new Text(
              'Login',
            )),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _showBody(),
            ),
          )),
    );
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  /// Form validation
  ///
  /// Check if form is valid before perform login or signup, learn more about
  /// https://medium.com/flutterpub/sample-form-part-1-flutter-35664d57b0e5
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {
        _isLoading = false;
      });
      return false;
    }
  }

  /// Validate and submit the user to firebase base on what activity
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      try {
        //have to try and catch for error when you use firebase auth
        if (_formMode == FormMode.LOGIN) {
          //sign in user with firebase
          final user = await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          print('Signed in: $user');
          if (user !=
              null) // if user not validate sign in with firebase it will be null
          {
            //Navigate to homepage after sign in
            Navigator.pushNamed(context, Home.id);
          }
        } else {
          //sign up user with firebase
          final user = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);

          FirebaseUser _user =
              await _auth.currentUser(); //get current sign up user
          _user.sendEmailVerification(); //send email verification
          _showVerifyEmailSentDialog(); // show dialog let them know that user will receive email for verification
          
          
          print('Signed up user: $user');
        }

        ///turn off loading circ
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  /// show dialog metion get email verification
  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// switch to signup form
  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  /// switch to signin form
  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  ///body of home page
  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  ///show error message
  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null)

    ///if there is error message then show it
    {
      setState(() {
        _isLoading = false;
      });
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  ///show logo image

  Widget _showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80.0,
          child: Image.asset('assets/images/undraw_Login_v483.png'),
        ),
      ),
    );
  }

  /// show email input feild
  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  ///show password input feild
  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  /// show second button which let user switch to signup or signin form
  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  /// show primamry button which let user login or signup submit
  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}
