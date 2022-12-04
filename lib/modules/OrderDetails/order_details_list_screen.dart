import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/OrderDetails/order_details_screen.dart';
import 'package:neem/modules/OrderDetails/order_list_cubit.dart';
import 'package:neem/modules/OrderDetails/order_list_states.dart';

import '../../models/order_model.dart';

class OrderDetailsListScreen extends StatelessWidget {
  const OrderDetailsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderListCubit(),
      child: Scaffold(
        appBar: mainAppBar(context),
        body: BlocConsumer<OrderListCubit, OrderListStates>(
            listener: (context, state) {},
            builder: (context, state) {
              OrderListCubit cubit = OrderListCubit.get(context);
              List<OrderModel> orderModels = cubit.orderModels;
              return Center(
                  child: ListView.builder(
                      itemCount: orderModels.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderDetails(
                                  orderModel: orderModels[index],
                                ),
                              ),
                            );
                          },
                          title: Text("Order#${orderModels[index].id}"),
                          subtitle:
                              Text("Status: ${orderModels[index].orderState}"),
                          trailing: Text(
                              "Total: ${orderModels[index].total.toStringAsFixed(2)}"),
                        );
                      }));
            }),
      ),
    );
  }
}
