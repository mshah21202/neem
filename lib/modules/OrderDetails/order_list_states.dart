abstract class OrderListStates {}

class InitialOrderListState extends OrderListStates {}

class LoadingOrdersState extends OrderListStates {}

class LoadedOrdersState extends OrderListStates {}

class ErrorOrdersState extends OrderListStates {}
