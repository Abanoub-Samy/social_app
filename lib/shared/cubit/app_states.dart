abstract class AppStates {}

class InitialState extends AppStates {}

class AppChangeMode extends AppStates {}

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
