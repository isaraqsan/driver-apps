import 'package:flutter/cupertino.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/utils/cupertino_shimmer.dart';
import 'package:gibas/features/home/controller/home_controller.dart';
import 'package:gibas/features/order/view/order_detail_view.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return BaseScaffold(
          // backgroundColor: ColorPalette.primary,
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(controller),
        );
      },
    );
  }

  Widget _contentMobile(HomeController controller) {
    return CupertinoPageScaffold(
      backgroundColor: ColorPalette.primary,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.18),
                          Colors.white.withOpacity(0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.driverName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.platNomor,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: controller.toggleOnline,
                        child: Transform.scale(
                          scale: controller.isOnline.value ? 1.05 : 1.0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 230),
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: controller.isOnline.value
                                  ? ColorPalette.greenTheme.withOpacity(0.85)
                                  : Colors.redAccent.withOpacity(0.75),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              controller.isOnline.value
                                  ? CupertinoIcons.dot_radiowaves_left_right
                                  : CupertinoIcons.power,
                              color: Colors.white,
                            ),
                          ),
                        ));
                  }),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
              child: Obx(() {
                final nfcTag = controller.nfcTag.value;
                final balance = controller.nfcBalance.value;

                return Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        CupertinoIcons.creditcard,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: nfcTag != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '**** **** **** ${nfcTag.substring(nfcTag.length - 4)}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Saldo: Rp $balance',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Tap icon kartu untuk cek saldo',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showCupertinoDialog(
                            context: Get.context!,
                            builder: (context) => Center(
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemBackground,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.greenAccent
                                              .withOpacity(0.2),
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.creditcard,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Scan e-Wallet',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Letakkan kartu e-wallet di dekat NFC untuk mengecek saldo.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14, height: 1.4),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CupertinoButton(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              color: Colors.redAccent
                                                  .withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: const Text('Batal'),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: CupertinoButton(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              color: Colors.greenAccent
                                                  .withOpacity(0.95),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: const Text('Scan'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                controller.readNfcCard();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            CupertinoIcons.creditcard_fill,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Text(
                'Daftar Order',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                final date = controller.selectedDate.value;
                final formatted =
                    '${date.day} ${controller.monthShort(date.month)} ${date.year}';

                return GestureDetector(
                    onTap: () => controller.pickDate(Get.context!),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.calendar,
                              color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            formatted,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            CupertinoIcons.chevron_down,
                            color: Colors.white.withOpacity(0.8),
                            size: 16,
                          )
                        ],
                      ),
                    ));
              }),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                final orders = controller.filteredOrders;

                if (!controller.isOnline.value) {
                  return Center(
                    child: Text(
                      'Kamu sedang offline.\nAktifkan untuk menerima order.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                if (controller.isLoading.value) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 6,
                    itemBuilder: (_, i) => shimmerOrderCard(),
                  );
                }

                if (orders.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada order di tanggal ini',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _customerCard(orders[index], controller);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customerCard(OrderItem item, HomeController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.12),
            ),
            child: Icon(
              CupertinoIcons.person,
              color: ColorPalette.greenTheme.withOpacity(0.85),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.customerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  item.address,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 12.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            color: ColorPalette.greenTheme.withOpacity(0.95),
            borderRadius: BorderRadius.circular(12),
            child: const Text(
              'Detail',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              Get.to(() => OrderDetailView(item: item), arguments: item);
            },
          ),
        ],
      ),
    );
  }

  Widget shimmerOrderCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Row(
        children: [
          
          CupertinoShimmer(
              width: 40, height: 40, borderRadius: BorderRadius.circular(40)),
          const SizedBox(width: 12),

          
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoShimmer(width: 120, height: 16),
                SizedBox(height: 6),
                CupertinoShimmer(width: 160, height: 14),
              ],
            ),
          ),

          const SizedBox(width: 12),

          CupertinoShimmer(
              width: 58, height: 28, borderRadius: BorderRadius.circular(10)),
        ],
      ),
    );
  }
}
