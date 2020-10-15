import Flutter
import UIKit

let CHANNEL = "cz.printeastwood.flutter_credential_picker/flutter_credential_picker"
enum PickerType {
    case Email,PhoneNumber, GoogleAccount
}
let ERROR_NOT_FOUND = "NOT_FOUND_CODE"
let ERROR_CANT_PICK = "CANT_PICK_CODE"
let ERROR_CANT_OPEN = "CANT_OPEN_CODE"

public class SwiftFlutterCredentialPickerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_credential_picker", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterCredentialPickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case "pickPhoneNumber":
          result(FlutterError(code: ERROR_NOT_FOUND , message: "", details: ""))
        break
      case "pickEmail":
          result(FlutterError(code: ERROR_NOT_FOUND , message: "", details: ""))
        break
      case "pickGoogleAccount":
          result(FlutterError(code: ERROR_NOT_FOUND , message: "", details: ""))
        break
      default:
          result(FlutterError(code: ERROR_NOT_FOUND , message: "", details: ""))

      }

    }
}
