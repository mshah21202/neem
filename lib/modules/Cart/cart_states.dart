abstract class CartStates {}

class InitialCartState extends CartStates {}

class LoadingCartProductsState extends CartStates {}

class LoadedCartProductsState extends CartStates {}

class DeletedProductState extends CartStates {}

class UpdateQuantityState extends CartStates {}

class CreatingOrderState extends CartStates {}

class CreatedOrderState extends CartStates {}

class ConfirmDeleteProduct extends CartStates {}

class RefreshCartState extends CartStates {}

class ErrorOrderState extends CartStates {}
