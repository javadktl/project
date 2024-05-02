import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  String label;
  TextEditingController controller;
  String? Function(String?)? validator;
  int? multiLine;
  double? height;
  TextInputType keyboard;
  Widget? suffixIcon; 
  bool? readonly;
  
  
  Input(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      this.multiLine = 1,
      this.height = 45,
      this.keyboard=TextInputType.name,
      this.suffixIcon,
       this.readonly=false,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: AlignmentDirectional.topStart,
            child: Text('    $label')),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          maxLines: multiLine,
          cursorHeight: 20,
          controller: controller,
          keyboardType: keyboard,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,contentPadding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
             suffixIcon:suffixIcon,
             
          ),
          validator: validator,
         
        
        )
      ],
    );
  }
}
