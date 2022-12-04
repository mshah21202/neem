abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class RequestLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {}

class LogOutState extends LoginStates {}

class ErrorLoginState extends LoginStates {}

class UserNotFoundState extends LoginStates {}

class WrongPasswordState extends LoginStates {}
