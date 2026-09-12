part of 'cart_bloc.dart';


abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<int> cartIds;
  final List<CourseModel> cartCourses;

  const CartLoaded({required this.cartIds, required this.cartCourses});

  bool isInCart(int courseId) => cartIds.contains(courseId);

  double get subtotal =>
      cartCourses.fold(0, (sum, course) => sum + course.price);

  @override
  List<Object?> get props => [cartIds, cartCourses];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
