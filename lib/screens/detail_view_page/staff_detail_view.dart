import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_force/db/model/data_model.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/detail_view_page/image_view.dart';

class StaffDetails extends StatelessWidget {
  StaffModel staffdetail;
  StaffDetails({super.key, required this.staffdetail});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          foregroundColor: Colors.white,
          backgroundColor: primaryGray,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
          title: Text(
            'Detaile view',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  
                  height: screenHeight *0.8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: tileColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: FileImage(File(staffdetail.proimage)),
                      radius: 60,
                    ),
                    Text(
                      ' ${staffdetail.name}',
                      style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w500,),
                    ),
                    Text(
                      ' ${staffdetail.position}',
                      style: TextStyle(fontSize: 15,color: Colors.white),
                    ),
                    SizedBox(
                      height:smallestHeight * 0.5,
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'ID ${staffdetail.id}',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ImageView(
                                      ImagePath: staffdetail.idimage))),
                          child: Container(
                            height: smallestHeight * 0.4,
                            width: smallestWidth * 1.1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Image.asset(
                              'assets/image/idicon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          '${staffdetail.genter}',
                          style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),
                        ),
                      ],
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                      color: Colors.white,
                    ),SizedBox(height: smallestHeight * 0.2,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '     Address       :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text(
                          ' ${staffdetail.address}',
                          style: TextStyle(fontSize: 17,color: Colors.white),
                        )
                      ],
                    ),SizedBox(
                      height: smallestHeight * 0.3
                    ),
                    Row(
                      children: [
                        Text(
                          '     Number       :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        GestureDetector(onTap: () => _makePhoneCall(' ${staffdetail.phonenumber}'),
                          child: Text(
                            ' ${staffdetail.phonenumber}',
                            style: TextStyle(fontSize: 17,color: Colors.white),
                          ),
                        )
                      ],
                    ),SizedBox(
                      height:smallestHeight * 0.3
                    ),
                    Row(
                      children: [
                        Text(
                          '     Salary          :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text(
                          ' ₹${staffdetail.salary}',
                          style: TextStyle(fontSize: 17,color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
Future<void> _makePhoneCall(String phoneNumber) async {
  
  final url = Uri.parse('tel:+91$phoneNumber');

  if (await canLaunchUrl(url)) {
  
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
 
  
}
}
