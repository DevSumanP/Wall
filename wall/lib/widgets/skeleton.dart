import 'package:flutter/material.dart';

class SkeletonThread extends StatelessWidget {
  const SkeletonThread({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(width: 10),
              Container(
                width: 100,
                height: 10,
                color: Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
