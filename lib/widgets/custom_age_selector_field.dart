import 'package:flutter/material.dart';

class CustomAgeSelector extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialAge;
  final Function(int) onChanged;

  CustomAgeSelector({
    required this.minValue,
    required this.maxValue,
    required this.initialAge,
    required this.onChanged,
  });

  @override
  _CustomAgeSelectorState createState() => _CustomAgeSelectorState();
}

class _CustomAgeSelectorState extends State<CustomAgeSelector> {
  late int _currentAge;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _currentAge = widget.initialAge;
    _scrollController = ScrollController();
  }

  void _scrollToSelectedValue() {
    final selectedIndex = _currentAge - widget.minValue;
    final itemHeight = 75.0;
    final itemOffset = selectedIndex * itemHeight;
    final screenWidth = MediaQuery.of(context).size.width;
    final widgetWidth = screenWidth * 0.6;
    final scrollOffset = itemOffset - (widgetWidth / 2) + (itemHeight / 2);
    _scrollController.animateTo(scrollOffset,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final widgetHeight = screenHeight * 0.5;

    return Container(
      height: widgetHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: Slider(
              value: _currentAge.toDouble(),
              min: widget.minValue.toDouble(),
              max: widget.maxValue.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  _currentAge = newValue.toInt();
                });
                widget.onChanged(_currentAge);
                _scrollToSelectedValue();
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Align(
              alignment: Alignment.center,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.maxValue - widget.minValue + 1,
                itemBuilder: (context, index) {
                  final value = widget.minValue + index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentAge = value;
                        });
                        widget.onChanged(_currentAge);
                        _scrollToSelectedValue();
                      },
                      child: Container(
                        height: 75,
                        child: Center(
                          child: Text(
                            value.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              decorationColor: Colors.blue,
                              decoration: value == _currentAge
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              fontSize: value == _currentAge ? 70 : 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
