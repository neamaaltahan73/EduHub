
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/cart_repository.dart';
import '../../models/course_model.dart';

part  'cart_event.dart';
part  'cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(const CartLoading()) {
    
    on<LoadCart>((event, emit) async {
      final courses = await cartRepository.getCartCourses();
      final ids = cartRepository.getCartIds();
      emit(CartLoaded(cartIds: ids, cartCourses: courses));
    });

    on<AddToCartRequested>((event, emit) async {
      await cartRepository.addToCart(event.courseId);
      final courses = await cartRepository.getCartCourses();
      final ids = cartRepository.getCartIds();
      emit(CartLoaded(cartIds: ids, cartCourses: courses));
    });

  
    on<RemoveFromCartRequested>((event, emit) async {
      await cartRepository.removeFromCart(event.courseId);
      final courses = await cartRepository.getCartCourses();
      final ids = cartRepository.getCartIds();
      emit(CartLoaded(cartIds: ids, cartCourses: courses));
    });
  }
}