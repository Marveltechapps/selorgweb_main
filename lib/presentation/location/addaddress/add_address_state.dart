import 'package:geocoding/geocoding.dart';
import 'package:selorgweb_main/model/addaddress/add_address_save_response_mode.dart';

abstract class AddAddressState {}

class AddAddressInitialState extends AddAddressState {}

class AddAddressLoadingState extends AddAddressState {}

class AddAddressSaveSuccess extends AddAddressState {
  final AddAddressSaveResponse addAddressSaveResponse;

  AddAddressSaveSuccess({required this.addAddressSaveResponse});
}
class LocationSuccessState extends AddAddressState {
  String? latitude;
  String? longitude;
  Placemark? place;

  LocationSuccessState(
      {required this.latitude, required this.longitude, required this.place});
}
class SelectedLabelState extends AddAddressState{
final String label;

  SelectedLabelState({required this.label});
}

class AddAddressErrorState extends AddAddressState {
  final String errorMsg;

  AddAddressErrorState({required this.errorMsg});
}
