import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credential_picker/flutter_credential_picker.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Credential credential;
  Exception error;
  @override
  void initState() {
    credential = null;
    error = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme,
      theme: lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Google Account picker'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                AccountWidget(
                  credential: credential,
                ),
                if (error != null) ErrorWidget(),
                Divider(
                  height: 64,
                ),
                OutlineButton(
                    key: ValueKey('__phoneNumberButton__'),
                    onPressed: () async {
                      setState(() => credential = null);
                      try {
                        var response = await CredentialPicker.pickPhoneNumber();
                        print('response: $response');
                        setState(() {
                          credential = response;
                          error = null;
                        });
                      } on PlatformException catch (e, s) {
                        setState(() {
                          credential = null;
                          error = e;
                        });
                        print('error: $e');
                        print('error stack: $s');
                      }
                    },
                    child: Text('Phone number')),
                OutlineButton(
                    key: ValueKey('__emailButton__'),
                    onPressed: () async {
                      try {
                        setState(() => credential = null);
                        var response = await CredentialPicker.pickEmail();
                        print('response: $response');
                        setState(() {
                          credential = response;
                          error = null;
                        });
                      } on PlatformException catch (e, s) {
                        setState(() {
                          credential = null;
                          error = e;
                        });
                        print('error: $e');
                        print('error stack: $s');
                      }
                    },
                    child: Text('Email')),
                OutlineButton(
                    key: ValueKey('__accountButton__'),
                    onPressed: () async {
                      setState(() => credential = null);
                      try {
                        var response = await CredentialPicker.pickGoogleAccount(
                            accountTypes: [
                              AccountType.google,
                              AccountType.facebook,
                              AccountType.twitter,
                              AccountType.microsoft
                            ]);
                        print('response: $response');
                        setState(() {
                          credential = response;
                          error = null;
                        });
                      } on PlatformException catch (e, s) {
                        setState(() {
                          credential = null;
                          error = e;
                        });
                        print('error: $e');
                        print('error stack: $s');
                      }
                    },
                    child: Text('Google Account')),
              ],
            )),
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  final Credential credential;
  AccountWidget({Key key, this.credential}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return listTile(context, credential);
  }

  Widget listTile(BuildContext context, Credential credential) {
    if (credential == null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Not picked yet',
          style: Theme.of(context).textTheme.button,
          textAlign: TextAlign.center,
        ),
      );
    }
    if (credential is EmailAccount) {
      return ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.email),
            backgroundColor: Theme.of(context).accentColor,
          ),
          title: Text(credential.email));
    } else if (credential is PhoneNumberAccount) {
      return ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.phone),
            backgroundColor: Theme.of(context).accentColor,
          ),
          title: Text(credential.number));
    } else if (credential is GoogleAccount) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: credential.avatar != null
              ? NetworkImage(credential.avatar)
              : null,
          backgroundColor: Theme.of(context).accentColor,
          onBackgroundImageError: (e, s) {},
          child: credential.avatar == null
              ? Center(child: Icon(Icons.person))
              : null,
        ),
        title: Text(credential.fullName),
        subtitle: Text(credential.email),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Not found',
        style: Theme.of(context).textTheme.button,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final Exception error;
  ErrorWidget({Key key, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return error == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text('${error.runtimeType}'),
              onPressed: null,
            ),
          );
  }
}

final darkTheme = ThemeData.dark();

final lightTheme =
    ThemeData.light().copyWith(textTheme: GoogleFonts.workSansTextTheme());
