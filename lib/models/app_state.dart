import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  bool isLoading = false;
  String user = 'Marcio Mendes';

  // constructor
  AppModel({
    this.isLoading = false,
    this.user,
  });

  // A constructor for when the app is loading.
  factory AppModel.loading() => new AppModel(isLoading: true);

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, user: ${user}}';
  }
}
