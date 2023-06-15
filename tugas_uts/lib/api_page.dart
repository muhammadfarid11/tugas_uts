// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class apiPage extends StatelessWidget {
  apiPage({super.key});

  List<dynamic> compeny = [];

  Future getItems() async {
    var response = await http.get(Uri.https('arbeitnow.com',
        '/api/job-board-api')); //https://www.arbeitnow.com/api/job-board-api

    var jsonData = jsonDecode(response.body);

    compeny = jsonData['data'];
    print(compeny.length);
    return jsonData;
  }

  int plusOne(int x) {
    int hasil = x + 1;
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getItems(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Other Company : ",
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          for (int i = 0; i < compeny.length; i++)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            Color.fromARGB(255, 174, 212, 242)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  child: Text(
                                                    compeny[i]['company_name'],
                                                    style: GoogleFonts.ptSans(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  child: Text(
                                                    compeny[i]['title'],
                                                    style: GoogleFonts.ptSans(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
