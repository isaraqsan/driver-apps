import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  RxBool isOnline = true.obs;
  RxBool isLoading = true.obs;
  var nfcTag = Rxn<String>(null);
  var nfcBalance = 0.obs;

  String driverName = 'Agus Driver';
  String platNomor = 'B 1234 XYZ';
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxList<OrderItem> customerOrders = <OrderItem>[].obs;

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  Future<void> initData() async {
    isLoading.value = true;
    await getPermission();
    await Future.delayed(
        const Duration(seconds: 2)); // biar shimmer terasa iOS smooth

    // contoh order dummy
    customerOrders.assignAll([
      OrderItem(
          customerName: 'Rudi',
          address: 'Jl. Merpati No. 14',
          orderDate: DateTime.now(), // hari ini
          pickupLat: -6.655049734473682,
          pickupLong: 106.8466735258764,
          dropLat: -6.621294406487099,
          dropLong: 106.8176706559132),
      OrderItem(
          customerName: 'Siti',
          address: 'Komplek Cendana',
          orderDate: DateTime.now().add(const Duration(days: 1)), // besok
          pickupLat: -6.655049734473682,
          pickupLong: 106.8466735258764,
          dropLat: -6.621294406487099,
          dropLong: 106.8176706559132),
      OrderItem(
          customerName: 'Asep',
          address: 'Perum Dahlia',
          orderDate:
              DateTime.now().add(const Duration(days: 3)), // tanggal lain
          pickupLat: -6.655049734473682,
          pickupLong: 106.8466735258764,
          dropLat: -6.621294406487099,
          dropLong: 106.8176706559132),
    ]);
    isLoading.value = false;
  }

  void toggleOnline() {
    isOnline.value = !isOnline.value;
  }

  Future<void> getPermission() async {
    await Permission.location.request();
    await Permission.camera.request();
  }

  Future<void> readNfcCard() async {
    try {
      // Mulai scan NFC
      final NFCTag tag =
          await FlutterNfcKit.poll(timeout: Duration(seconds: 10));
      nfcTag.value = tag.id;
      Log.d(tag.id);

      // Simulasi dapat saldo dari server / tag
      // Bisa diganti dengan logika membaca data tag sebenarnya
      nfcBalance.value = 50000;

      // Setelah selesai, stop polling
      await FlutterNfcKit.finish();
    } catch (e) {
      print('NFC Error: $e');
      Utils.toast('Error Gagal membaca kartu NFC', snackType: SnackType.error);
    }
  }

  String monthShort(int m) {
    const bulan = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return bulan[m - 1];
  }

  void pickDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) {
        return Container(
          height: 320,
          decoration: const BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // ==== HEADER WITH DONE ====
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  color: ColorPalette.primary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: ColorPalette.greenTheme,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),

              // ==== DATE PICKER ====
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: ColorPalette.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    backgroundColor: ColorPalette.primary,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate.value,
                    onDateTimeChanged: (value) {
                      selectedDate.value = DateTime(
                        value.year,
                        value.month,
                        value.day,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<OrderItem> get filteredOrders {
    return customerOrders.where((item) {
      return item.orderDate.year == selectedDate.value.year &&
          item.orderDate.month == selectedDate.value.month &&
          item.orderDate.day == selectedDate.value.day;
    }).toList();
  }
}

class OrderItem {
  final String customerName;
  final String address;
  final DateTime orderDate;

  // Pickup location
  final double pickupLat;
  final double pickupLong;

  // Drop-off location
  final double dropLat;
  final double dropLong;

  OrderItem({
    required this.customerName,
    required this.address,
    required this.orderDate,
    required this.pickupLat,
    required this.pickupLong,
    required this.dropLat,
    required this.dropLong,
  });
}
