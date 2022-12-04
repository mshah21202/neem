abstract class ProductStates {}

class InitialProductState extends ProductStates {}

class LoadingProductState extends ProductStates {}

class LoadedProductState extends ProductStates {}

class IncrementQuantityProductState extends ProductStates {}

class DecrementQuantityProductState extends ProductStates {}

class AddedProductToCartState extends ProductStates {}

class UpdateFavoriteProductState extends ProductStates {}

class ErrorProductState extends ProductStates {}
