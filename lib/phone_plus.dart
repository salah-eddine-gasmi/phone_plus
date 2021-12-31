import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef ErrorHandler = void Function(String message);

class PhonePlus {
  static const MethodChannel _channel = MethodChannel('com.morabaa.phone_plus');

  Function(int date, String number)? incomingCallReceivedHandler;
  Function(int date, String number)? incomingCallAnsweredHandler;
  Function(int date, String number)? incomingCallEndedHandler;
  Function(int date, String number)? outgoingCallStartedHandler;
  Function(int date, String number)? outgoingCallEndedHandler;
  Function(int date, String number)? missedCallHandler;
  ErrorHandler? errorHandler;


  PhonePlus(){
    _channel.setMethodCallHandler(platformCallHandler);
  }

  Future<dynamic> setTestMode(double seconds) => _channel.invokeMethod('phoneTest.incomingCallReceived', seconds);

  void setIncomingCallReceivedHandler(Function(int date, String number) callback) {
    incomingCallReceivedHandler = callback;
  }
  void setIncomingCallAnsweredHandler(Function(int date, String number) callback) {
    incomingCallAnsweredHandler = callback;
  }
  void setIncomingCallEndedHandler(Function(int date, String number) callback) {
    incomingCallEndedHandler = callback;
  }
  void setOutgoingCallStartedHandler(Function(int date, String number) callback) {
    outgoingCallStartedHandler = callback;
  }

  void setOutgoingCallEndedHandler(Function(int date, String number) callback) {
    outgoingCallEndedHandler = callback;
  }

  void setMissedCallHandler(Function(int date, String number) handler) {
    missedCallHandler = handler;
  }

  void setErrorHandler(ErrorHandler handler) {
    errorHandler = handler;
  }


  Future<dynamic> platformCallHandler(MethodCall call) async {
    debugPrint("platformCallHandler call ${call.method} ${call.arguments}");
    switch (call.method) {
      case "onIncomingCallReceived":
        if (incomingCallReceivedHandler != null) {
          incomingCallReceivedHandler!(call.arguments["Date"], call.arguments["Number"]);
        }
        break;
      case "onIncomingCallAnswered":
        if (incomingCallAnsweredHandler != null) {
          incomingCallAnsweredHandler!(call.arguments["Date"], call.arguments["Number"]);
        }
        break;
      case "onIncomingCallEnded":
        if (incomingCallEndedHandler != null) {
          incomingCallEndedHandler!(call.arguments["Date"], call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallStarted":
        if (outgoingCallStartedHandler != null) {
          outgoingCallStartedHandler!(call.arguments["Date"], call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallEnded":
        if (outgoingCallEndedHandler != null) {
          outgoingCallEndedHandler!(call.arguments["Date"], call.arguments["Number"]);
        }
        break;
      case "onMissedCall":
        if (missedCallHandler != null) {
          missedCallHandler!(call.arguments["Date"], call.arguments["Number"]);
        }
        break;
      case "onError":
        if (errorHandler != null) {
          errorHandler!(call.arguments);
        }
        break;
      default:
        debugPrint('Unknowm method ${call.method} ');
    }
  }

}
