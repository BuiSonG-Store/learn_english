import 'package:flutter/material.dart';
import 'package:learn_english/provider/theme_provider.dart';
import 'package:learn_english/router/navigate_service.dart';
import 'package:learn_english/router/router.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/screens/momo/payment_succes.dart';
import 'package:learn_english/view/widgets/loading/loading_container.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final bool? isPayment;
  const MyApp({Key? key, this.isPayment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        navigatorKey: NavigationService.instance.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'English',
        initialRoute: RoutingNameConstant.splashScreen,
        routes: RoutesConstant.routes,
        builder: (context, widget) {
          if (isPayment != null) {
            return const PaymentSuccess();
          }
          return LoadingContainer(
            child: widget ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
