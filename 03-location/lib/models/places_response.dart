// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

import 'dart:convert';

PlacesResponse placesResponseFromJson(String str) =>
    PlacesResponse.fromJson(json.decode(str));

String placesResponseToJson(PlacesResponse data) => json.encode(data.toJson());

class PlacesResponse {
  PlacesResponse({
    required this.type,
    // required this.query,
    required this.features,
    required this.attribution,
  });

  String type;
  // List<String> query;
  List<Feature> features;
  String attribution;

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        // query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        // "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.textEs,
    required this.languageEs,
    required this.placeNameEs,
    required this.text,
    required this.language,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
    required this.matchingText,
    required this.matchingPlaceName,
  });

  String id;
  String type;
  List<String> placeType;
  double? relevance;
  Properties properties;
  String? textEs;
  Language? languageEs;
  String? placeNameEs;
  String text;
  Language? language;
  String placeName;
  List<double> center;
  Geometry geometry;
  List<Context> context;
  String? matchingText;
  String? matchingPlaceName;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: double.tryParse(json["relevance"]?.toString() ?? ''),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        languageEs: json["language_es"] == null
            ? null
            : languageValues.map[json["language_es"]],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es":
            languageEs == null ? null : languageValues.reverse[languageEs],
        "place_name_es": placeNameEs,
        "text": text,
        "language": language == null ? null : languageValues.reverse[language],
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
      };
}

class Context {
  Context({
    required this.id,
    required this.textEs,
    required this.text,
    required this.shortCode,
    required this.wikidata,
    required this.languageEs,
    required this.language,
  });

  String id;
  String? textEs;
  String text;
  String? shortCode;
  String? wikidata;
  String? languageEs;
  String? language;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        textEs: json["text_es"],
        text: json["text"],
        shortCode: json["short_code"],
        wikidata: json["wikidata"],
        languageEs: json["language_es"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "short_code": shortCode,
        "wikidata": wikidata,
        "language_es": languageValues.reverse[languageEs],
        "language": languageValues.reverse[language],
      };
}

enum Language { ES }

final languageValues = EnumValues({"es": Language.ES});

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  List<double> coordinates;
  String type;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  Properties({
    required this.wikidata,
    required this.category,
    this.landmark = false,
    required this.address,
    required this.foursquare,
    required this.maki,
  });

  String? wikidata;
  String? category;
  bool? landmark;
  String? address;
  String? foursquare;
  String? maki;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        category: json["category"],
        landmark: json["landmark"],
        address: json["address"],
        foursquare: json["foursquare"],
        maki: json["maki"],
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata,
        "category": category,
        "landmark": landmark,
        "address": address,
        "foursquare": foursquare,
        "maki": maki,
      };
}

class EnumValues<T> {
  final Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
