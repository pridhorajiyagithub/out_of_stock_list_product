import 'dart:async';
import 'dart:typed_data';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:out_of_stock_product/provider/add_to_cart.dart';
import 'package:out_of_stock_product/views/screens.dart';
import 'package:provider/provider.dart';
import 'db helper.dart';
import 'model/product.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductProvider(),
      )
    ],
    builder: (context, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      );
    },
  ));
}
