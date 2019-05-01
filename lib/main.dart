import 'package:bookido/app.dart';
import 'package:flutter/material.dart';
import 'package:bookido/models/app_state.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // initialize the model
  final state = new AppModel();

  // run flutter UI
  runApp(
    ScopedModel<AppModel>(
      model: state,
      child: AppRoot()
    ),
  );
  
}
