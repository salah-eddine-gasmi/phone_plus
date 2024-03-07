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
  Function(DateTime date, String number)? outgoingCallRingingHandler;
  Function(DateTime date, String number)? outgoingCallDialingHandler;
  Function(DateTime date, String number)? outgoingCallCancelledHandler;
  Function(DateTime date, String number)? outgoingCallErrorHandler;
  Function(DateTime date, String number)? outgoingCallConnectingHandler;
  Function(DateTime date, String number)? outgoingCallConnectedHandler;
  Function(DateTime date, String number)? outgoingCallTimedOutHandler;
  Function(DateTime date, String number)? outgoingCallDisconnectedHandler;
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

  void setOutgoingCallRingingHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallRingingHandler = handler;
  }

  void setOutgoingCallDialingHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallDialingHandler = handler;
  }

  void setOutgoingCallCancelledHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallCancelledHandler = handler;
  }

  void setOutgoingCallErrorHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallErrorHandler = handler;
  }

  void setOutgoingCallConnectingHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallConnectingHandler = handler;
  }

  void setOutgoingCallConnectedHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallConnectedHandler = handler;
  }

  void setOutgoingCallTimedOutHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallTimedOutHandler = handler;
  }

  void setOutgoingCallDisconnectedHandler(
      Function(DateTime date, String number) handler) {
    outgoingCallDisconnectedHandler = handler;
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
      case "onOutgoingCallRinging":
        if (outgoingCallRingingHandler != null) {
          outgoingCallRingingHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallDialing":
        if (outgoingCallDialingHandler != null) {
          outgoingCallDialingHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallCancelled":
        if (outgoingCallCancelledHandler != null) {
          outgoingCallCancelledHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallError":
        if (outgoingCallErrorHandler != null) {
          outgoingCallErrorHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallConnecting":
        if (outgoingCallConnectingHandler != null) {
          outgoingCallConnectingHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallConnected":
        if (outgoingCallConnectedHandler != null) {
          outgoingCallConnectedHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallTimedOut":
        if (outgoingCallTimedOutHandler != null) {
          outgoingCallTimedOutHandler!(
              DateTime.fromMillisecondsSinceEpoch(call.arguments["Date"]),
              call.arguments["Number"]);
        }
        break;
      case "onOutgoingCallDisconnected":
        if (outgoingCallDisconnectedHandler != null) {
          outgoingCallDisconnectedHandler!(
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
