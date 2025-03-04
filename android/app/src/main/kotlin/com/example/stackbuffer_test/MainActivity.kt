import io.flutter.embedding.android.FlutterFragmentActivity // <- Add this import
import android.os.Bundle
import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsLogger;

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }
}
