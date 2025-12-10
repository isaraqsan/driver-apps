// import 'package:gibas/core/app/constant/images_path.dart';
// import 'package:gibas/core/app/controller/auth_controller.dart';
// import 'package:gibas/core/app/controller/master_controller.dart';
// import 'package:gibas/data/repositories/brand_repository.dart';
// import 'package:gibas/data/repositories/channel_repository.dart';
// import 'package:gibas/data/repositories/display_type_repository.dart';
// import 'package:gibas/data/repositories/regional_repository.dart';
// import 'package:gibas/data/repositories/sub_area_repository.dart';
// import 'package:gibas/data/repositories/sub_channel_repository.dart';
// import 'package:gibas/features/master/repository/master_repository.dart';
// import 'package:get/get.dart';

// enum MasterActionState { initial, loading, success, dataEmpty, error }

// class MasterActionController extends GetxController with StateMixin<MasterActionState> {
//   late MasterRepository masterRepository;

//   @override
//   void onReady() {
//     masterRepository = MasterRepository();
//     onGetMasterData();
//     super.onReady();
//   }

//   void onGetMasterData() async {
//     change(MasterActionState.loading, status: RxStatus.success());
//     final MasterController masterController = Get.find<MasterController>();
//     final BrandRepository brandRepository = BrandRepository();
//     final DisplayTypeRepository displayTypeRepository = DisplayTypeRepository();
//     final RegionalRepository regionalRepository = RegionalRepository();
//     final SubAreaRepository subAreaRepository = SubAreaRepository();
//     final ChannelRepository channelRepository = ChannelRepository();
//     final SubChannelRepository subChannelRepository = SubChannelRepository();

//     await masterRepository.brand().then((value) async {
//       if (value.isSuccess) {
//         await brandRepository.removeAll();
//         await brandRepository.addAll(value.list ?? []);
//         masterController.channelList.clear();
//         masterController.brandList.addAll(value.list ?? []);
//       }
//     });

//     await masterRepository.displayType().then((value) async {
//       if (value.isSuccess) {
//         await displayTypeRepository.removeAll();
//         await displayTypeRepository.addAll(value.list ?? []);
//         masterController.displayTypeList.clear();
//         masterController.displayTypeList.addAll(value.list ?? []);
//       }
//     });

//     await masterRepository.areaRegion().then((value) async {
//       if (value.isSuccess) {
//         await regionalRepository.removeAll();
//         await regionalRepository.addAll(value.list ?? []);
//         masterController.regionalList.clear();
//         masterController.regionalList.addAll(value.list ?? []);
//       }
//     });

//     await masterRepository.areaSubArea().then((value) async {
//       if (value.isSuccess) {
//         await subAreaRepository.removeAll();
//         await subAreaRepository.addAll(value.list ?? []);
//         masterController.subAreaList.clear();
//         masterController.subAreaList.addAll(value.list ?? []);
//       }
//     });

//     await masterRepository.channel().then((value) async {
//       if (value.isSuccess) {
//         await channelRepository.removeAll();
//         await channelRepository.addAll(value.list ?? []);
//         masterController.channelList.clear();
//         masterController.channelList.addAll(value.list ?? []);
//       }
//     });

//     await masterRepository.subChannel().then((value) async {
//       if (value.isSuccess) {
//         await subChannelRepository.removeAll();
//         await subChannelRepository.addAll(value.list ?? []);
//         masterController.subChannelList.clear();
//         masterController.subChannelList.addAll(value.list ?? []);
//       }
//     });

//     change(MasterActionState.success, status: RxStatus.success());

//     await 2.delay();
//     AuthController.instance.navDashboard();
//   }

//   String imageState() {
//     switch (state) {
//       case MasterActionState.initial:
//         return ImagesPath.marketing;
//       default:
//         return ImagesPath.marketing;
//     }
//   }

//   String title() {
//     switch (state) {
//       case MasterActionState.initial:
//         return 'Apakah kamu yakin untuk melakukan sync data?';
//       case MasterActionState.loading:
//         return 'Mohon Tunggu sedang memuat data';
//       case MasterActionState.success:
//         return 'Berhasil memuat data';
//       case MasterActionState.dataEmpty:
//         return 'Semua data telah di sync';
//       case MasterActionState.error:
//         return 'Gagal memuat data';
//       default:
//         return 'Mohon Tunggu sedang memuat data';
//     }
//   }

//   String description() {
//     switch (state) {
//       case MasterActionState.initial:
//         return 'Pastikan semua transaksi sudah selesai sebelum melakukan sync data';
//       case MasterActionState.loading:
//         return 'Ini mungkin memakan waktu beberapa saat, mohon untuk tidak menutup aplikasi';
//       case MasterActionState.success:
//         return 'Selamat bekerja, semoga harimu selalu menyenangkan';
//       case MasterActionState.dataEmpty:
//         return 'Selamat bekerja, semoga harimu selalu menyenangkan';
//       case MasterActionState.error:
//         return 'Mohon untuk mencoba lagi';
//       default:
//         return 'Mohon Tunggu sedang memuat data';
//     }
//   }
// }
