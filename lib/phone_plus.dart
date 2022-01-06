import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef ErrorHandler = void Function(String message);

class PhonePlus {
  static const MethodChannel _channel = MethodChannel('com.morabaa.phone_plus');

  Function(DateTime date, String number)? incomingCallReceivedHandler;
  Function(DateTime date, String number)? incomingCallAnsweredHandler;
  Function(DateTime date, String number)? incomingCallEndedHandler;
  Function(DateTime date, String number)? outgoingCallStartedHandler;
  Function(DateTime date, String number)? outgoingCallEndedHandler;
  Function(DateTime date, String number)? missedCallHandler;
  ErrorHandler? errorHandler;

  PhonePlus() {
    _channel.setMethodCallHandler(platformCallHandler);
  }

  Future<dynamic> setTestMode(double seconds) =>
      _channel.invokeMethod('phoneTest.incomingCallReceived', seconds);

  void setIncomingCallReceivedHandler(
      Function(DateTime date, String number) callback) {
    incomingCallReceivedHandler = callback;
  }

  void setIncomingCallAnsweredHandler(
      Function(DateTime date, String number) callback) {
    incomingCallAnsweredHandler = callback;
  }

  void setIncomingCallEndedHandler(
      Function(DateTime date, String number) callback) {
    incomingCallEndedHandler = callback;
  }

  void setOutgoingCallStartedHandler(
      Function(DateTime date, String number) callback) {
    outgoingCallStartedHandler = callback;
  }

  void setOutgoingCallEndedHandler(
      Function(DateTime date, String number) callback) {
    outgoingCallEndedHandler = callback;
  }

  void setMissedCallHandler(Function(DateTime date, String number) handler) {
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
          incomingCallReceivedHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onIncomingCallAnswered":
        if (incomingCallAnsweredHandler != null) {
          incomingCallAnsweredHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onIncomingCallEnded":
        if (incomingCallEndedHandler != null) {
          incomingCallEndedHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallStarted":
        if (outgoingCallStartedHandler != null) {
          outgoingCallStartedHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallEnded":
        if (outgoingCallEndedHandler != null) {
          outgoingCallEndedHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onMissedCall":
        if (missedCallHandler != null) {
          missedCallHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
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
