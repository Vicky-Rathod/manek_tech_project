import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manek_tech_project/blocs/db_bloc.dart';
import 'package:manek_tech_project/blocs/db_state.dart';
import 'package:manek_tech_project/blocs/prod_bloc.dart';
import 'package:manek_tech_project/blocs/prod_state.dart';

import '../utils/utils.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
  }

  final ScreenUtils _getsize = ScreenUtils();

  @override
  Widget build(BuildContext context) {
    _getsize.setValue(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff6493FF),
        title: const Text("Shopping Mall"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadDatabaseState) {
            return BlocConsumer<ProductBloc, ProductState>(
              listener: (context, getState) {},
              builder: (context, getState) {
                if (getState is InitProductState) {
                  final products =
                      BlocProvider.of<ProductBloc>(context).products;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2),
                      itemBuilder: (contexts, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5)),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FadeInImage(
                                image: NetworkImage(
                                  products[index].featuredImage!,
                                ),
                                width: _getsize.width * 0.2,
                                placeholder:
                                    AssetImage('assets/images/default.png'),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          products[index].title!,
                                          style: TextStyle(
                                            fontSize:
                                                _getsize.resposiveConst * 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            showSnackBarGreen(
                                                'Item has been Added', context);
                                            BlocProvider.of<ProductBloc>(
                                                    context)
                                                .addProductToCart(
                                              products[index].id!,
                                              products[index].slug!,
                                              products[index].createdAt!,
                                              products[index].description!,
                                              products[index].featuredImage!,
                                              products[index].price!,
                                              products[index].status!,
                                              products[index].title!,
                                            );
                                          },
                                          child:
                                              const Icon(Icons.shopping_cart))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                return Container();
              },
            );
          }

          return const Center(
            child: Text('Database not loaded'),
          );
        },
      ),
    );
  }
}
