package cz.printeastwood.flutter_credential_picker

const val FLUTTER_CREDENTIALS_RESULT = 1001
const val CHANNEL = "cz.printeastwood.flutter_credential_picker/flutter_credential_picker"
enum class PickerType(s: String) {
    Email("email"),PhoneNumber("phone_number"), GoogleAccount("google_account")
}
const val ERROR_NOT_FOUND = "NOT_FOUND_CODE"
const val ERROR_CANT_PICK = "CANT_PICK_CODE"
const val ERROR_CANT_OPEN = "CANT_OPEN_CODE"
const val ERROR_MISSING_GOOGLE_SERVICE = "MISSING_GOOGLE_SERVICE"