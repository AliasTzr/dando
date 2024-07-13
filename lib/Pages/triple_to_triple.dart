import 'package:flutter/material.dart';

class TripleToTriple extends StatelessWidget {
  const TripleToTriple({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amberAccent,
    );
  }
}