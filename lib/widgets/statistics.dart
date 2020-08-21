import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  final TextStyle style = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );
  final double sizedBoxHeight = 12;
  final Color iconColor = Colors.blueGrey[300];
  final Color mainColor = /* Color(0xFF131316); */
      Colors.black45; //Color(0xFF1E1E24); // //Color(0xFF5F5F60);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: mainColor,
          /* decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey[700], Colors.grey[800]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ), */
          child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.chevron_right, color: iconColor),
                          Text(
                            "Added releases:\n167",
                            style: style,
                          )
                        ],
                      ),
                      /* SizedBox(
                        height: sizedBoxHeight,
                      ), */
                      Row(
                        children: [
                          Icon(Icons.chevron_right, color: iconColor),
                          Text(
                            "Added tracks:\n742",
                            style: style,
                          )
                        ],
                      ),
                      /*  SizedBox(
                        height: sizedBoxHeight,
                      ), */
                      Row(
                        children: [
                          Icon(Icons.chevron_right, color: iconColor),
                          Text(
                            "Most rated:\nExcellent",
                            style: style,
                          )
                        ],
                      ),
                      /*  SizedBox(
                        height: sizedBoxHeight,
                      ), */
                      Row(
                        children: [
                          Icon(Icons.chevron_right, color: iconColor),
                          Text(
                            "Album with most tracks:\nDownward Spiral",
                            style: style,
                          )
                        ],
                        /*  ),
                      SizedBox(
                        height: sizedBoxHeight, */
                      ),
                      Row(
                        children: [
                          Icon(Icons.chevron_right, color: iconColor),
                          Text(
                            "Album with most masterpieces:\nNeon Bible",
                            style: style,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
