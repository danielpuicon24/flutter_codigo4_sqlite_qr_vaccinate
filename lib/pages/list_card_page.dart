import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_qr/models/carnet_model.dart';
import 'package:flutter_codigo4_sqflite_qr/pages/scanner_qr_page.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/item_carnet_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListCardPage extends StatefulWidget {
  const ListCardPage({Key? key}) : super(key: key);

  @override
  _ListCardPageState createState() => _ListCardPageState();
}

class _ListCardPageState extends State<ListCardPage> {
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
            "VacunApp",
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
          FutureBuilder(
            future: DBAdmin.db.getCarnetList(),
            builder: (BuildContext context, AsyncSnapshot snap){
              if(snap.hasData){
                List<CarnetModel> carnetList = snap.data;
                print(carnetList);
                return RefreshIndicator(
                  onRefresh: ()async{
                    setState(() {

                    });
                  },
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mis carnets registrados",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: COLOR_FONT_PRIMARY,
                            ),
                          ),
                          carnetList.length > 0 ? RefreshIndicator(
                            onRefresh: () async{
                              setState(() {

                              });
                            },
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()
                              ),
                              shrinkWrap: true,
                              itemCount: carnetList.length,
                              itemBuilder: (BuildContext context, int index){
                                return  ItemCarnetWidget(
                                  fullName: carnetList[index].fullName,
                                  dni: carnetList[index].dni,
                                  url: carnetList[index].url,
                                );
                              },
                            ),
                          ) : Center(child: Text("Aún no hay carnets registrados",),),

                          SizedBox(
                            height: 60.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xffF45E29),
                    )
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 54,
              width: double.infinity,
              margin: EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF45E29),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ScannerQRPage()));

                },
                icon: Icon(Icons.qr_code_scanner),
                label: Text(
                  "Escanear QR",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}