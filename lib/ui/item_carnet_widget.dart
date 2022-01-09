import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCarnetWidget extends StatelessWidget {

  String fullName;
  String dni;
  String url;

  ItemCarnetWidget({required this.fullName, required this.dni, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.symmetric(
          vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 5.0),
            BoxShadow(
                color: Colors.black12.withOpacity(0.04),
                offset: Offset(4, 4),
                blurRadius: 12.0),
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nombre",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: COLOR_FONT_PRIMARY.withOpacity(
                      0.6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bx-user-2.svg',
                      color: COLOR_FONT_PRIMARY.withOpacity(0.72),
                      height: 16,
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      fullName,
                      style: TextStyle(
                        color: COLOR_FONT_PRIMARY
                            .withOpacity(0.9),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Número de DNI",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: COLOR_FONT_PRIMARY.withOpacity(
                      0.6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bx-card.svg',
                      color: COLOR_FONT_PRIMARY.withOpacity(0.72),
                      height: 16,
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      dni,
                      style: TextStyle(
                        color: COLOR_FONT_PRIMARY
                            .withOpacity(0.9),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/bx-link.svg',
              color: COLOR_FONT_PRIMARY,
            ),
          ),
        ],
      ),
    );
  }
}