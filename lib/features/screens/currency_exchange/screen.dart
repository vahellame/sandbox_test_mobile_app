import 'dart:developer';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/controller_state_mixin.dart';
import '../../domain/controllers/currency/currencies_controller.dart';
import '../../domain/models/currency_model/currency_model.dart';

class CurrencyExchangeScreen extends StatefulWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  State<CurrencyExchangeScreen> createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen>
    with ControllerStateMixin<CurrencyExchangeScreen, CurrenciesController> {
  final _currencySendController = TextEditingController();
  final _currencyGetController = TextEditingController();

  CurrencyModel? _selectedSendCurrency;
  CurrencyModel? _selectedGetCurrency;

  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();

    _currencySendController.addListener(() => _updateValues(_UpdateSource.sendText));
    _currencyGetController.addListener(() => _updateValues(_UpdateSource.getText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text('You send'),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _currencySendController,
                      decoration: const InputDecoration(
                        hintText: 'Enter amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    items: cw.currencies
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    value: _selectedSendCurrency,
                    onChanged: (value) {
                      _selectedSendCurrency = value;
                      _updateValues(_UpdateSource.getText);
                    },
                  ),
                ],
              ),
              Align(
                child: IconButton(
                  onPressed: _swapValues,
                  icon: const Icon(Icons.swap_vert),
                ),
              ),
              const Text('You get'),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _currencyGetController,
                      decoration: const InputDecoration(
                        hintText: 'Enter amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    items: cw.currencies
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    value: _selectedGetCurrency,
                    onChanged: (value) {
                      _selectedGetCurrency = value;
                      _updateValues(_UpdateSource.sendText);
                    },
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  void _swapValues() {
    final tempCurrency = _selectedSendCurrency;
    final tempText = _currencySendController.text;

    _selectedSendCurrency = _selectedGetCurrency;
    _currencySendController.text = _currencyGetController.text;

    _selectedGetCurrency = tempCurrency;
    _currencyGetController.text = tempText;

    setState(() {});
  }

  void _updateValues(_UpdateSource source) {
    setState(() {});
    try {
      if (_isUpdating) return;

      if (_selectedGetCurrency == null || _selectedSendCurrency == null) return;

      _isUpdating = true;

      final rateSend = _selectedSendCurrency!.rate;
      final rateGet = _selectedGetCurrency!.rate;

      switch (source) {
        case _UpdateSource.sendText:
          final value = Decimal.parse(
            _currencySendController.text.isEmpty ? '0' : _currencySendController.text,
          );
          final dollars = (value / rateSend).toDecimal(scaleOnInfinitePrecision: 10);
          _currencyGetController.text = (dollars * rateGet).toStringAsFixed(2);

        case _UpdateSource.getText:
          final value = Decimal.parse(
            _currencyGetController.text.isEmpty ? '0' : _currencyGetController.text,
          );
          final dollars = (value / rateGet).toDecimal(scaleOnInfinitePrecision: 10);
          _currencySendController.text = (dollars * rateSend).toStringAsFixed(2);
      }
    } catch (e, s) {
      log('', name: 'ERROR', error: e, stackTrace: s);
    }

    _isUpdating = false;
    setState(() {});
  }

  @override
  void dispose() {
    _currencySendController.dispose();
    _currencyGetController.dispose();
    super.dispose();
  }
}

enum _UpdateSource {
  sendText,
  getText,
}
