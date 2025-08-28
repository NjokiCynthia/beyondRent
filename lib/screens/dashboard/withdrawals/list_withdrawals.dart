// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class Withdrawals extends StatefulWidget {
  const Withdrawals({super.key});

  @override
  State<Withdrawals> createState() => _WithdrawalsState();
}

class _WithdrawalsState extends State<Withdrawals>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool withdrawalListLoaded = false;
  int _currentTabIndex = 0;
  List<Map<String, dynamic>> withdrawalList = [];
  int _getStatusForTabIndex(int index) {
    switch (index) {
      case 0:
        return 2; // DISBURSED
      case 1:
        return 15; // PENDING
      case 2:
        return 16; // DECLINED
      default:
        return 15; // Default to DISBURSED
    }
  }

  // int _getStatusForTabIndex(int index) {
  //   // Define the mapping of tab index to status values
  //   const List<int> tabStatusValues = [15, 2, 3];

  //   // Return the corresponding status value based on the tab index
  //   return tabStatusValues[index];
  // }

  Future<void> fetchWithdrawals(int status) async {
    print('I want to fetch withdrawals for status $status');
    setState(() {
      withdrawalListLoaded = false;
    });
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;
    final id = userProvider.user?.id;

    final postData = {
      "user_id": id,
      "property_id": propertyProvider.property?.id,
      "sort_by": "date_desc",
      "status": [status],
    };
    print(id);
    print(propertyProvider.property?.id);

    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await apiClient.post(
        '/mobile/withdrawals/withdrawal_request_list',
        postData,
        headers: headers,
      );

      var responseStatus = response['response']['status'];
      if (responseStatus == 1) {
        print('These are my withdrawal details below here >>>>>>>>>>>');
        print(response['response']['posts']);

        List<Map<String, dynamic>> posts =
            List.from(response['response']['posts']);

        setState(() {
          withdrawalList = posts;
          withdrawalListLoaded = true;
        });
      }
    } catch (e) {
      print('Error');
      print(e);
    }

    setState(() {
      withdrawalListLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animation?.addListener(() {
      if (_tabController.indexIsChanging) {
        // Tab is changing, fetch data for the selected tab
        if (_currentTabIndex != _tabController.index) {
          _currentTabIndex = _tabController.index;
          fetchWithdrawals(_getStatusForTabIndex(_currentTabIndex));
        }
      }
    });

    fetchWithdrawals(_getStatusForTabIndex(0));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: primaryDarkColor.withValues(alpha: 0.01)));

    return WillPopScope(
      onWillPop: () async {
        // Handle navigation when the back button is pressed
        // Use Navigator.popUntil to navigate back approximately three steps
        int popCount = 1; // Set the number of steps you want to go back
        Navigator.popUntil(context, (route) {
          popCount--;
          return popCount < 0;
        });
        return false; // Return false to prevent the default system back behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryDarkColor.withValues(alpha: 0.1),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: primaryDarkColor,
            ),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'List Withdrawals',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: primaryDarkColor,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicator:
                BoxDecoration(color: primaryDarkColor.withValues(alpha: 0.5)),
            tabs: const [
              Tab(
                text: 'PENDING DISBURSEMENT',
              ),
              Tab(text: 'DISBURSED'),
              Tab(text: 'FAILED'),
            ],
          ),
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Pending Tab
                      buildWithdrawalsList(),

                      // Disbursed Tab
                      buildWithdrawalsList(),

                      // Failed Tab
                      buildWithdrawalsList(),
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

  Widget buildWithdrawalsList() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: !withdrawalListLoaded
          ? Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: mintyGreen,
                ),
              ),
            )
          : withdrawalList.isEmpty
              ? const EmptyTransactions()
              : ListView.builder(
                  itemCount: withdrawalList.length,
                  itemBuilder: (context, index) {
                    var withdrawal = withdrawalList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.fromBorderSide(BorderSide(
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: primaryDarkColor.withValues(alpha: 0.1)))
                            // border: Border.all(
                            //     color: primaryDarkColor.withValues(alpha:0.1)),
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${withdrawal['date']}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: primaryDarkColor.withValues(
                                          alpha: 0.1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 2, bottom: 2),
                                    child: Text(
                                      'KES ${currencyFormat.format(double.parse(withdrawal['amount'].toString()))}',
                                      style: const TextStyle(
                                          color: primaryDarkColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                '${withdrawal['status']} to ${withdrawal['name']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Recepient:'),
                            Text(
                                '${withdrawal['recipient']} to ${withdrawal['name']}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }
}
