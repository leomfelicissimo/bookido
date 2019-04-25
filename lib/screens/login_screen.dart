import 'package:bookido/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  void onLoginSubmit(BuildContext context) {
    var state = ScopedModel.of<AppModel>(context);

    // navigate to the photo screen
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bem vindo', style: Theme.of(context).textTheme.display4),
              SizedBox(height: 24),
              _LoginTextField(hintText: 'Usuário'),
              SizedBox(height: 12),
              _LoginTextField(hintText: 'Senha', obscureText: true),
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
        ),
      ),
    );
  }
}

/// Convenience widget for the login text fields.
class _LoginTextField extends StatelessWidget {
  final String hintText;

  final bool obscureText;

  _LoginTextField({
    Key key,
    @required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.black12,
      ),
      obscureText: obscureText,
    );
  }
}
