import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/Pages/buttom_navigation.dart';
import 'package:wallet_ui/Pages/screen/Profile/add_fund.dart';
import 'package:wallet_ui/Pages/screen/Notification/notificatio_page.dart';
import 'package:wallet_ui/models/pages/giftCard_items.dart';
import 'package:wallet_ui/models/services/mobile_banking_service.dart';
import 'package:wallet_ui/services/notification_api_marged.dart';
import '../models/pages/bank_item.dart';
import '../models/pages/mb_items.dart';
import '../models/pages/recharge_item.dart';
import '../services/user_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    Future _Storage() async {
      var hometoken = await storage.read(key: 'token');
    }

    //Set the lenght ..
    TabController _tabController = TabController(length: 4, vsync: this);
    //
    //Pull refresh ..
    _handleRefresh() async {
      Future.delayed(
        Duration(seconds: 2),
      );
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const BottomNavigation(),
            transitionDuration: const Duration(seconds: 0),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
          // MaterialPageRoute(builder: (context) => BottomNavigation()),
          (route) => false);
    }

    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () {
          _Storage();
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF4F8FB),
          // backgroundColor: Colors.blue[50],
          // backgroundColor: Color.fromARGB(255, 243, 253, 255),
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.white,
            leadingWidth: 150,
            leading: Container(
              margin: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const
                  //   ()),
                  // );
                },
                child: SvgPicture.asset('assets/wallet_logo.svg'),
                // child: const Image(
                //   image: AssetImage(
                //     'assets/Group 255.png',
                //   ),
                // ),
              ),
            ),

//! Notification Icon
            actions: [
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 4,
                      right: 4,
                    ),
                    child: IconButton(
                      iconSize: 10,
                      icon: SvgPicture.asset(
                        'assets/notifications.svg',
                        height: 22,
                      ),
                      // icon: Image.asset('assets/noti.png'),
                      onPressed: () {
                        print(
                            'this is last item -> ${Provider.of<UserProvider>(context, listen: false).lastItem}');
                        // sending to notification page using (PageRouteBuilder)

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const NotificationPage(),
                            transitionDuration: const Duration(seconds: 0),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 10,
                    child: StreamBuilder<int>(
                        stream: getNotificationCount2(context),
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          return snapshot.hasData
                              ? snapshot.data != null && snapshot.data != 0
                                  ? CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        snapshot.data.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          // fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : const SizedBox.shrink()
                              : const SizedBox.shrink();
                        }),
                  ),
                ],
              ),
            ],
          ),

          //Pul down Refresh...
          body: LiquidPullToRefresh(
            borderWidth: 2,
            animSpeedFactor: 2,
            showChildOpacityTransition: false,

            // springAnimationDurationInMilliseconds: 300,
            backgroundColor: const Color.fromARGB(255, 105, 183, 247),
            // color: Colors.grey,
            color: const Color(0xFFF4F8FB),

            //End of pull down refresh..

            onRefresh: _handleRefresh,
            // height: 50,
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      //
                      //
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => const AddFund(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                  transitionsBuilder: (_, a, __, c) =>
                                      FadeTransition(opacity: a, child: c),
                                ),
                              );
                            },
                            child: SvgPicture.asset('assets/tk.svg'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // TextButton(
                          //     onPressed: () {
                          //       print(
                          //           // ignore: unnecessary_string_interpolations
                          //           '${Provider.of<UserProvider>(context, listen: false).useR.username ?? "fsdf"}');
                          //     },
                          //     child: const Text('hola')),
                          Column(
                            children: [
                              FutureBuilder(
                                future: getBalance(
                                    "http://zune360.com/api/user/current_balance/"),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .userAmmount = snapshot.data.toString();
                                    return Text(
                                      '৳ ' + snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }

                                  return const Text('');
                                },
                              ),
                              // Text(context
                              //     .read<UserProvider>()
                              //     .useR
                              //     .current_balance
                              //     .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Current balance',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.black,
                          controller: _tabController,
                          tabs: const [
                            //Mobile Banking Tab..
                            Tab(
                              child: Text(
                                'Mobile Banking',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //Bank tab..
                            Tab(
                              child: Text(
                                'Bank',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //Mobile Recharge tab..
                            Tab(
                              child: Text(
                                'Mobile Recharge',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //Gift Card tabs..
                            Tab(
                              child: Text(
                                'Gift Card',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(32),
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // const ApiTest(),
                              const MobileBankingItems(),
                              BankingItems(),
                              const MobileRechargeItem(),
                              GiftCardItems(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
