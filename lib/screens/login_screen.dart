import 'package:bookido/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginData {
  String usuario = '';
  String senha = '';
}

class _LoginScreenState extends State<LoginScreen> {
  // used to validate form
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  _LoginData _data = new _LoginData();

  void onLoginSubmit(BuildContext context) {
    var appModel = ScopedModel.of<AppModel>(context);

    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      appModel.setUser(_data.usuario);
      print('Usuario: ${_data.usuario}');
      print('Senha: ${this._data.senha}');
      // navigate to the photo screen
      Navigator.pushReplacementNamed(context, '/home');
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
                  Text('Bem vindo',
                      style: Theme.of(context).textTheme.display4),
                  SizedBox(height: 24),
                  new TextFormField(
                      decoration: new InputDecoration(hintText: 'Usuário'),
                      onSaved: (String value) {
                        this._data.usuario = value;
                      }),
                  SizedBox(height: 12),
                  new TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(hintText: 'Senha'),
                      validator: this._validatePassword,
                      onSaved: (String value) {
                        this._data.senha = value;
                      }),
                  SizedBox(height: 24),
                  FlatButton(
                    // Here we call the method above. We need to provide
                    // `context` because that's how ScopedModel.of() reaches
                    // the model.
                    onPressed: () => onLoginSubmit(context),
                    color: Colors.blue,
                    child: Text(
                      'Login',
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
