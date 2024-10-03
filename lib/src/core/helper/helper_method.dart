import 'package:flutter/foundation.dart';

kPrint(dynamic message){
  if (kDebugMode) {
    print(message);
  }
}