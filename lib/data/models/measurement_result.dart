import 'package:ntt_data/core/utils/utils_methods.dart';

class MeasurementResults {
  final String? measurementID;
  final ErrorDetails? error;
  final int? chunkOrder;
  final double? snr;
  final Map<String, SignalResult>? allResults;

  MeasurementResults({
    this.measurementID,
    this.error,
    this.chunkOrder,
    this.snr,
    this.allResults,
  });

  factory MeasurementResults.fromJson(Map<String, dynamic> json) {
    return MeasurementResults(
      measurementID: UtilMethods.stringParser(json['measurementID']),
      error:
          json['error'] != null
              ? ErrorDetails.fromJson(json['error'])
              : ErrorDetails(),
      chunkOrder: json['chunkOrder'] ?? 0.0,
      snr: json['snr'] ? (json['snr'] as num).toDouble() : 0.0,
      allResults:
          json['allResults']
              ? (json['allResults'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(key, SignalResult.fromJson(value)),
              )
              : {},
    );
  }
}

class ErrorDetails {
  final String? code;
  final Map<String, dynamic>? errors;

  ErrorDetails({this.code, this.errors});

  factory ErrorDetails.fromJson(Map<String, dynamic> json) {
    return ErrorDetails(
      code: UtilMethods.stringParser(json['code']),
      errors: json['errors'] ? Map<String, dynamic>.from(json['errors']) : {},
    );
  }
}

class SignalResult {
  final double value;
  final List<String> notes;

  SignalResult({required this.value, required this.notes});

  factory SignalResult.fromJson(Map<String, dynamic> json) {
    return SignalResult(
      value: json['value'] ? (json['value'] as num).toDouble() : 0.0,
      notes: json['notes'] ? List<String>.from(json['notes']) : [],
    );
  }
}
