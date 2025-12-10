import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/app/constant/icons_path.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class MemberCardBottomSheet extends StatelessWidget {
  final Resource member;

  const MemberCardBottomSheet({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Modern drag handle dengan background blur
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          // Main card container
          Flexible(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                  bottom: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -8),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // === MODERN DIGITAL ID CARD ===
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorPalette.secondary,
                            ColorPalette.secondary.withOpacity(0.8),
                            ColorPalette.secondary.withOpacity(0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: const [0.0, 0.5, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: ColorPalette.secondary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Background pattern/decoration
                          Positioned(
                            top: -50,
                            right: -50,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -30,
                            left: -30,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.03),
                              ),
                            ),
                          ),

                          // Main content
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                // Header dengan logo
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      '${Constant.iconPath}logo.png',
                                      height: 40,
                                      fit: BoxFit.contain,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: TextComponent.textBody(
                                        'DIGITAL CARD',
                                        colors: Colors.white,
                                        bold: true,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // Profile section
                                Row(
                                  children: [
                                    // Photo dengan border modern
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${Constant.baseUrlImage}${member.imageFoto}',
                                          width: 80,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            child: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 20),

                                    // Info section
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextComponent.textTitle(
                                            member.fullName,
                                            bold: true,
                                            colors: Colors.white,
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: TextComponent.textBody(
                                              member.role.roleName,
                                              colors: Colors.white,
                                              bold: true,
                                            ),
                                          ),
                                          const SizedBox(height: 12),

                                          // Status badge dengan lebih detail
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getStatusColor(
                                                          member.status)
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: _getStatusColor(
                                                            member.status)
                                                        .withOpacity(0.5),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 6,
                                                      height: 6,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: _getStatusColor(
                                                            member.status),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    TextComponent.textBody(
                                                      _getStatusText(
                                                          member.status),
                                                      colors: Colors.white,
                                                      bold: true,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // Information cards
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      _modernInfoRow(
                                        Icons.badge_outlined,
                                        "Member ID",
                                        "#${member.resourceId.toString()}",
                                      ),
                                      const SizedBox(height: 12),
                                      _modernInfoRow(
                                        Icons.email_outlined,
                                        "Email",
                                        member.email ?? '-',
                                      ),
                                      const SizedBox(height: 12),
                                      _modernInfoRow(
                                        Icons.phone_outlined,
                                        "Telepon",
                                        member.telepon ?? '-',
                                      ),
                                      const SizedBox(height: 12),
                                      _modernInfoRow(
                                        Icons.location_on_outlined,
                                        "Wilayah",
                                        "${member.province?.name ?? '-'}, ${member.regency?.name ?? '-'}",
                                      ),
                                      const SizedBox(height: 12),
                                      _modernInfoRow(
                                        Icons.cake_outlined,
                                        "Tempat, Tgl Lahir",
                                        "${member.placeOfBirth ?? '-'}, ${_formatDate(member.dateOfBirth)}",
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // QR Code section
                                // QR Code section
                                Container(
                                  padding: const EdgeInsets.all(
                                      12), // sedikit lebih kecil padding biar proporsional
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    width: 80, // << dari 120 jadi 80
                                    height: 80, // << dari 120 jadi 80
                                    child: PrettyQrView.data(
                                      data: member.resourceUuid.toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Modern close button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.secondary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: TextComponent.textBody(
                          'Tutup',
                          colors: Colors.white,
                          bold: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method untuk format tanggal
  String _formatDate(String? dateString) {
    if (dateString == null) return '-';
    try {
      final DateTime date = DateTime.parse(dateString);
      final List<String> months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Ags',
        'Sep',
        'Okt',
        'Nov',
        'Des'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  // Helper method untuk status color
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'A':
        return Colors.green;
      case 'NV':
        return Colors.orange;
      case 'I':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Helper method untuk status text
  String _getStatusText(String? status) {
    switch (status) {
      case 'A':
        return 'Aktif';
      case 'NV':
        return 'Belum Verifikasi';
      case 'I':
        return 'Nonaktif';
      default:
        return 'Unknown';
    }
  }

  Widget _modernInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent.textBody(
                label,
                colors: Colors.white70,
              ),
              const SizedBox(height: 2),
              TextComponent.textBody(
                value,
                colors: Colors.white,
                bold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
