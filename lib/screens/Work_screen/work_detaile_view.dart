import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/globalfuntion/variables.dart';

class WorkDetaileView extends StatefulWidget {
  WorkModel workdetails;
  WorkDetaileView({Key? key, required this.workdetails}) : super(key: key);

  @override
  State<WorkDetaileView> createState() => _WorkDetaileViewState();
}

class _WorkDetaileViewState extends State<WorkDetaileView> {
  int selectedIndex = 1;
  List<bool> _isSelected = [false, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        foregroundColor: Colors.white,
        backgroundColor: primaryGray,
        //centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
        title: Text(
          'Work Detaile View',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'CustomFont',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(color: tileColor,
              elevation: 9,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.workdetails.worklist, // Heading for the column
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    _buildDetailRow(
                        'Staff Name           :   ',widget.workdetails.stafflist),
                    _buildDetailRow(
                        'Customer Name   :   ', widget.workdetails.name),
                    _buildDetailRow('Location                :   ',
                        widget.workdetails.location),
                    _buildDetailRow('Apartment             :   ',
                        widget.workdetails.apartment),
                    _buildDetailRow('Total Amount        :  ',
                        '${int.parse(widget.workdetails.day) * int.parse(widget.workdetails.amount)}'),
                    GestureDetector(onTap: () => _makePhoneCall(widget.workdetails.phonenumber),
                      child: _buildDetailRow(
                          'Phone Number     :   ', widget.workdetails.phonenumber),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ExpansionTile(
                      collapsedBackgroundColor: Color.fromARGB(22, 82, 57, 57),
                      title: Text('Remarks'),
                      children: [Text(widget.workdetails.remarks!)],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.workdetails.date,style: TextStyle(color: Colors.white70),),
                        SizedBox(
                          height: 30,
                          child: ToggleButtons(
        borderRadius: BorderRadius.circular(10),
        isSelected: _isSelected,
        onPressed: (index) {
          for (int i = 0; i < _isSelected.length; i++) {
            setState(() {
              _isSelected[i] = i == index;
              selectedIndex = index;
            });
          }
          // Update the paid status based on the selected index
          widget.workdetails.paidstatus = !widget.workdetails.paidstatus; // Assuming index 0 represents Paid
          editWork(widget.workdetails);
        },
        children: [
          Text('Paid'),
          Text('UnPaid'),
        ],
        fillColor: selectedIndex == 0
            ? const Color.fromARGB(255, 27, 94, 29) // Paid green
            : const Color.fromARGB(255, 187, 18, 5), // Set color
        // Set selected color
        color: Colors.black,
        selectedColor: Colors.white,
      ),
                        ),
        //              InkWell(
        //   splashColor: Colors.red,
        //   onTap: () {
        //     setState(() {
        //       widget..workdetails.paidstatus = !widget.workdetails.paidstatus;
        //     });
        //     editWork(widget.workdetails);
        //   },
        //   child: Icon(
        //     Icons.check_circle_rounded,
        //     color: widget.workdetails.paidstatus ? Colors.green : Color.fromARGB(255, 180, 49, 40),
        //   ),
        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white70),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
        ],
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