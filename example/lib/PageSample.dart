

import 'package:flutter/material.dart';
import 'package:pro_mana_example/Sample.dart';

class PageSample extends StatelessWidget {
    const PageSample({super.key, required this.sample});
    final Sample sample;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: sample.getSampleWidget(),
    );
  }
  
}
