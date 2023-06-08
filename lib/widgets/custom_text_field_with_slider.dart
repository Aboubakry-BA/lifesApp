import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWithSlider extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType type;
  final double sliderValue;
  final double min;
  final double max;
  final ValueChanged<double> onSliderChanged;

  const CustomTextFieldWithSlider({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.type = TextInputType.text,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.autofillHints,
    this.prefixIcon,
    this.suffixIcon,
    required TextInputType keyboardType,
    required this.sliderValue,
    required this.min,
    required this.max,
    required this.onSliderChanged,
  })  : keyboardType = type == TextInputType.visiblePassword
            ? TextInputType.visiblePassword
            : type,
        super(key: key);

  @override
  _CustomTextFieldWithSliderState createState() =>
      _CustomTextFieldWithSliderState();
}

class _CustomTextFieldWithSliderState extends State<CustomTextFieldWithSlider> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.sliderValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Colors.white54,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              borderSide: BorderSide(color: Color.fromARGB(255, 33, 33, 33)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              borderSide: BorderSide(color: Colors.red),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: Colors.grey[900],
          ),
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters,
          autofillHints: widget.autofillHints,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Transform.translate(
          offset: Offset(0, -5),
          child: Container(
            height: 7, // set the height as desired
            child: Slider(
              value: _sliderValue,
              min: widget.min,
              max: widget.max,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                  widget.onSliderChanged(_sliderValue);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
