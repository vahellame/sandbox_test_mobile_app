import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fixed/fixed.dart';

part 'currency_model.freezed.dart';
part 'currency_model.g.dart';

@freezed
class CurrencyModel with _$CurrencyModel {
  const factory CurrencyModel({
    required String name,
    @JsonKey(fromJson: _fromFixed, toJson: _toFixed) required Fixed rate,
  }) = _CurrencyModel;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
}

Fixed _fromFixed(String amount) => Fixed.parse(amount);

String _toFixed(Fixed rate) => rate.toString();
