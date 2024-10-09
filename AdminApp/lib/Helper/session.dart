// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_image.dart';
import 'package:dortodorpartner/Helper/string.dart';

Future<bool> isNetworkAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

void showSnackBar(context, msg) {
  final snackBar = SnackBar(
    content: Text(
      msg,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: colors.white),
    ),
    backgroundColor: colors.primary,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Future<Uint8List?> getBytesFromAsset(String path, int width) async {
//   ByteData data = await rootBundle.load(path);
//   Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
//       targetWidth: width, allowUpscaling: true);
//   FrameInfo fi = await codec.getNextFrame();
//   return (await fi.image.toByteData(format: ImageByteFormat.png))
//       ?.buffer
//       .asUint8List();
// }

noInternet(context, onTap) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        "assets/icons/no-internet.svg",
        width: 120,
        colorFilter: const ColorFilter.mode(colors.primary, BlendMode.srcIn),
      ),
      Text(
        'No Connection',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Text(
          'Your Internet Connection was interrupted, Please retry',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
      CommonButton(
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        text: 'Retry',
        width: 120,
        onTap: () => onTap,
      ),
    ],
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

commonValidator(value, msg) {
  if (value == null || value.isEmpty) {
    return msg;
  }
  return null;
}

emailValidator(value, msg) {
  if (value.isEmpty) {
    return '$msg email address cannot be empty';
  } else if (!value.toString().isEmail) {
    return 'Enter a valid email address';
  }
  return null;
}

phoneValidator(value, msg) {
  if (value.isEmpty) {
    return '$msg phone number cannot be empty';
  } else if (value.length != 10) {
    return '$msg phone number should be 10 digits';
  }
  return null;
}

///
/// Converting date and time format
///
convertStringTime(outputFormat, inputFormat, string) {
  initializeDateFormatting();
  return DateFormat(outputFormat, Get.locale.toString())
      .format(DateFormat(inputFormat).parse(string));
}

///
/// Converting minutes to hours
///
String minuteToHourString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  if (int.parse(parts[0]) == 0) {
    return '${int.parse(parts[1].padLeft(2))} min';
  } else if (int.parse(parts[1]) == 0) {
    return '${int.parse(parts[0].padLeft(2))} hr';
  } else {
    return '${int.parse(parts[0].padLeft(2))} hr ${int.parse(parts[1].padLeft(2))} min';
  }
}

///
/// post method
/// returning the values according to the response of restAPI
/// { status code 200 or not , status code , response body }
///
getAPI(context, url) async {
  try {
    var response = await get(
      Uri.parse('$baseUrl$url'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000"
      },
    );
    debugPrint("Rest API Url : ${response.request!.url}");
    debugPrint("Rest API Response : ${response.body}");
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return {
        "status": true,
        "statusCode": response.statusCode,
        "data": response.body
      };
    } else {
      return {"status": false, "statusCode": response.statusCode};
    }
  } on SocketException {
    return showSnackBar(context, "noInternetConnection".tr);
  } on HttpException {
    return showSnackBar(context, "couldFind".tr);
  } on FormatException {
    return showSnackBar(context, "badResponseMsg".tr);
  }
}

///
/// post method
/// returning the values according to the response of restAPI
/// { status code 200 or not , status code , response body }
///
postAPI(context, url, encodedData) async {
  try {

    var response = await post(
      Uri.parse('$baseUrl$url'),
      body: encodedData,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000"
      },
    );
    debugPrint("Rest API Url : ${response.request!.url}");
    debugPrint('Rest API Body : $encodedData');
    debugPrint("Rest API Response : ${response.body}");
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return {
        "status": true,
        "statusCode": response.statusCode,
        "data": response.body
      };
    } else {
      return {"status": false, "statusCode": response.statusCode};
    }
  } on SocketException {
    return showSnackBar(context, "noInternetConnection".tr);
  } on HttpException {
    return showSnackBar(context, "couldFind".tr);
  } on FormatException {
    return showSnackBar(context, "badResponseMsg".tr);
  }
}

///
/// multipart post method
/// returning the values according to the response of restAPI
/// { status code 200 or not , status code , response body }
///
multipartPostAPI(context, url, List data, file) async {
  debugPrint('Rest API Body : $data');
  final Map<String, String> httpHeaders = {
    HttpHeaders.contentTypeHeader: "multipart/form-data",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$url'));
  for (var i = 0; i < data.length; i++) {
    request.fields[data[i]['name']] = data[i]['value'];
  }
  debugPrint('Request Fields : ${request.fields}');
  request.headers.addAll(httpHeaders);
  if (file != null) {
    request.files.add(
      http.MultipartFile(
        'image',
        File(file.path).readAsBytes().asStream(),
        File(file.path).lengthSync(),
        filename: file.path.split("/").last,
        contentType: MediaType('image', 'png'),
      ),
    );
  }
  debugPrint("Sending files are $file");
  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    debugPrint("Called Rest API is : ${response.request!.url}");
    debugPrint("API response for api is : ${response.body}");

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return {
        "status": true,
        "statusCode": response.statusCode,
        "data": response.body
      };
    } else {
      return {"status": false, "statusCode": response.statusCode};
    }
  } on SocketException {
    return showSnackBar(context, "noInternetConnection".tr);
  } on HttpException {
    return showSnackBar(context, "couldFind".tr);
  } on FormatException {
    return showSnackBar(context, "badResponseMsg".tr);
  }
}

apiErrorMessage(context, statusCode) {
  if (statusCode == 400) {
    return showSnackBar(context, badRequest);
  } else if (statusCode == 404) {
    return showSnackBar(context, notFound);
  } else if (statusCode == 500) {
    return showSnackBar(context, serverError);
  } else {
    return showSnackBar(context, somethingWrong);
  }
}

///
/// logout the current user
///
logoutFunction(context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Get.offAndToNamed('/');
}

showImageFullScreen(context, url) {
  return showDialog(
    context: context,
    builder: (context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          CommonImage(
            url: url,
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

showingResultWidget(context, count) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    alignment: Alignment.center,
    child: Text(
      'Showing $count results',
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: colors.hintText),
    ),
  );
}

noDataPage(context, text) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: colors.primary,
            size: 100,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

downloadAndSaveFile(context, comingFrom, list, index, variable, url) async {
  var controller;
  // if (comingFrom == 'home') {
  //   controller = Get.put(HomeController());
  // } else if (comingFrom == 'more') {
  //   controller = Get.put(MoreController());
  // } else if (comingFrom == 'homework') {
  //   controller = Get.put(HomeWorkController());
  // } else if (comingFrom == 'announcement') {
  //   controller = Get.put(AnnouncementController());
  // }
  var isGranted = false;
  var result = await Permission.storage.status;
  debugPrint("isGranted $isGranted");
  if (result != PermissionStatus.granted) {
    debugPrint('Permission not granted');
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt > 32) {
        result = await Permission.photos.request();
      } else {
        result = await Permission.storage.request();
      }
    } else {
      result = await Permission.storage.request();
    }
  }

  if (result == PermissionStatus.granted) {
    isGranted = true;
  }
  debugPrint("isGranted $isGranted");
  if (isGranted) {
    String? downloadPath;
    final directory = await getApplicationDocumentsDirectory();
    downloadPath = directory.path;
    final savedDir = Directory(downloadPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    final request = Request('GET', Uri.parse(imgUrl + url));
    final Map<String, String> httpHeaders = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };
    request.headers.addAll(httpHeaders);
    final values = url.split('/');
    String fileName = values[values.length - 1];
    final StreamedResponse result = await Client().send(request);
    final contentLength = result.contentLength;
    List<int> bytes = [];
    final file = File("${savedDir.path}/$fileName");
    debugPrint("File name is : $file");
    result.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        list[index][variable] = downloadedLength / contentLength!;
        controller.update();
      },
      onDone: () async {
        list[index][variable] = 0.0;
        controller.update();
        await file.writeAsBytes(bytes);
        await OpenFilex.open(file.path);
      },
      onError: (e) {
        showSnackBar(context, e.toString());
      },
      cancelOnError: true,
    );
  }
}

///
/// Common download progress loader
///
percentLoader(double value) {
  return SizedBox(
    width: 100,
    child: LinearProgressIndicator(
      value: value,
      color: colors.primary,
      valueColor: const AlwaysStoppedAnimation<Color>(
        colors.primary,
      ),
    ),
  );
}

findType(context) {
  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height;
  isMobile = deviceWidth > 500 ? false : true;
}

convertToArabicNumber(numberStr) {
  // Map each digit to its Arabic equivalent
  Map<String, String> arabicDigits = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  // Split the numberStr into whole and decimal parts
  List<String> parts = numberStr.split('.');
  String wholePart = parts[0];
  String decimalPart = parts.length > 1 ? parts[1] : '';

  // Map each digit in the whole part to its Arabic equivalent
  String arabicWholePart = wholePart.split('').map((char) {
    return arabicDigits[char] ?? char;
  }).join();

  // Map each digit in the decimal part to its Arabic equivalent
  String arabicDecimalPart = decimalPart.split('').map((char) {
    return arabicDigits[char] ?? char;
  }).join();

  // Join the whole and decimal parts with the Arabic decimal separator
  String arabicNumber = arabicWholePart +
      (arabicDecimalPart.isNotEmpty ? '.$arabicDecimalPart' : '');

  return arabicNumber;
}
