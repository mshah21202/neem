abstract class ForgotPasswordStates {}

class InitialForgotPasswordState extends ForgotPasswordStates {}

class RequestPinCodeState extends ForgotPasswordStates {}

class ConfirmPinCodeState extends ForgotPasswordStates {}

class ChangePasswordState extends ForgotPasswordStates {}

class PasswordChangedState extends ForgotPasswordStates {}

class ErrorForgotPasswordState extends ForgotPasswordStates {}
