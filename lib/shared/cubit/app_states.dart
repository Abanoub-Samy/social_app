abstract class AppStates {}

class InitialState extends AppStates {}

class AppChangeMode extends AppStates {}
class NewPostsState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

class LoginLoadingState extends AppStates {}

class LoginSuccessState extends AppStates {
  final String uId ;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends AppStates {
  final String error;

  LoginErrorState(this.error);
}

class RegisterState extends AppStates {}

class HomeLoadingState extends AppStates {}

class HomeSuccessState extends AppStates {}

class HomeErrorState extends AppStates {
  final String error;

  HomeErrorState(this.error);
}



class RegisterLoadingState extends AppStates {}

class RegisterSuccessState extends AppStates {}

class RegisterErrorState extends AppStates {
  final String error;

  RegisterErrorState(this.error);
}

class CreateUserLoadingState extends AppStates {}

class CreateUserSuccessState extends AppStates {}

class CreateUserErrorState extends AppStates {
  final String error;

  CreateUserErrorState(this.error);
}

class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {
  final String error;

  GetUserErrorState(this.error);
}

class UpdateUserLoadingState extends AppStates {}

class UpdateUserSuccessState extends AppStates {}

class UpdateUserErrorState extends AppStates {
  final String error;

  UpdateUserErrorState(this.error);
}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {
  final String error;

  CreatePostErrorState(this.error);
}


class GetPostsLoadingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {
  final String error;

  GetPostsErrorState(this.error);
}

class PostLikeLoadingState extends AppStates {}

class PostLikeSuccessState extends AppStates {}

class PostLikeErrorState extends AppStates {
  final String error;

  PostLikeErrorState(this.error);
}

class PostCommentLoadingState extends AppStates {}

class PostCommentSuccessState extends AppStates {}

class PostCommentErrorState extends AppStates {
  final String error;

  PostCommentErrorState(this.error);
}