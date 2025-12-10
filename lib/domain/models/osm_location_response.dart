class OSMLocationResponse {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  String? classType;
  String? type;
  int? placeRank;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  OSMLocationResponse({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.classType,
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  OSMLocationResponse.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    classType = json['class'];
    type = json['type'];
    placeRank = json['place_rank'];
    importance = json['importance'];
    addresstype = json['addresstype'];
    name = json['name'];
    displayName = json['display_name'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    boundingbox = json['boundingbox'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['licence'] = licence;
    data['osm_type'] = osmType;
    data['osm_id'] = osmId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['class'] = classType;
    data['type'] = type;
    data['place_rank'] = placeRank;
    data['importance'] = importance;
    data['addresstype'] = addresstype;
    data['name'] = name;
    data['display_name'] = displayName;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['boundingbox'] = boundingbox;
    return data;
  }
}

class Address {
  String? amenity;
  String? road;
  String? village;
  String? subdistrict;
  String? city;
  String? state;
  String? iSO31662Lvl4;
  String? region;
  String? iSO31662Lvl3;
  String? postcode;
  String? country;
  String? countryCode;

  Address({this.amenity, this.road, this.village, this.subdistrict, this.city, this.state, this.iSO31662Lvl4, this.region, this.iSO31662Lvl3, this.postcode, this.country, this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    amenity = json['amenity'];
    road = json['road'];
    village = json['village'];
    subdistrict = json['subdistrict'];
    city = json['city'];
    state = json['state'];
    iSO31662Lvl4 = json['ISO3166-2-lvl4'];
    region = json['region'];
    iSO31662Lvl3 = json['ISO3166-2-lvl3'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amenity'] = amenity;
    data['road'] = road;
    data['village'] = village;
    data['subdistrict'] = subdistrict;
    data['city'] = city;
    data['state'] = state;
    data['ISO3166-2-lvl4'] = iSO31662Lvl4;
    data['region'] = region;
    data['ISO3166-2-lvl3'] = iSO31662Lvl3;
    data['postcode'] = postcode;
    data['country'] = country;
    data['country_code'] = countryCode;
    return data;
  }
}
