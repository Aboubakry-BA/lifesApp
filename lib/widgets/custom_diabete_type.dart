import 'package:flutter/material.dart';

class CustomDiabeteType extends StatelessWidget {
  final String title;
  final List<String> subtitles;
  final bool isSelected;
  final VoidCallback onTap;

  CustomDiabeteType({
    required this.title,
    required this.subtitles,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
          ),
        ),
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: subtitles
                  .map(
                    (subtitle) => Container(
                      padding: EdgeInsets.all(7.0),
                      margin: EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Colors.grey[800],
                      ),
                      child: Text(
                        subtitle,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
