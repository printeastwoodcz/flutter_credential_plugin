package cz.printeastwood.flutter_credential_picker


import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Context
import android.content.Intent
import android.content.IntentSender.SendIntentException
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat.startIntentSenderForResult
import androidx.core.content.ContextCompat.getSystemService
import com.google.android.gms.auth.api.credentials.*
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import javax.annotation.meta.When


class FlutterCredentialPickerDelegate(private var activity: Activity) : PluginRegistry.ActivityResultListener {
    private var pendingResult: MethodChannel.Result? = null
    private var mCredentialsClient: CredentialsClient = Credentials.getClient(this.activity)

    init {
        mCredentialsClient.disableAutoSignIn()
    }
    private fun isGooglePlayServicesAvailable(): Boolean {
        val status = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(activity)
        return status == ConnectionResult.SUCCESS
    }

    fun pickPhoneNumber(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result){
        pendingResult = result
        if (!isGooglePlayServicesAvailable()){
            finishWithError(ERROR_MISSING_GOOGLE_SERVICE, "missing google service", MissingGoogleServices())
            return
        }
        val hintRequest = HintRequest.Builder()
                .setHintPickerConfig(
                        CredentialPickerConfig.Builder()
                                .setShowCancelButton(true)
                                .build())
                .setIdTokenRequested(true)
                .setPhoneNumberIdentifierSupported(true)
                .build();
        pick(hintRequest)
    }

    fun pickEmail(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result){
        pendingResult = result
        if (!isGooglePlayServicesAvailable()){
            finishWithError(ERROR_MISSING_GOOGLE_SERVICE, "missing google service", MissingGoogleServices())
            return
        }
        val hintRequest = HintRequest.Builder()
                .setHintPickerConfig(
                        CredentialPickerConfig.Builder()
                                .setShowCancelButton(true)
                                .build())
                .setEmailAddressIdentifierSupported(true)
                .setIdTokenRequested(true)
                .build();
        pick(hintRequest)
    }

    fun pickGoogleAccount(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result){
        var items = mutableListOf<String>()
        val accountTypes = call.argument<List<String>>("account_types")
        for( item in accountTypes ?: emptyList()){
            when(item){
                "GOOGLE"-> IdentityProviders.GOOGLE
                "FACEBOOK"-> IdentityProviders.FACEBOOK
                "MICROSOFT"-> IdentityProviders.MICROSOFT
                "TWITTER"-> IdentityProviders.TWITTER
                "LINKEDIN"-> IdentityProviders.LINKEDIN
                "PAYPAL"-> IdentityProviders.PAYPAL
                "YAHOO"-> IdentityProviders.YAHOO
                else-> null
            }?.let { items.add(it) }
        }
        if (items.isEmpty()){
            items.add(IdentityProviders.GOOGLE)
        }
        pendingResult = result
        if (!isGooglePlayServicesAvailable()){
            finishWithError(ERROR_MISSING_GOOGLE_SERVICE, "missing google service", MissingGoogleServices())
            return
        }
        val hintRequest = HintRequest.Builder()
                .setHintPickerConfig(
                        CredentialPickerConfig.Builder()
                                .setShowCancelButton(true)
                                .build())
                .setIdTokenRequested(true)
                .setAccountTypes(*items.toTypedArray())
                .build();
        pick(hintRequest)
    }

    private fun pick(request: HintRequest){
        val intent = mCredentialsClient.getHintPickerIntent(request)
        try {
            startIntentSenderForResult(activity, intent.intentSender, FLUTTER_CREDENTIALS_RESULT, null, 0, 0, 0, null)
        } catch (e: SendIntentException) {
            finishWithError(ERROR_CANT_OPEN, "Can't open intent", CantOpenException())
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == FLUTTER_CREDENTIALS_RESULT) {
            return if (resultCode == RESULT_OK) {
                val credential: Credential? = data?.getParcelableExtra(Credential.EXTRA_KEY)
                credential?.let {
                    finishWithSuccess(it)
                }?: finishWithError(ERROR_CANT_PICK, "empty data", AccountsNotFoundException())
                true
            } else {
                finishWithError(ERROR_NOT_FOUND, "empty data", AccountsNotFoundException())
                true
            }
        }
        return false
    }
    private fun finishWithSuccess(credential: Credential) {
        val response = mapOf<String, Any>(
                "id" to (credential.id ?: ""),
                "name" to (credential.name ?: ""),
                "profilePictureUri" to (credential.profilePictureUri?.toString() ?: ""),
                "password" to (credential.password ?: ""),
                "accountType" to (credential.accountType ?: ""),
                "givenName" to (credential.givenName ?: ""),
                "familyName" to (credential.familyName ?: ""),
                "tokens" to credential.idTokens.map {
                    hashMapOf<String, Any?>(
                            "idToken" to it.idToken,
                            "accountType" to it.accountType)
                }.toList()
        )
        pendingResult?.success(response)
        clearMethodCallAndResult()
    }

    private fun finishWithError(errorCode: String, errorMessage: String, throwable: Throwable) {
        pendingResult?.error(errorCode, errorMessage, throwable)
        clearMethodCallAndResult()
    }
    private fun clearMethodCallAndResult() {
        pendingResult = null
    }
}