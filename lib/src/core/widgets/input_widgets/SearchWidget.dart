import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController textController;
  const SearchWidget({
    required this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ],
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
          controller: textController,
          onChanged: (value) {
            //Do something wi
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[500]!,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Search",
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w300),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(45.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(45.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(45.0)),
            ),
          ),
        ),
      ),
    );
  }
}
