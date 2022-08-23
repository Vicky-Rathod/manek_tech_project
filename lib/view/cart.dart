import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manek_tech_project/blocs/prod_bloc.dart';
import 'package:manek_tech_project/blocs/prod_state.dart';

import '../utils/utils.dart';

class CartLists extends StatefulWidget {
  const CartLists({
    Key? key,
  }) : super(key: key);

  @override
  State<CartLists> createState() => _CartListsState();
}

class _CartListsState extends State<CartLists> {
  @override
  void initState() {
    super.initState();
  }

  final ScreenUtils _getsize = ScreenUtils();

  gTotal(List products) {
    num? total = 0;
    for (var element in products) {
      total = total! + element.price;
    }
    return total;
  }

  gUnitTotal(List products) {
    num? total = 0;
    for (var element in products) {
      total = total! + element.unit;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    _getsize.setValue(
        context); //initalizing the mediaquery once in the app to reuse them over al the app
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {},
      builder: (context, getState) {
        if (getState is InitProductState) {
          final all_product = BlocProvider.of<ProductBloc>(context).cart;
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Color(0xff6493FF),
              title: const Text("Your Cart"),
            ),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 25),
                color: Color(0xff6493FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Total Items : ${gUnitTotal(all_product)}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    Text('Grand Total : ${gTotal(all_product)}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView.builder(
                itemCount: all_product.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey.shade200,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FadeInImage(
                            image: NetworkImage(
                              all_product[index].featuredImage!,
                            ),
                            width: _getsize.width * 0.2,
                            placeholder:
                                AssetImage('assets/images/default.png'),
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Name: ',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${all_product[index].title!}\n',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Unit: ',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${all_product[index].unit}\n',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Price: ' r"$",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${all_product[index].price!}\n',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                  //   Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(16)),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Image.network(
                  //         products[index].featuredImage!,
                  //         width: _getsize.width * 0.17,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 products[index].title!,
                  //                 style: TextStyle(
                  //                   fontSize: _getsize.resposiveConst * 16,
                  //                 ),
                  //                 overflow: TextOverflow.ellipsis,
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //                 onTap: () {
                  //                   showSnackBarRed(
                  //                       'Item has been Removed', context);
                  //                   BlocProvider.of<ProductBloc>(context)
                  //                       .deleteProductFromCart(
                  //                     products[index].id!,
                  //                   );
                  //                 },
                  //                 child: const Icon(Icons.delete))
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
