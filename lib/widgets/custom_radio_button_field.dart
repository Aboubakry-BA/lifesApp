import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String text;
  final ImageProvider image;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomRadioButton({
    required this.text,
    required this.image,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        height: 115,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[900] : Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: image, height: 50, width: 50),
                    const SizedBox(height: 8.0),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                top: 15,
                right: 15,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
