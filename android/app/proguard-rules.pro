# Keep only ML Kit core + Latin text recognition
-keep class com.google.mlkit.vision.text.TextRecognizer { *; }
-keep class com.google.mlkit.vision.text.latin.** { *; }
-dontwarn com.google.mlkit.**
