package cz.printeastwood.flutter_credential_picker


class CantOpenException(message: String? = "") : Exception(message) {}
class AccountsNotFoundException(message: String? = "") : Exception(message) {}
class MissingGoogleServices(message: String? = "") : Exception(message) {}
