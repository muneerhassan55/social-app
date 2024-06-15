import 'package:flutter/material.dart';

class ImaagePostScreen extends StatelessWidget {
  String text, url;
  ImaagePostScreen({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.indigo.shade100,
          border: Border.all(color: Colors.grey, width: 1)),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              )),
          Text(text)
        ],
      ),
    );
  }
}
