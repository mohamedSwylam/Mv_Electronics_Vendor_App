
abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class GetFormDataSuccessState extends AddProductStates {}

class GetCategoriesLoadingStates extends AddProductStates {}

class GetCategoriesSuccessState extends AddProductStates {}

class GetCategoriesErrorStates extends AddProductStates {
  final String error;

  GetCategoriesErrorStates(this.error);
}
