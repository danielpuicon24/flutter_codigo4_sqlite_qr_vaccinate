import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo4_sqflite_qr/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_qr/models/carnet_model.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  String url;

  RegisterPage({required this.url});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {
  final _keyForm = GlobalKey<FormState>();

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dniController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: COLOR_FONT_PRIMARY,
          ),
          title: Center(
            child: Text(
              "Agregar carnet",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: COLOR_FONT_PRIMARY,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/bx-hive.svg'),
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nombre completo:",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: COLOR_FONT_PRIMARY,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.05),
                              blurRadius: 12,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            hintText: "Nombre completo",
                            fillColor: Colors.white,
                            filled: true,
                            errorStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xffF45E29),
                            ),
                            hintStyle: TextStyle(
                                color: COLOR_FONT_PRIMARY.withOpacity(0.3)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "El campo no puede estar vacío";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Número de DNI:",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: COLOR_FONT_PRIMARY,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.04),
                              blurRadius: 10,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _dniController,
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            hintText: "Número de DNI",
                            hintStyle: TextStyle(
                              color: COLOR_FONT_PRIMARY.withOpacity(0.3),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            counterText: "",
                            errorStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xffF45E29),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "El campo no puede estar vacío";
                            }

                            if (value.length < 8) {
                              return "Ingrese como minimo 8 caracteres";
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 54,
                width: double.infinity,
                margin: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffF45E29),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      CarnetModel carnet = CarnetModel(
                        fullName: _fullNameController.text,
                        dni: _dniController.text,
                        url: widget.url,
                      );
                      DBAdmin.db.insertCarnet(carnet).then((value) {
                        if (value >= 0) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Color(0xff02c39a),
                              elevation: 5,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Carnet agregado con éxito.",
                              ),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: Text(
                    "Agregar carnet",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}