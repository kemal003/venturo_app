import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venturo_app/view/checkout_screen.dart';
import 'package:venturo_app/view/order_screen.dart';
import 'package:venturo_app/viewmodel/cart_viewmodel.dart';
import 'package:venturo_app/viewmodel/menu_viewmodel.dart';
import 'package:venturo_app/viewmodel/voucher_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => VoucherViewModel()),
        ChangeNotifierProxyProvider<MenuViewModel, CartViewModel>(
          create: (_) => CartViewModel(),
          update: (_, menuViewModel, prevCartViewModel) {
            if (prevCartViewModel != null) {
              return prevCartViewModel..updateMenu(menuViewModel.fetchedMenu);
            } else {
              return CartViewModel();
            }
          },
        ),
      ],
      child: MaterialApp(
        title: "Venturo",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "Montserrat",
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF009AAD),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyMedium,
              foregroundColor: const Color(0xFFAAAAAA),
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF009AAD),
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
            ),
            labelLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF009AAD),
            ),
            labelSmall: TextStyle(
              fontSize: 12,
              color: Color(0xFFAAAAAA),
              fontFamily: "Montserrat",
              letterSpacing: 0,
            ),
          ),
        ),
        routes: {
          CheckoutScreen.routeName: (_) => const CheckoutScreen(),
          OrderScreen.routeName: (_) => const OrderScreen(),
        },
      ),
    );
  }
}
