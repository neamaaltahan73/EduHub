part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
}

class AddToCartRequested extends CartEvent {
  final int courseId;

  const AddToCartRequested(this.courseId);

  @override
  List<Object?> get props => [courseId];
}

class RemoveFromCartRequested extends CartEvent {
  final int courseId;

  const RemoveFromCartRequested(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
