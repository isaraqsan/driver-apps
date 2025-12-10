package id.act.gibas

import android.graphics.BitmapFactory
import android.graphics.Bitmap
import java.io.File
import java.io.FileOutputStream
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import java.text.DecimalFormat
import java.util.UUID

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.compress"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "compressImage") {
                val path = call.argument<String>("path")
                if (path != null) {
                    val compressedPath = compressImage(path)
                    result.success(compressedPath)
                } else {
                    result.error("INVALID_PATH", "Path is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun compressImage(path: String): String {
        val file = File(path)
        if (!file.exists()) {
            Log.e("Compress", "File tidak ditemukan: $path")
            return path
        }

        val originalSize = file.length()
        Log.i("Compress", "Ukuran asli: ${formatSize(originalSize)}")

        val originalBitmap = BitmapFactory.decodeFile(file.absolutePath)
        if (originalBitmap == null) {
            Log.e("Compress", "Gagal decode file gambar: $path")
            return path
        }

        val maxSize = 1024
        val scale = minOf(
            maxSize.toFloat() / originalBitmap.width,
            maxSize.toFloat() / originalBitmap.height,
            1f
        )
        val newWidth = (originalBitmap.width * scale).toInt()
        val newHeight = (originalBitmap.height * scale).toInt()
        val resizedBitmap = Bitmap.createScaledBitmap(originalBitmap, newWidth, newHeight, true)

        val outputDir = File(cacheDir, "compressed")
        if (!outputDir.exists()) {
            outputDir.mkdirs()
        }

        val outputFile = File(outputDir, "compressed_${UUID.randomUUID()}.jpg")

        try {
            val outputStream = FileOutputStream(outputFile)
            resizedBitmap.compress(Bitmap.CompressFormat.JPEG, 75, outputStream)
            outputStream.flush()
            outputStream.close()
        } catch (e: Exception) {
            Log.e("Compress", "Gagal simpan file: ${e.message}")
            return path
        }

        val compressedSize = outputFile.length()
        Log.i("Compress", "Ukuran setelah kompres: ${formatSize(compressedSize)}")
        Log.i("Compress", "Original dimensi: ${originalBitmap.width}x${originalBitmap.height}")
        Log.i("Compress", "Resized dimensi: ${newWidth}x${newHeight}")

        return outputFile.absolutePath
    }

    private fun formatSize(size: Long): String {
        val df = DecimalFormat("#.##")
        val kb = size / 1024.0
        val mb = kb / 1024.0
        return when {
            mb >= 1 -> "${df.format(mb)} MB"
            kb >= 1 -> "${df.format(kb)} KB"
            else -> "$size B"
        }
    }
}
