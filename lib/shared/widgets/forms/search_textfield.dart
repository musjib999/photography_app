import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextFormField(
        controller: TextEditingController(),
        decoration: const InputDecoration(
          hintText: 'Search For Food',
          hintStyle: TextStyle(fontFamily: 'SourceSansPro'),
          prefixIcon: Icon(Icons.search),
          fillColor: Colors.white,
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
