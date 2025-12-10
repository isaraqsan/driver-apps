import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:gibas/features/home/controller/home_controller.dart';
import 'package:gibas/features/order/controller/order_detail_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/widgets/photo_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class OrderDetailView extends StatelessWidget {
  final OrderItem item;

  const OrderDetailView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OrderDetailController(),
      builder: (controller) {
        return BaseScaffold(
          backgroundColor: ColorPalette.primary,
          usePaddingHorizontal: false,
          contentMobile: _content(controller),
        );
      },
    );
  }

  Widget _content(OrderDetailController controller) {
    return Stack(
      children: [
        // ======================
        // FULLSCREEN MAP
        // ======================
        Positioned.fill(child: _buildOSMMap(item, controller)),

        // ======================
        // FLOATING ACTION BUTTON
        // ======================
        Positioned(
          left: 20,
          right: 20,
          bottom: 240,
          child: _actionButton(controller),
        ),

        // Tambahkan di Stack (Top Left)
        Positioned(
          top: 60,
          left: 20,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.back,
                size: 22,
                color: CupertinoColors.black,
              ),
            ),
          ),
        ),

        // ======================
        // REFRESH LOCATION BUTTON (Top Right)
        // ======================
        Positioned(
          top: 60,
          right: 20,
          child: GetBuilder<OrderDetailController>(
            builder: (c) {
              return GestureDetector(
                onTap: c.isGettingLocation ? null : c.refreshLocation,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: ColorPalette.greenTheme,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: c.isGettingLocation
                      ? const Center(
                          child: CupertinoActivityIndicator(radius: 10),
                        )
                      : const Icon(
                          CupertinoIcons.location_fill,
                          color: CupertinoColors.black,
                          size: 22,
                        ),
                ),
              );
            },
          ),
        ),

        // ======================
        // DETAILS CARD (Bottom)
        // ======================
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.withOpacity(0.95),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME
                Text(
                  item.customerName,
                  style: const TextStyle(
                    color: CupertinoColors.label,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 8),

                // ADDRESS
                Text(
                  item.address,
                  style: const TextStyle(
                    color: CupertinoColors.secondaryLabel,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                // DATE ROW
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        CupertinoIcons.calendar,
                        color: CupertinoColors.systemGrey,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${item.orderDate.day}/${item.orderDate.month}/${item.orderDate.year}',
                      style: const TextStyle(
                        color: CupertinoColors.label,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // STATUS ROW
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        CupertinoIcons.cube_box,
                        color: CupertinoColors.systemGrey,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Status: Belum diantar',
                      style: TextStyle(
                        color: CupertinoColors.label,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FULLSCREEN OSM MAP
  // ============================================================
  Widget _buildOSMMap(OrderItem item, OrderDetailController c) {
    LatLng target;

    // Tentukan target berdasarkan step
    if (c.step == OrderStep.accepted) {
      target = LatLng(item.pickupLat, item.pickupLong);
    } else if (c.step == OrderStep.pickedUp || c.step == OrderStep.delivering) {
      target = LatLng(item.dropLat, item.dropLong);
    } else {
      target = LatLng(item.pickupLat, item.pickupLong); // default
    }

    final LatLng? driver = c.driverLocation;

    return FlutterMap(
      mapController: c.mapController,
      options: MapOptions(
        initialCenter: target,
        initialZoom: 15,
        onPositionChanged: (position, hasGesture) {
          if (hasGesture) c.isAutoFollow = false;
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'gibas.app',
        ),
        if (c.route.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: c.route,
                strokeWidth: 5,
                color: CupertinoColors.activeBlue,
              )
            ],
          ),
        MarkerLayer(markers: [
          Marker(
            point: target,
            width: 50,
            height: 50,
            child: Icon(
              c.step == OrderStep.accepted
                  ? CupertinoIcons.location_solid
                  : CupertinoIcons.location_solid,
              color: CupertinoColors.systemRed,
              size: 40,
            ),
          ),
          if (driver != null)
            Marker(
              point: driver,
              width: 50,
              height: 50,
              child: const Icon(
                CupertinoIcons.car_detailed,
                color: CupertinoColors.activeBlue,
                size: 36,
              ),
            ),
        ]),
      ],
    );
  }

  Widget _actionButton(OrderDetailController c) {
    switch (c.step) {
      case OrderStep.idle:
        return _btn('Ambil Order', onTap: () async {
          await c.takeOrder(LatLng(item.pickupLat, item.pickupLong));
        });

      case OrderStep.accepted:
        return Row(
          children: [
            Expanded(
              child: _btn('Pick Up', onTap: () async {
                if (c.pickUpPhoto == null) {
                  _showUploadModal(c, isPickUp: true);
                  return;
                }
                c.pickUp();
              }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Buttons.outlineButton(
                  onPressed: () {}, type: ButtonType.cancel, title: 'Cancel'),
            ),
          ],
        );

      case OrderStep.pickedUp:
        return _btn('Drop Off', onTap: () async {
          if (c.deliverPhoto == null) {
            _showUploadModal(c, isPickUp: false);
            return;
          }
          c.deliver();
        });

      case OrderStep.delivering:
        return _btn('Selesaikan Order', onTap: c.finishOrder);

      case OrderStep.finished:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGreen.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CupertinoColors.systemGreen.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: CupertinoColors.systemGreen,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Order Selesai',
                style: TextStyle(
                  color: CupertinoColors.systemGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _btn(String text, {required VoidCallback onTap}) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: ColorPalette.greenTheme,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: CupertinoColors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }

  void _showUploadModal(OrderDetailController c, {required bool isPickUp}) {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag Handle
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey4,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      isPickUp ? 'Upload Foto Pick Up' : 'Upload Foto Drop Off',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.label,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Photo Picker
                    PhotoPicker(
                      height: 200,
                      width: double.infinity,
                      imageSource: ImageSource.camera,
                      onChanged: (file) {
                        c.selectedFile = file;
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 24),

                    // Action Button
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: c.selectedFile == null
                          ? null
                          : () {
                              if (isPickUp) {
                                c.uploadPickUpPhoto(c.selectedFile!.path);
                                c.pickUp();
                              } else {
                                c.uploadDeliverPhoto(c.selectedFile!.path);
                                c.deliver();
                              }
                              c.selectedFile = null;
                              Get.back();
                            },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: c.selectedFile == null
                              ? CupertinoColors.systemGrey4
                              : ColorPalette.greenTheme,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            'Lanjut',
                            style: TextStyle(
                              color: c.selectedFile == null
                                  ? CupertinoColors.systemGrey
                                  : CupertinoColors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
