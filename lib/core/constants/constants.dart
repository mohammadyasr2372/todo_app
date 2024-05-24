import 'package:shared_preferences/shared_preferences.dart';

import '../../config/di.dart';

String? token = config.get<SharedPreferences>().getString('token');
int? userId = config.get<SharedPreferences>().getInt('userId');

const String baseUrl =
    'https://dummyjson.com';

late double width;
late double height;
