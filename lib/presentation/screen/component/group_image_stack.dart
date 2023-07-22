import 'package:flutter/material.dart';

class GroupImageStack extends StatelessWidget {
  final List<String> groupImageUrls;

  GroupImageStack({required this.groupImageUrls});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i <=2; i++)
          Positioned(
            left: i * 20.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                groupImageUrls[i],
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (groupImageUrls.length > 2)
          Positioned(
            left: 2 * 20.0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  '+${groupImageUrls.length - 2}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}