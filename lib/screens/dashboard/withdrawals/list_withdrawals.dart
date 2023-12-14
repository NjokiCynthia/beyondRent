import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/invoices/create_invoice.dart';
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
  List<Map<String, dynamic>> withdrawalList = [];

  fetchWithdrawals(int status) async {
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
    print('What i am sending to backend');
    print(postData);
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
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Tab is changing, fetch data for the selected tab
        fetchWithdrawals(
            _tabController.index + 1); // +1 because your statuses start from 1
      }
    });

    fetchWithdrawals(1); // Initial fetch for the first tab
  }

  @override
  Widget build(BuildContext context) {
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
          //backgroundColor: backColor.withOpacity(0.02),
          backgroundColor: primaryDarkColor.withOpacity(0.1),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: primaryDarkColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'List Withdrawals',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: primaryDarkColor,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicator: BoxDecoration(color: primaryDarkColor.withOpacity(0.5)),
            tabs: [
              Tab(
                text: 'DISBURSED',
              ),
              Tab(text: 'PENDING'),
              Tab(text: 'DECLINED'),
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
      child: withdrawalListLoaded == false
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
                                color: primaryDarkColor.withOpacity(0.1)))
                            // border: Border.all(
                            //     color: primaryDarkColor.withOpacity(0.1)),
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
                                      color: primaryDarkColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 2, bottom: 2),
                                    child: Text(
                                      'KES ${currencyFormat.format(double.parse(withdrawal['amount'].toString() ?? "0"))}',
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
                            Text('${withdrawal['status']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }
}
