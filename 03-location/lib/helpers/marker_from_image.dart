import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

Future<BitmapDescriptor> getMarkerFromImage() async {
  return BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(devicePixelRatio: 2.5),
    'assets/custom-pin.png',
  );
}

Future<BitmapDescriptor> getMarkerFromNetwordImage() async {
  const imageUrl =
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png';
  final resp = await Dio()
      .get(imageUrl, options: Options(responseType: ResponseType.bytes));
  if (resp.statusCode != 200) {
    return getMarkerFromImage();
  }
  //Resize network image
  final imageCodec = await ui.instantiateImageCodec(resp.data,
      targetHeight: 130, targetWidth: 130);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
