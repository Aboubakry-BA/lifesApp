import 'package:flutter/material.dart';

class CustomKit extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final String title;
  final String text;
  final Color? iconColor;
  final Color? backgroundColor;

  const CustomKit({
    required this.icon1,
    required this.icon2,
    required this.title,
    required this.text,
    required this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: MediaQuery.of(context).size.width * 0.52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: backgroundColor ?? Colors.black54,
      ),
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon2,
                      size: 24.0,
                      color: iconColor,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.0),
          Icon(
            icon1,
            size: 64.0,
          ),
        ],
      ),
    );
  }
}
