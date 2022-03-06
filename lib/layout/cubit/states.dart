abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetVendorLoadingStates extends AppStates {}

class GetVendorSuccessStates extends AppStates {}

class GetVendorErrorStates extends AppStates {
  final String error;

  GetVendorErrorStates(this.error);
}
