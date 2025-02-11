import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

/// ROCKET MODEL
/// Auxiliary model to storage all details about a rocket which performed a SpaceX's mission.
class Rocket {
  final String id, name, type;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final Fairing fairing;

  Rocket({
    this.id,
    this.name,
    this.type,
    this.firstStage,
    this.secondStage,
    this.fairing,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['rocket_id'],
      name: json['rocket_name'],
      type: json['rocket_type'],
      firstStage: (json['first_stage']['cores'] as List)
          .map((core) => Core.fromJson(core))
          .toList(),
      secondStage: SecondStage.fromJson(json['second_stage']),
      fairing:
          json['fairings'] == null ? null : Fairing.fromJson(json['fairings']),
    );
  }

  bool get isHeavy => firstStage.length != 1;

  bool get hasFairing => fairing != null;
}

/// CORE CLASS
/// Auxiliary model to storage details about a core in a particular mission.
class Core {
  final String id, landingType, landingZone;
  final bool reused, landingSuccess, landingIntent;
  final int block, flights;

  Core({
    this.id,
    this.landingType,
    this.landingZone,
    this.reused,
    this.landingSuccess,
    this.landingIntent,
    this.block,
    this.flights,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      id: json['core_serial'],
      landingType: json['landing_type'],
      landingZone: json['landing_vehicle'],
      reused: json['reused'],
      landingSuccess: json['land_success'],
      landingIntent: json['landing_intent'],
      block: json['block'],
      flights: json['flight'],
    );
  }

  String getId(context) =>
      id ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getLandingType(context) =>
      landingType ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getLandingZone(context) =>
      landingZone ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getBlock(context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          {'block': block.toString()},
        );

  String getFlights(context) => flights == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : flights.toString();
}

/// SECOND STAGE MODEL
/// Details about rocket's second stage.
class SecondStage {
  final int block;
  final List<Payload> payloads;

  SecondStage({this.block, this.payloads});

  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      block: json['block'],
      payloads: (json['payloads'] as List)
          .map((payload) => Payload.fromJson(payload))
          .toList(),
    );
  }

  String getBlock(context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          {'block': block.toString()},
        );

  Payload getPayload(int index) => payloads[index];

  int get getNumberPayload => payloads.length;
}

/// PAYLOAD MODEL
/// Specific details about an one-of-a-kink space payload.
class Payload {
  final String id, capsuleSerial, customer, nationality, manufacturer, orbit;
  final bool reused;
  final num mass;

  Payload({
    this.id,
    this.capsuleSerial,
    this.customer,
    this.nationality,
    this.manufacturer,
    this.orbit,
    this.reused,
    this.mass,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['payload_id'],
      capsuleSerial: json['cap_serial'],
      customer: json['customers'][0],
      nationality: json['nationality'],
      manufacturer: json['manufacturer'],
      orbit: json['orbit'],
      reused: json['reused'],
      mass: json['payload_mass_kg'],
    );
  }

  String getId(context) =>
      id ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getCapsuleSerial(context) =>
      capsuleSerial ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getCustomer(context) =>
      customer ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getNationality(context) =>
      nationality ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getManufacturer(context) =>
      manufacturer ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getOrbit(context) =>
      orbit ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getMass(context) => mass == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  bool get isNasaPayload =>
      customer == 'NASA (CCtCap)' || customer == 'NASA (CRS)';
}

/// FAIRING MODEL
/// Auxiliary model to storage details about rocket's fairings.
class Fairing {
  final bool reused, recoveryAttempt, recoverySuccess;
  final String ship;

  Fairing({
    this.reused,
    this.recoveryAttempt,
    this.recoverySuccess,
    this.ship,
  });

  factory Fairing.fromJson(Map<String, dynamic> json) {
    return Fairing(
      reused: json['reused'],
      recoveryAttempt: json['recovery_attempt'],
      recoverySuccess: json['recovered'],
      ship: json['ship'],
    );
  }
}
