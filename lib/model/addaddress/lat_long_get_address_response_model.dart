import 'dart:convert';

LatLongLocationResponse latLongLocationResponseFromJson(String str) => LatLongLocationResponse.fromJson(json.decode(str));

String latLongLocationResponseToJson(LatLongLocationResponse data) => json.encode(data.toJson());

class LatLongLocationResponse {
    PlusCode? plusCode;
    List<Result>? results;
    String? status;

    LatLongLocationResponse({
        this.plusCode,
        this.results,
        this.status,
    });

    factory LatLongLocationResponse.fromJson(Map<String, dynamic> json) => LatLongLocationResponse(
        plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "plus_code": plusCode?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
    };
}

class PlusCode {
    String? compoundCode;
    String? globalCode;

    PlusCode({
        this.compoundCode,
        this.globalCode,
    });

    factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
    );

    Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
    };
}

class Result {
    List<AddressComponent>? addressComponents;
    String? formattedAddress;
    Geometry? geometry;
    List<NavigationPoint>? navigationPoints;
    String? placeId;
    PlusCode? plusCode;
    List<String>? types;

    Result({
        this.addressComponents,
        this.formattedAddress,
        this.geometry,
        this.navigationPoints,
        this.placeId,
        this.plusCode,
        this.types,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: json["address_components"] == null ? [] : List<AddressComponent>.from(json["address_components"]!.map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
        navigationPoints: json["navigation_points"] == null ? [] : List<NavigationPoint>.from(json["navigation_points"]!.map((x) => NavigationPoint.fromJson(x))),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
        types: json["types"] == null ? [] : List<String>.from(json["types"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null ? [] : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry?.toJson(),
        "navigation_points": navigationPoints == null ? [] : List<dynamic>.from(navigationPoints!.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode?.toJson(),
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
    };
}

class AddressComponent {
    String? longName;
    String? shortName;
    List<String>? types;

    AddressComponent({
        this.longName,
        this.shortName,
        this.types,
    });

    factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: json["types"] == null ? [] : List<String>.from(json["types"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
    };
}

class Geometry {
    NortheastClass? location;
    String? locationType;
    Bounds? viewport;
    Bounds? bounds;

    Geometry({
        this.location,
        this.locationType,
        this.viewport,
        this.bounds,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null ? null : NortheastClass.fromJson(json["location"]),
        locationType: json["location_type"],
        viewport: json["viewport"] == null ? null : Bounds.fromJson(json["viewport"]),
        bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "location_type": locationType,
        "viewport": viewport?.toJson(),
        "bounds": bounds?.toJson(),
    };
}

class Bounds {
    NortheastClass? northeast;
    NortheastClass? southwest;

    Bounds({
        this.northeast,
        this.southwest,
    });

    factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
        northeast: json["northeast"] == null ? null : NortheastClass.fromJson(json["northeast"]),
        southwest: json["southwest"] == null ? null : NortheastClass.fromJson(json["southwest"]),
    );

    Map<String, dynamic> toJson() => {
        "northeast": northeast?.toJson(),
        "southwest": southwest?.toJson(),
    };
}

class NortheastClass {
    double? lat;
    double? lng;

    NortheastClass({
        this.lat,
        this.lng,
    });

    factory NortheastClass.fromJson(Map<String, dynamic> json) => NortheastClass(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

class NavigationPoint {
    NavigationPointLocation? location;

    NavigationPoint({
        this.location,
    });

    factory NavigationPoint.fromJson(Map<String, dynamic> json) => NavigationPoint(
        location: json["location"] == null ? null : NavigationPointLocation.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
    };
}

class NavigationPointLocation {
    double? latitude;
    double? longitude;

    NavigationPointLocation({
        this.latitude,
        this.longitude,
    });

    factory NavigationPointLocation.fromJson(Map<String, dynamic> json) => NavigationPointLocation(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
