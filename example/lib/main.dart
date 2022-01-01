import 'package:flutter/material.dart';
import 'package:phone_plus/phone_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

enum PhonePlusState { incomingReceived, incomingAnswered, incomingEnded, outgoingStarted, outgoingEnded, missedCall, none, error }

class _MyAppState extends State<MyApp> {

  late PhonePlus  phonePlus;
  late PhonePlusState phonePlusState;

  String  phonePlusStateLog = "";

  @override
  initState() {
    super.initState();
    initPhonecallstate();
  }

  void initPhonecallstate() async {
    debugPrint("PhonePlus init");

    phonePlus = PhonePlus();
    phonePlusState = PhonePlusState.none;


    phonePlus.setIncomingCallReceivedHandler((date, number) {
      phonePlusState = PhonePlusState.incomingReceived;
      updateStatus(phonePlusState, date, number);
    });

    phonePlus.setIncomingCallAnsweredHandler((date, number) {
      phonePlusState = PhonePlusState.incomingAnswered;
      updateStatus(phonePlusState, date, number);
    });

    phonePlus.setIncomingCallEndedHandler((date, number) {
      phonePlusState = PhonePlusState.incomingEnded;
      updateStatus(phonePlusState, date, number);
    });

    phonePlus.setOutgoingCallStartedHandler((date, number) {
      phonePlusState = PhonePlusState.outgoingStarted;
      updateStatus(phonePlusState, date, number);
    });

    phonePlus.setOutgoingCallEndedHandler((date, number) {
      phonePlusState = PhonePlusState.outgoingEnded;
      updateStatus(phonePlusState, date, number);
    });

    phonePlus.setMissedCallHandler((date, number) {
      phonePlusState = PhonePlusState.missedCall;
      updateStatus(phonePlusState, date, number);
    });

    phonePlus.setErrorHandler((msg) {
      phonePlusState = PhonePlusState.error;
      phonePlusStateLog =  phonePlusStateLog.toString() + phonePlusState.toString() + msg;
    });
  }

  String generateDebug(PhonePlusState state, int date, String number){
    return "<<<<<<<< $state >>>>>>>> ${DateTime.fromMillisecondsSinceEpoch(date)} $number \n";
  }

  void updateStatus(PhonePlusState state, int date, String number) {
    setState(() {
      String log = generateDebug(state, date, number);
      debugPrint(log);
      phonePlusStateLog =  phonePlusStateLog.toString() + log;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Phone Plus Example App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Last state:\n$phonePlusStateLog'),
        ),
      ),
    );
  }
}
