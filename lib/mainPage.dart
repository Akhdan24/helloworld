import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final cari = TextEditingController();
  final nama = TextEditingController();
  final gantiNama = TextEditingController();
  bool showTextField = true;
  final currentUser = FirebaseAuth.instance;
  bool isCheked = false;
  bool isRadio = false;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('product');
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama.text = gantiNama.text;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showTextField = !showTextField;
                });
              },
              child: Text(
                'Add',
                style: GoogleFonts.poppins().copyWith(color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // Get.to(create());
              },
              child: Text(
                'Dell All',
                style: GoogleFonts.poppins().copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (showTextField == false)
                    ? Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 109,
                            child: TextField(
                              controller: nama,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5),
                                hintStyle: GoogleFonts.poppins().copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: '989797'.toColor(),
                                ),
                                hintText: 'nama',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              users.add({'name': nama.text});
                            },
                            child: Text(
                              'Save',
                              style: GoogleFonts.poppins()
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: TextField(
                        controller: cari,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          contentPadding:
                              EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          hintStyle: GoogleFonts.poppins().copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: '989797'.toColor(),
                          ),
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.text_rotate_vertical_outlined,
                          size: 30,
                        )),
                  ],
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                    stream: users.orderBy('name').snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!.docs
                              .map(
                                (e) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isRadio = !isRadio;
                                            });
                                          },
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  width: 1, color: Colors.grey),
                                              color: (isRadio == true)
                                                  ? Colors.blue
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          e.data().toString(),
                                          style: GoogleFonts.poppins().copyWith(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Ganti nama :',
                                                      style:
                                                          GoogleFonts.poppins()
                                                              .copyWith(
                                                                  fontSize: 12),
                                                    ),
                                                    content: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              109,
                                                      child: TextField(
                                                        controller: gantiNama,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 5,
                                                                  bottom: 5),
                                                          hintStyle: GoogleFonts
                                                                  .poppins()
                                                              .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: '989797'
                                                                .toColor(),
                                                          ),
                                                          hintText: 'nama',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text('Update'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.edit_note, size: 20),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                          onPressed: () {
                                            users.doc(e.id).delete();
                                          },
                                          icon: Icon(Icons.delete, size: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ]),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: EdgeInsets.all(5),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Load More'),
        ),
      ),
    );
  }
}
