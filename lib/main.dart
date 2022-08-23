import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manek_tech_project/blocs/db_bloc.dart';
import 'package:manek_tech_project/blocs/prod_bloc.dart';
import 'package:manek_tech_project/routes/routes.dart';
import 'package:manek_tech_project/view/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseBloc>(
            create: (context) => DatabaseBloc()..initDatabase()),
        BlocProvider<ProductBloc>(
            create: (context) =>
                ProductBloc(database: context.read<DatabaseBloc>().database!)
                  ..getProducts()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const Products(),
        routes: routes,
      ),
    );
  }
}
