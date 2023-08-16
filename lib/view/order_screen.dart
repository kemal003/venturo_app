import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venturo_app/view/checkout_screen.dart';
import 'package:venturo_app/viewmodel/cart_viewmodel.dart';
import 'package:venturo_app/viewmodel/menu_viewmodel.dart';
import 'package:venturo_app/viewmodel/voucher_viewmodel.dart';
import 'package:venturo_app/widgets/order_card.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/order";

  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    final menuViewModel = context.read<MenuViewModel>();
    final voucherViewModel = context.watch<VoucherViewModel>();

    calculatePrice() {
      final price = cartViewModel.priceCount -
          ((voucherViewModel.savedVoucher?.nominal == null) ? 0 : voucherViewModel.savedVoucher!.nominal!);
      if (price < 0) {
        return 0;
      } else {
        return price;
      }
    }

    return Scaffold(
      body: FutureBuilder(
          future: menuViewModel.getMenu(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.datas!.length,
                        itemBuilder: (_, index) {
                          return OrderCard(
                            dataMenu: snapshot.data!.datas![index],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade200,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25.0),
                          margin: const EdgeInsets.only(bottom: 65),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("Total Pesanan (${cartViewModel.itemCount} menu) :"),
                                  ),
                                  Text(
                                    "Rp. ${cartViewModel.priceCount.toString()}",
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.discount,
                                    color: Color(0xFF009AAD),
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Text("Voucher"),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: voucherViewModel.savedVoucher != null
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(voucherViewModel.savedVoucher!.kode!),
                                              Text(
                                                "Rp. ${voucherViewModel.savedVoucher!.nominal}",
                                                style: Theme.of(context).textTheme.labelMedium?.apply(color: Colors.red),
                                              ),
                                            ],
                                          )
                                        : const Text("Input Voucher"),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: Color(0xFFAAAAAA),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(0.04),
                                spreadRadius: -1,
                                blurRadius: 20,
                                offset: const Offset(0, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add_shopping_cart,
                                color: Color(0xFF009AAD),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Pembayaran",
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                    Text(
                                      "Rp. ${calculatePrice()}",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Icon(
                                                  Icons.warning_amber,
                                                  color: Color(0xFF009AAD),
                                                  size: 50,
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    "Apakah Anda yakin ingin membatalkan pesanan ini?",
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.white,
                                                      foregroundColor: const Color(0xFF009AAD),
                                                    ),
                                                    child: const Text("Batal"),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      cartViewModel.clearCart();
                                                      Navigator.of(context).pushReplacementNamed(CheckoutScreen.routeName);
                                                    },
                                                    child: const Text("Yakin"),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text("Batalkan"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
