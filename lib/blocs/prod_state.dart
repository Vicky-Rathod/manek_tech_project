import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class InitProductState extends ProductState {
  final int counter;

  const InitProductState(this.counter);

  @override
  List<Object> get props => [counter];
}

class AddProductState extends ProductState {}

class RemoveProductState extends ProductState {}
