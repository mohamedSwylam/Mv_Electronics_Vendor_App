abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class GetFormDataSuccessState extends AddProductStates {}

class OnCategoryNameChangeSuccessState extends AddProductStates {}

class OnTaxStatusChangeSuccessState extends AddProductStates {}

class OnTaxAmountChangeSuccessState extends AddProductStates {}

class ManageInventoryChangeSuccessState extends AddProductStates {}

class ChargeShippingChangeSuccessState extends AddProductStates {}

class DoSetStateSuccessState extends AddProductStates {}

class GetCategoriesLoadingStates extends AddProductStates {}

class GetCategoriesSuccessState extends AddProductStates {}

class GetCategoriesErrorStates extends AddProductStates {
  final String error;

  GetCategoriesErrorStates(this.error);
}
