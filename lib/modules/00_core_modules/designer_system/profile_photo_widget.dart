import 'package:flutter/material.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final ImageProvider<Object> image;

  const ProfilePhotoWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: themeColor.primary,
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
            image: image,
            // image: NetworkImage(
            //   'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2023/07/IMG_4029.jpg?w=732&h=412&crop=1',
            // ),
            fit: BoxFit.cover),
      ),
      child: const SizedBox(),
    );
  }
}
