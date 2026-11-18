// // ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../Util/constant_color.dart';
// class ProductPriceSliderClass extends StatefulWidget {
//   double minV1;
//   double maxV1;
//   final Function(String,String) callback;
//   ProductPriceSliderClass({super.key, required this.minV1, required this.maxV1, required this.callback,});
//
//   @override
//   State<ProductPriceSliderClass> createState() => _ProductPriceSliderClassState();
// }
//
// class _ProductPriceSliderClassState extends State<ProductPriceSliderClass> {
//   var minMyPrice;
//   var maxMyPrice;
//   RangeValues? _currentRangeValues;
//   @override
//    initState()  {
//     super.initState();
//     double minV1 = widget.minV1;
//     double maxV1 = widget.maxV1;
//     _currentRangeValues = RangeValues(minV1, maxV1);
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     double minV1 = widget.minV1;
//     double maxV1 = widget.maxV1;
//     // print("V1-------------------------$minV1 && $maxV1");
//     // print("minMyPrice-------------------------$minMyPrice");
//     // print("maxMyPrice-------------------------$maxMyPrice");
//     return RangeSlider(
//       activeColor: ConstantColor.primaryMainColor,
//       values: _currentRangeValues!,
//       min: (minV1 ?? 0.0).toDouble(),
//       max: (maxV1 ?? 0.0).toDouble(),
//       divisions: null,
//       labels: RangeLabels(
//         _currentRangeValues!.start.round().toString(),
//         _currentRangeValues!.end.round().toString(),
//       ),
//       onChanged: (RangeValues values){
//         setState(()  {
//           _currentRangeValues = values;
//           minMyPrice= _currentRangeValues!.start.round().toString();
//           maxMyPrice= _currentRangeValues!.end.round().toString();
//           // SharedPreferences preference = await SharedPreferences.getInstance();
//           //
//           // preference.setString("minMyPrice",minMyPrice);
//           // preference.setString("maxMyPrice",maxMyPrice);
//
//           widget.callback(minMyPrice,maxMyPrice);
//         });
//         //  print("values------------------------$values");
//       },
//     );
//   }
// }


// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Util/constant_color.dart';
class ProductPriceSliderClass extends StatefulWidget {
  double minV1;
  double maxV1;
  final Function(String,String) callback;
  ProductPriceSliderClass({super.key, required this.minV1, required this.maxV1, required this.callback,});

  @override
  State<ProductPriceSliderClass> createState() => _ProductPriceSliderClassState();
}

class _ProductPriceSliderClassState extends State<ProductPriceSliderClass> {
  var minMyPrice;
  var maxMyPrice;
  RangeValues? _currentRangeValues;
  double minMyPriceL=0.0;
  double maxMyPriceL=0.0;
  @override
  void initState() {
    super.initState();
    _loadPriceValues();
  }

  Future<void> _loadPriceValues() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String? minMyPriceString = preference.getString("minMyPrice");
    String? maxMyPriceString = preference.getString("maxMyPrice");
    minMyPriceL = double.tryParse(minMyPriceString ?? "") ?? 0.0;
    maxMyPriceL = double.tryParse(maxMyPriceString ?? "") ?? 0.0;

    double minV1 = minMyPriceL != 0.0 ? minMyPriceL : widget.minV1;
    double maxV1 = maxMyPriceL != 0.0 ? maxMyPriceL : widget.maxV1;

    setState(() {
      _currentRangeValues = RangeValues(minV1, maxV1);
    });
  }

  @override
  Widget build(BuildContext context) {

    double minV1 = widget.minV1;
    double maxV1 = widget.maxV1;
    return  RangeSlider(
      activeColor: ConstantColor.primaryMainColor,
      values: _currentRangeValues ?? RangeValues(0, 0),
      min: (minV1 ?? 0.0).toDouble(),
      max: (maxV1 ?? 0.0).toDouble(),
      divisions: 40,
      labels: RangeLabels(
        _currentRangeValues!.start.round().toString(),
        _currentRangeValues!.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        _updateRangeValues(values);
      },
    );
  }

  _updateRangeValues(RangeValues values) {
    double newMinMyPrice = values.start.round().toDouble();
    double newMaxMyPrice = values.end.round().toDouble();
    _updateSharedPreferences(newMinMyPrice, newMaxMyPrice);
  }

  _updateSharedPreferences(double newMinMyPrice, double newMaxMyPrice) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString("minMyPrice", newMinMyPrice.toString());
    preference.setString("maxMyPrice", newMaxMyPrice.toString());

    setState(() {
      _currentRangeValues = RangeValues(newMinMyPrice, newMaxMyPrice);
      minMyPrice = newMinMyPrice.toString();
      maxMyPrice = newMaxMyPrice.toString();
    });

    widget.callback(minMyPrice, maxMyPrice);
  }
}
