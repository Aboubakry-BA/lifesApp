import 'package:flutter/material.dart';

class CustomStat extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final String title;
  final String text;
  final String time;
  final Color? iconColor;
  final Color? iconColor2;
  final Color? backgroundColor;

  const CustomStat({
    required this.icon1,
    required this.icon2,
    required this.title,
    required this.text,
    required this.time,
    this.iconColor,
    this.iconColor2,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: backgroundColor ?? Colors.grey[850],
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon1,
                    size: 24.0,
                    color: iconColor,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              Icon(
                icon2,
                size: 24.0,
                color: iconColor2,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 35.0),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
