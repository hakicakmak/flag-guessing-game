import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class FlagWidget extends StatefulWidget {
  final String countryCode;

  const FlagWidget({Key? key, required this.countryCode}) : super(key: key);

  @override
  _FlagWidgetState createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {
  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(widget.countryCode);
  }
}
