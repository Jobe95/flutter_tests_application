import 'package:flutter/material.dart';
import 'package:test_application/models/show.dart';

class DetailShowPage extends StatelessWidget {
  const DetailShowPage({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(show.name ?? ''),
      ),
    );
  }
}
