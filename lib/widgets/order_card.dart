import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venturo_app/model/menu.dart';
import 'package:venturo_app/viewmodel/cart_viewmodel.dart';

class OrderCard extends StatefulWidget {
  final Datas dataMenu;

  const OrderCard({super.key, required this.dataMenu});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.read<CartViewModel>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E2E2E).withOpacity(0.12),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFDFDFDF),
              ),
              child: Image.network(
                widget.dataMenu.gambar!,
                height: 70,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dataMenu.nama!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Rp. ${widget.dataMenu.harga!.toString()}",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                cartViewModel.notes[widget.dataMenu.id!] != null
                    ? Row(
                        children: [
                          const Icon(
                            Icons.edit_note,
                            color: Color(0xFF009AAD),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cartViewModel.notes[widget.dataMenu.id!]!,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            height: 30,
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              width: 25,
              child: Text(
                (cartViewModel.itemsCart[widget.dataMenu.id] ?? 0).toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          )
        ],
      ),
    );
  }
}
