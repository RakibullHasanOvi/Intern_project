// import 'package:flutter/material.dart';

// import '../../models/pages/bank_item.dart';
// import '../../models/pages/giftCard_items.dart';
// import '../../models/pages/mb_items.dart';
// import '../../models/pages/recharge_item.dart';

// class TabWidgets extends StatefulWidget {
//   final _tabController;
//   const TabWidgets(Key? key, this._tabController) : super(key: key);

//   @override
//   State<TabWidgets> createState() => _TabWidgetsState();
// }

// class _TabWidgetsState extends State<TabWidgets> with TickerProviderStateMixin {
//   late TabController _tabController = TabController(length: 4, vsync: this);
//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       isScrollable: true,
//       indicatorColor: Colors.transparent,
//       unselectedLabelColor: Colors.grey,
//       labelColor: Colors.black,
//       controller: _tabController,
//       tabs: const [
//         //Mobile Banking Tab..
//         Tab(
//           child: Text(
//             'Mobile Banking',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         //Bank tab..
//         Tab(
//           child: Text(
//             'Bank',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         //Mobile Recharge tab..
//         Tab(
//           child: Text(
//             'Mobile Recharge',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         //Gift Card tabs..
//         Tab(
//           child: Text(
//             'Gift Card',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//     //     TabBarView(
//     //       controller: _tabController,
//     //       children: [
//     //         // const ApiTest(),
//     //         const MobileBankingItems(),
//     //         BankingItems(),
//     //         const MobileRechargeItem(),
//     //         GiftCardItems(),
//     //       ],
//     //     ),
//     //   ],
//     // );
//   }
// }
