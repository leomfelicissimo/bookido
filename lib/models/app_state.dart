import 'package:bookido/common/types.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  bool isLoading = false;
  BookidoUser user;

  // constructor
  AppModel({
    this.isLoading = false,
    this.user,
  });

  // A constructor for when the app is loading.
  factory AppModel.loading() => new AppModel(isLoading: true);

  void setUser(user) {
    this.user = user;
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, user: ${user.email}}';
  }
}
