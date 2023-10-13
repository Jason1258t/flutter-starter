package com.example.starter
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("2c69b782-22fd-4a53-a1e9-f1c25adc461b") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
