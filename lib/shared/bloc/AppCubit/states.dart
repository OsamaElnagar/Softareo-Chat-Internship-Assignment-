abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetAllUsersDataLoadingState extends AppStates {}

class AppGetAllUsersDataSuccessState extends AppStates {}

class AppGetAllUsersDataErrorState extends AppStates {
  final String error;

  AppGetAllUsersDataErrorState(this.error);
}

class AppGetGalleryImageSuccessState extends AppStates {}

class AppGetGalleryImageErrorState extends AppStates {}

class AppGetCameraImageSuccessState extends AppStates {}

class AppGetCameraImageErrorState extends AppStates {}


class AppUndoGetMessageImageSuccessState extends AppStates {}


class AppSignOutErrorState extends AppStates {
  final String error;

  AppSignOutErrorState(this.error);
}




class AppWannaSearchSuccessState extends AppStates {}

class AppWannaSearchErrorState extends AppStates {
  final String error;

  AppWannaSearchErrorState(this.error);
}

class AppSendMessageLoadingState extends AppStates {}

class AppSendMessageSuccessState extends AppStates {}

class AppSendMessageErrorState extends AppStates {
  final String error;

  AppSendMessageErrorState(this.error);
}

class AppSendMessageWithImageLoadingState extends AppStates {}

class AppSendMessageWithImageSuccessState extends AppStates {}

class AppSendMessageWithImageErrorState extends AppStates {
  final String error;

  AppSendMessageWithImageErrorState(this.error);
}

class AppGetMessageSuccessState extends AppStates {}

class AppGetMessageErrorState extends AppStates {
  final String error;

  AppGetMessageErrorState(this.error);
}

class AppSearchForUserLoadingState extends AppStates {}

class AppSearchForUserSuccessState extends AppStates {}

class AppSearchForUserErrorState extends AppStates {
  final String error;

  AppSearchForUserErrorState(this.error);
}



class AppCIState extends AppStates {}
class SplashAssetsState extends AppStates {}
class SplashAssetsErrorState extends AppStates {
  final String error;

  SplashAssetsErrorState(this.error);
}

class AppGetUserDataLoadingState extends AppStates {}

class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {
  final String error;

  AppGetUserDataErrorState(this.error);
}
