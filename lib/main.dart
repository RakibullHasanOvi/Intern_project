import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/Pages/welcome_page.dart';
import 'package:wallet_ui/services/user_api.dart';

void main() {
  runApp(const WalletApp());
}

class WalletApp extends StatelessWidget {
  const WalletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>(
                create: (BuildContext context) => UserProvider(),
              ),
            ],
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              //Call Welcome page
              home: WelcomePage(),
            ),
          );
        });
  }
}
