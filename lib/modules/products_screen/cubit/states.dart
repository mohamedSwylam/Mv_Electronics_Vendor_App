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

class PickedImageSuccessState extends AddProductStates {}

class PickedImageErrorState extends AddProductStates {
  final String error;

  PickedImageErrorState(this.error);
}

class SaveImageToDbSuccessState extends AddProductStates {}

class SaveImageToDbErrorState extends AddProductStates {
  final String error;

  SaveImageToDbErrorState(this.error);
}

class RemoveImageSuccessState extends AddProductStates {}

class UploadProductSuccessState extends AddProductStates {}
