import 'package:flutter/material.dart';
import 'package:pp191225/assets/assets.dart';
import 'package:pp191225/core/core.dart';

class NotFoundWidget extends StatelessWidget {
  final String title;
  final String desc;

  const NotFoundWidget({super.key, required this.title, this.desc = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Opacity(
            opacity: 0.9,
            child: Image.asset(
              fit: BoxFit.cover,
              width: 110,
              ImagePaths.getPath(ImagePath.splash),
            ),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              color: AppColors.gray[4],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          if (desc.isNotEmpty)
            Text(
              desc,
              style: TextStyle(color: AppColors.gray[4], fontSize: 12),
            ),
        ],
      ),
    );
  }
}
