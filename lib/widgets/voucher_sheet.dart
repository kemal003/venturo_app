import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venturo_app/viewmodel/voucher_viewmodel.dart';

class VoucherSheet extends StatefulWidget {
  const VoucherSheet({super.key});

  @override
  State<VoucherSheet> createState() => _VoucherSheetState();
}

class _VoucherSheetState extends State<VoucherSheet> {
  final TextEditingController voucherController = TextEditingController();
  bool errorShown = false;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    voucherController.addListener(() {
      if (voucherController.text.isNotEmpty) {
        setState(() {
          isButtonEnabled = true;
        });
      } else {
        setState(() {
          isButtonEnabled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final voucherViewModel = context.read<VoucherViewModel>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.discount,
                color: Color(0xFF009AAD),
              ),
              const SizedBox(width: 10),
              Text(
                "Punya Kode Voucher?",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Masukkan kode voucher di sini",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextField(
            controller: voucherController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xFF009AAD),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xFF009AAD),
                ),
              ),
              hintText: "Masukkan kode voucher",
              contentPadding: EdgeInsets.zero,
              hintStyle: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: 10),
          errorShown
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Voucher tidak ditemukan",
                    style: Theme.of(context).textTheme.labelSmall?.apply(color: Colors.red),
                  ),
                )
              : Container(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isButtonEnabled
                  ? () async {
                      setState(() {
                        errorShown = false;
                      });
                      voucherViewModel.getVoucher(voucherController.text).then((voucher) {
                        if (voucher.statusCode == 200) {
                          Navigator.of(context).pop();
                        } else {
                          setState(() {
                            errorShown = true;
                          });
                        }
                      });
                    }
                  : null,
              child: const Text("Validasi Voucher"),
            ),
          )
        ],
      ),
    );
  }
}
