import 'package:bookido/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookido/auth/bookido_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterScreenState();
}

class _RegisterData {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
}

class _RegisterScreenState extends State<RegisterScreen> {
  // used to validate form
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final bookidoAuth = new BookidoAuth();

  _RegisterData _data = new _RegisterData();

  void onSignUpSubmit(BuildContext context) async {
    var appModel = ScopedModel.of<AppModel>(context);
    
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        var user = await bookidoAuth.registerUserWithEmail(
          _data.email,
          _data.password,
          _data.name
        );

        if (user != null) {
          appModel.setUser(user);
          print('Email: ${user.email}');
          print('Name: ${user.displayName}');
          print('Uid: ${user.uid}');
          // navigate to the photo screen
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // TODO: Show dialog with auth error
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'A senha precisa ter no mínimo 8 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: new Form(
              key: this._formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nova Conta',
                      style: Theme.of(context).textTheme.display4),
                  SizedBox(height: 24),
                  new TextFormField(
                      decoration: new InputDecoration(hintText: 'Nome'),
                      onSaved: (String value) {
                        this._data.name = value;
                      }),
                  SizedBox(height: 12),
                  new TextFormField(
                      decoration: new InputDecoration(hintText: 'Email'),
                      onSaved: (String value) {
                        this._data.email = value;
                      }),
                  SizedBox(height: 12),
                  new TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(hintText: 'Senha'),
                      validator: this._validatePassword,
                      onSaved: (String value) {
                        this._data.password = value;
                      }),
                  SizedBox(height: 12),
                  new TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(hintText: 'Confirme a Senha'),
                      validator: this._validatePassword,
                      onSaved: (String value) {
                        this._data.confirmPassword = value;
                      }),
                  SizedBox(height: 24),
                  FlatButton(
                    // Here we call the method above. We need to provide
                    // `context` because that's how ScopedModel.of() reaches
                    // the model.
                    onPressed: () => onSignUpSubmit(context),
                    color: Colors.blue,
                    child: Text(
                      'Criar conta',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
