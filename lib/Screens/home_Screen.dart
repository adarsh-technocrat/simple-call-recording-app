import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../Constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text("Simple Call Recording"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(bottom: 100),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, -1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.call,
                  size: 40,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 80),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(08),
                        bottomLeft: Radius.circular(08),
                      ),
                      color: Color(0xff5456AB),
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(08),
                          bottomLeft: Radius.circular(08),
                        ),
                        onTap: () {
                          _enablecallrecording();
                          Fluttertoast.showToast(
                              msg: "Call Recording STARTED",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Constants.recordbuttonColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Container(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.voicemail,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(08),
                        bottomRight: Radius.circular(08),
                      ),
                      color: Color(0xff932A42),
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(08),
                          bottomRight: Radius.circular(08),
                        ),
                        onTap: () {
                          _disablecallrecording();
                          Fluttertoast.showToast(
                              msg: "Call Recording STOPED",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Constants.recordstopColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Container(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const platform =
      const MethodChannel('samples.flutter.dev/callrecording');

  Future<dynamic> _enablecallrecording() async {
    try {
      final result = await platform.invokeMethod('getcallrecording');

      return result;
    } on PlatformException catch (e) {
      return "Failed to enable recording : '${e.message}'.";
    }
  }

  Future<dynamic> _disablecallrecording() async {
    try {
      final result = await platform.invokeMethod('stopcallrecording');

      return result;
    } on PlatformException catch (e) {
      return "Failed to disable recording : '${e.message}'.";
    }
  }
}
