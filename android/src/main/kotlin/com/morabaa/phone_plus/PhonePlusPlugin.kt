package com.morabaa.phone_plus

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*
import kotlin.collections.ArrayList

/** PhonePlusPlugin */
class PhonePlusPlugin: FlutterPlugin, MethodCallHandler, BroadcastReceiver() {
  private lateinit var context: Context
  companion object {
    lateinit var methodChannel: MethodChannel
    private var lastState = TelephonyManager.EXTRA_STATE_IDLE
    private var isIncoming = false
  }

  private fun setup(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    val plugin = PhonePlusPlugin()
    methodChannel = MethodChannel(binding.binaryMessenger, "com.morabaa.phone_plus")
    plugin.context = binding.applicationContext
    methodChannel.setMethodCallHandler(plugin)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    setup(binding = flutterPluginBinding)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method.equals("phoneTest.incomingCallReceived")) {
      Log.d("CallObserver", "phoneIncoming Test implementation")
      // TODO: test mode with seconds to wait as parameter
    } else {
      result.notImplemented()
    }
  }

  private val arguments: HashMap<String, Any> = HashMap()


  @SuppressLint("UnsafeProtectedBroadcastReceiver")
  override fun onReceive(context: Context?, intent: Intent) {
    Log.d("CallObserver", "CallReceiver is starting ....")

    var keyList: List<String?> = ArrayList()
    val bundle = intent.extras
    if (bundle != null) {
      keyList = ArrayList(bundle.keySet())
      Log.e("CallObserver", "keys : $keyList")
    }

    if (keyList.contains("incoming_number")) {
      val phoneState = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
      val phoneIncomingNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)
      val phoneOutgoingNumber = intent.getStringExtra(Intent.EXTRA_PHONE_NUMBER)
      val phoneNumber = phoneOutgoingNumber ?: (phoneIncomingNumber
              ?: "")
      if (phoneState != null && phoneNumber != "") {
        if (lastState == phoneState) {
          // No change, debounce extras
          return
        }
        Log.d("CallObserver", "State Changed>>>>>> $phoneState")
        arguments["Date"] = System.currentTimeMillis()
        if(phoneNumber!="") arguments["Number"] = phoneNumber
        if (TelephonyManager.EXTRA_STATE_RINGING == phoneState) {
          isIncoming = true
          lastState = TelephonyManager.EXTRA_STATE_RINGING
          onIncomingCallReceived()
        } else if (TelephonyManager.EXTRA_STATE_IDLE == phoneState) {
          if (lastState == TelephonyManager.EXTRA_STATE_RINGING) {
            lastState = TelephonyManager.EXTRA_STATE_IDLE
            onMissedCall()
          } else {
            if (isIncoming) {
              lastState = TelephonyManager.EXTRA_STATE_IDLE
              onIncomingCallEnded()
            } else {
              lastState = TelephonyManager.EXTRA_STATE_IDLE
              onOutgoingCallEnded()
            }
          }
        } else if (TelephonyManager.EXTRA_STATE_OFFHOOK == phoneState) {
          isIncoming = lastState.equals(TelephonyManager.EXTRA_STATE_RINGING)
          lastState = TelephonyManager.EXTRA_STATE_OFFHOOK
          if(isIncoming) {
            onIncomingCallAnswered()
          } else {
            onOutgoingCallStarted()
          }
        } else if (phoneState == "RINGING") {
          // Ringing state for outgoing call
          onOutgoingCallRinging()
        } else if (phoneState == "DIALING") {
          // Dialing state for outgoing call
          onOutgoingCallDialing()
        } else if (phoneState == "CANCELLED") {
          // Call cancelled state for outgoing call
          onOutgoingCallCancelled()
        } else if (phoneState == "ERROR") {
          // Call error state for outgoing call
          onOutgoingCallError()
        } else if (phoneState == "CONNECTING") {
          // Call connecting state for outgoing call
          onOutgoingCallConnecting()
        } else if (phoneState == "CONNECTED") {
          // Call connected state for outgoing call
          onOutgoingCallConnected()
        } else if (phoneState == "TIMED_OUT") {
          // Call timed out state for outgoing call
          onOutgoingCallTimedOut()
        } else if (phoneState == "DISCONNECTED") {
          // Call disconnected state for outgoing call
          onOutgoingCallDisconnected()
        }
      }
    }
  }

  private fun onIncomingCallReceived() {
        Log.d("CallObserver", "onIncomingCallReceived  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onIncomingCallReceived", arguments)
  }
  private fun onIncomingCallAnswered() {
    Log.d("CallObserver", "onIncomingCallAnswered  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onIncomingCallAnswered", arguments)
  }
  private fun onIncomingCallEnded() {
    Log.d("CallObserver", "onIncomingCallEnded  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onIncomingCallEnded", arguments)
  }

  private fun onOutgoingCallStarted() {
    Log.d("CallObserver", "onOutgoingCallStarted  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallStarted", arguments)
  }
  private fun onOutgoingCallEnded() {
    Log.d("CallObserver", "onOutgoingCallEnded  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallEnded", arguments)
  }

  private fun onOutgoingCallRinging() {
    Log.d("CallObserver", "onOutgoingCallRinging  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallRinging", arguments)
  }

  private fun onOutgoingCallDialing() {
    Log.d("CallObserver", "onOutgoingCallDialing  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallDialing", arguments)
  }

  private fun onOutgoingCallCancelled() {
    Log.d("CallObserver", "onOutgoingCallCancelled  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallCancelled", arguments)
  }

  private fun onOutgoingCallError() {
    Log.d("CallObserver", "onOutgoingCallError  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallError", arguments)
  }

  private fun onOutgoingCallConnecting() {
    Log.d("CallObserver", "onOutgoingCallConnecting  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallConnecting", arguments)
  }

  private fun onOutgoingCallConnected() {
    Log.d("CallObserver", "onOutgoingCallConnected  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallConnected", arguments)
  }

  private fun onOutgoingCallTimedOut() {
    Log.d("CallObserver", "onOutgoingCallTimedOut  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallTimedOut", arguments)
  }

  private fun onOutgoingCallDisconnected() {
    Log.d("CallObserver", "onOutgoingCallDisconnected  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onOutgoingCallDisconnected", arguments)
  }

  private fun onMissedCall() {
    Log.d("CallObserver", "onMissedCall  :   number is  : ${arguments["Number"]}")
    methodChannel.invokeMethod("onMissedCall", arguments)
  }
}
