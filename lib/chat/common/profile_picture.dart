import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double containerSideLength;
  final double profilePictureRadius;
  ProfilePicture(
    {Key key, this.containerSideLength = 80.0, this.profilePictureRadius = 60.0}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSideLength,
      height: containerSideLength,
      child: Center(
        child: Container(
          width: profilePictureRadius, 
          height: profilePictureRadius, 
          decoration: BoxDecoration(
            color: Colors.black, 
            shape: BoxShape.circle
          )
        )
      )
    );
  }
}