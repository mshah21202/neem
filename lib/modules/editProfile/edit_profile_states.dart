abstract class EditProfileStates {}

class InitialProfileState extends EditProfileStates {}

class RequestEditProfile extends EditProfileStates {}

class UpdatedProfileState extends EditProfileStates {}

class ErrorUpdateProfileState extends EditProfileStates {}
