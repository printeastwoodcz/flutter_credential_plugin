package cz.printeastwood.flutter_credential_picker

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterCredentialPickerPlugin */
class FlutterCredentialPickerPlugin: FlutterPlugin, MethodCallHandler , ActivityAware {

  private var activity: Activity? = null
  private var activityBinding: ActivityPluginBinding? = null
  private var delegate: FlutterCredentialPickerDelegate? = null

  private lateinit var channel : MethodChannel

  private fun setupEngine(messenger: BinaryMessenger) {
    val channel = MethodChannel(messenger, CHANNEL)
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    setupEngine(flutterPluginBinding.binaryMessenger)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "pickPhoneNumber" -> delegate?.pickPhoneNumber(call, result)
      "pickEmail" -> delegate?.pickEmail(call, result)
      "pickGoogleAccount" -> delegate?.pickGoogleAccount(call, result)
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)

  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    activityBinding = binding
    delegate = FlutterCredentialPickerDelegate(activity!!)
    activityBinding?.addActivityResultListener(delegate!!)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    delegate?.let {
      activityBinding?.removeActivityResultListener(it);
    }

    activityBinding = null;
    delegate = null;
  }

}
