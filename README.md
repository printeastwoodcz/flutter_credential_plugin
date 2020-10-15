# flutter_credential_picker

**Credential picker for Google Service**

You can get your phone number without adding a phone permission to your app. Also you can get email or account info directly from your phone.

## Supported platforms

This picker is **Android only**

## Getting Started


add plugin to your pubspec.yaml

```yaml
flutter_credential_picker: ^0.0.1
```
## Implementation
### Get Phone number
```dart
CredentialPicker.pickPhoneNumber().then((value)=> setState((){
    _credential = value
}));
```
or
```dart
try{
    final result = CredentialPicker.pickPhoneNumber();
    setState((){
        _credential = result
    }
} on NotFoundException catch(_){
    ...
}
} on AccountsNotFound catch(_){
    ...
}
} on NotSupportedPlatform catch(_){
    ...
}
} on MissingGoogleService catch(_){
    ...
}
```

### Get Email address
```dart
CredentialPicker.pickEmail().then((value)=> setState((){
    _credential = value
}));
```
or
```dart
try{
    final result = CredentialPicker.pickEmail();
    setState((){
        _credential = result
    }
} on NotFoundException catch(_){
    ...
}
} on AccountsNotFound catch(_){
    ...
}
} on NotSupportedPlatform catch(_){
    ...
}
} on MissingGoogleService catch(_){
    ...
}
```

### Get Account

You can specify account types query, default value is AccountType.google only

```dart
/// default accountTypes is [AccountType.google]
CredentialPicker.pickGoogleAccount().then((value)=> setState((){
    _credential = value
}));
/// or you can add more supported account types as list
CredentialPicker.pickGoogleAccount(accountTypes: [
                              AccountType.google,
                              AccountType.facebook,
                              AccountType.twitter,
                              AccountType.microsoft
                            ]).then((value)=> setState((){
    _credential = value
}));
```

or
```dart
try{
    final result = CredentialPicker.pickGoogleAccount(accountTypes: [
                              AccountType.google,
                              AccountType.facebook,
                              AccountType.twitter,
                              AccountType.microsoft
                            ]);
    setState((){
        _credential = result
    }
} on NotFoundException catch(_){
    ...
}
} on AccountsNotFound catch(_){
    ...
}
} on NotSupportedPlatform catch(_){
    ...
}
} on MissingGoogleService catch(_){
    ...
}
```