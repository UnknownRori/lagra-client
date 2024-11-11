import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lagra_client/models/keranjang.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/transaction.dart';
import 'package:lagra_client/utils/storage.dart';
import 'package:lagra_client/utils/theme.dart';
import 'package:provider/provider.dart';

class KeranjangMobile extends StatefulWidget {
  const KeranjangMobile({super.key});

  @override
  _KeranjangMobileState createState() => _KeranjangMobileState();
}

class _KeranjangMobileState extends State<KeranjangMobile> {
  List<Keranjang> _keranjang = [];
  PaymentType _currentSelectedPayment = PaymentType.paypal;

  void fetchItem(HttpClient client, TransactionProvider provider) async {
    var item = await provider.ambilKeranjang(client);
    setState(() {
      _keranjang = item;
    });
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!context.mounted) return;

      HttpClient client = context.read<HttpClient>();
      TransactionProvider transaction = context.read<TransactionProvider>();
      fetchItem(client, transaction);
    });
  }

  void checkout(HttpClient client, TransactionProvider transaction) async {
    var result = await transaction.checkout(client, _currentSelectedPayment);

    if (!context.mounted) return;

    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColor.danger.withOpacity(0.8),
          content: Text("Checkout gagal!", style: mobile.body2),
          duration: const Duration(seconds: 1)));
    }

    fetchItem(client, transaction);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColor.primary.withOpacity(0.8),
        content: Text("Checkout berhasil!", style: mobile.body2),
        duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    var client = context.read<HttpClient>();
    var transaction = context.read<TransactionProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Keranjang"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: _keranjang
                  .map(
                    (keranjang) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: Storage.resolve(keranjang.item.img),
                              scale: 3,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(keranjang.item.name, style: mobile.body1),
                                const SizedBox(height: 26),
                                Text(keranjang.total.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            () {
              if (_keranjang.isNotEmpty) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            AnimatedSwitcher(
                                duration: const Duration(milliseconds: 1000),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return FadeTransition(
                                      opacity: animation, child: child);
                                },
                                child: _currentSelectedPayment ==
                                        PaymentType.paypal
                                    ? OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: AppColor.primary,
                                              width: 2.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        onPressed: () {},
                                        child: SvgPicture.asset(
                                          "assets/images/paypal.svg",
                                          colorFilter: const ColorFilter.mode(
                                              AppColor.primary,
                                              BlendMode.srcIn),
                                        ),
                                      )
                                    : OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: AppColor.mainText,
                                              width: 2.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _currentSelectedPayment =
                                                PaymentType.paypal;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          "assets/images/paypal.svg",
                                          colorFilter: const ColorFilter.mode(
                                              AppColor.mainText,
                                              BlendMode.srcIn),
                                        ),
                                      )),
                            const SizedBox(
                              width: 8,
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 1000),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                              child: _currentSelectedPayment ==
                                      PaymentType.creditCard
                                  ? OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColor.primary,
                                            width: 2.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                      ),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.credit_card,
                                        color: AppColor.primary,
                                      ))
                                  : OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColor.mainText,
                                            width: 2.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _currentSelectedPayment =
                                              PaymentType.creditCard;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.credit_card,
                                        color: AppColor.mainText,
                                      )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 1000),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                              child: _currentSelectedPayment == PaymentType.bank
                                  ? OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColor.primary,
                                            width: 2.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                      ),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.account_balance,
                                        color: AppColor.primary,
                                      ))
                                  : OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColor.mainText,
                                            width: 2.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _currentSelectedPayment =
                                              PaymentType.bank;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.account_balance,
                                        color: AppColor.mainText,
                                      )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            checkout(client, transaction);
                          },
                          child: Text("Checkout", style: mobile.body1),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Text("Keranjang anda kosong!", style: mobile.body1),
              );
            }(),
          ],
        ),
      ),
    );
  }
}
