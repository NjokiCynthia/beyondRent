import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:dio/dio.dart';

String ipAddress = 'https://kodi.sandbox.co.ke';
// Color Themes
Color mintyGreen = const Color.fromRGBO(13, 201, 150, 1);

String propertyName = 'Elgon Court';
String propertyUser = 'Cynthia Njoki';
String propertyUserPhone = '+254721882694';
String propertyUserEmail = 'cynthia@gmail.com';

PersistentTabController bottomNavigationController =
    PersistentTabController(initialIndex: 0);

class AppTextStyles {
  static final TextStyle headerBig = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: Colors.black.withOpacity(0.8),
  );
  static final TextStyle header = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final TextStyle smallHeaderSlightlyBold = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final TextStyle normal = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
  );
  static final TextStyle titleNormalBold = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle normalGreen = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.green,
  );

  static final TextStyle small = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.grey,
  );

  static final TextStyle smallBold = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
}

// Media screen height & width
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio();

  Future<dynamic> post(String path, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post('$ipAddress$path',
          data: data, options: Options(headers: headers));
      return response.data;
    } on DioException catch (error) {
      return error.response?.data;
    }
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get('$ipAddress$path',
          queryParameters: queryParameters, options: Options(headers: headers));
      return response.data;
    } on DioException catch (error) {
      return error.response;
    }
  }
}
