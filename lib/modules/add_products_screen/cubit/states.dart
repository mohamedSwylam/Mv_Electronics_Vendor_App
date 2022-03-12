abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class GetFormDataSuccessState extends AddProductStates {}

class OnCategoryNameChangeSuccessState extends AddProductStates {}

class OnTaxStatusChangeSuccessState extends AddProductStates {}

class OnTaxAmountChangeSuccessState extends AddProductStates {}

class ManageInventoryChangeSuccessState extends AddProductStates {}

class ChargeShippingChangeSuccessState extends AddProductStates {}

class AddSizeSuccessState extends AddProductStates {}

class RemoveSizeSuccessState extends AddProductStates {}

class OnChangeSizeSuccessState extends AddProductStates {}

class ChangedropDownUnitButtonChange extends AddProductStates {}

class DoSetStateSuccessState extends AddProductStates {}

class GetCategoriesLoadingStates extends AddProductStates {}

class GetCategoriesSuccessState extends AddProductStates {}

class GetCategoriesErrorStates extends AddProductStates {
  final String error;

  GetCategoriesErrorStates(this.error);
}
