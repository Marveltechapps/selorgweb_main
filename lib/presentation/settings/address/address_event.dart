abstract class AddressEvent {}

class EditSavedAddressEvent extends AddressEvent {}
class ContinueLocationEvent extends AddressEvent {}
class DeleteSavedAddressEvent extends AddressEvent {
  final String label;
  final String houseNo;
  final String building;
  final String landMark;
  final String area;
  final String city;
  final String state;
  final String pinCode;
  final String latitude;
  final String longitude;
  final String id;

  DeleteSavedAddressEvent(
      {required this.label,
      required this.houseNo,
      required this.building,
      required this.landMark,
      required this.area,
      required this.city,
      required this.state,
      required this.pinCode,
      required this.latitude,
      required this.longitude,
      required this.id});
}

class SearchLocationEvent extends AddressEvent {
  final String searchText;

  SearchLocationEvent({required this.searchText});
}


class GetSavedAddressEvent extends AddressEvent {
  final String userId;

  GetSavedAddressEvent({required this.userId});
}

class GetLocationUsingLatLongFromApiEvent extends AddressEvent {
  
}


