import 'package:flutter/material.dart';
import 'package:lagra_client/utils/theme.dart';

class HamburgerExpanded extends StatelessWidget {
  const HamburgerExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColor.bg,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.receipt_long,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Riwayat Transaksi",
                        style: mobile.body2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_outline,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Ulasan",
                        style: mobile.body2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.qr_code_scanner,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Scan Code QR",
                        style: mobile.body2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.settings,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Settings",
                        style: mobile.body2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        size: 32,
                        color: AppColor.danger,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Logout",
                        style: mobile.body2.copyWith(color: AppColor.danger),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
