abstract class AddressEvent{}

class AddressInitialEvent extends AddressEvent {}

class GetLocationEvent extends AddressEvent {}

class ContinueLocationEvent extends AddressEvent {}

class PlaceLocaitonEvent extends AddressEvent {
  final String locationText;

  PlaceLocaitonEvent({required this.locationText});
}

class GetLatLonOnListEvent extends AddressEvent {
  final String placeId;

  GetLatLonOnListEvent({required this.placeId});
}

class SearchLocationEvent extends AddressEvent {
  final String searchText;

  SearchLocationEvent({required this.searchText});
}

class GetLocationUsingLatLongFromApiEvent extends AddressEvent {
  final String latitude;
  final String longitude;

  GetLocationUsingLatLongFromApiEvent({
    required this.latitude,
    required this.longitude,
  });
}

class UpdateLocationEvent extends AddressEvent {
  final String location;

  UpdateLocationEvent({required this.location});
}