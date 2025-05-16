sealed class CartEvent {}

class GetCartDetailsEvent extends CartEvent {
  final String userId;

  GetCartDetailsEvent({required this.userId});
}