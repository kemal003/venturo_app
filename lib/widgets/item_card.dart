import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venturo_app/model/menu.dart';
import 'package:venturo_app/viewmodel/cart_viewmodel.dart';

class ItemCard extends StatefulWidget {
  final Datas dataMenu;

  const ItemCard({super.key, required this.dataMenu});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int _itemCount = 0;
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.read<CartViewModel>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF6F6F6),
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
                Row(
                  children: [
                    const Icon(
                      Icons.edit_note,
                      color: Color(0xFF009AAD),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        scrollPadding: EdgeInsets.zero,
                        controller: _noteController,
                        style: Theme.of(context).textTheme.bodySmall,
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            cartViewModel.addNote(widget.dataMenu.id!, _noteController.text);
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tambahkan Catatan",
                          contentPadding: EdgeInsets.zero,
                          hintStyle: Theme.of(context).textTheme.labelSmall,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                InkWell(
                  onTap: _itemCount > 0
                      ? () {
                          setState(() {
                            cartViewModel.removePriceCount(widget.dataMenu.id!, widget.dataMenu.harga!);
                            _itemCount = _itemCount - 1;
                            if (_itemCount == 0) {
                              cartViewModel.removeItemCount();
                            }
                          });
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF009AAD),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Color(0xFF009AAD),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 25,
                  child: Text(_itemCount.toString()),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      cartViewModel.addPriceCount(widget.dataMenu.id!, widget.dataMenu.harga!);
                      _itemCount = _itemCount + 1;
                      if (_itemCount == 1) {
                        cartViewModel.addItemCount();
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFF009AAD),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
