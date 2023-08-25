import 'package:flutter/material.dart';
import 'dart:math';
import 'package:x_rent/utilities/constants.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(150),
    random.nextInt(256),
    random.nextInt(256),
    0.3,
  );
}

class DashboardAppbar extends StatelessWidget {
  final String? headerText;
  final String? headerBody;
  final num? leftHeader;
  final dynamic icon;
  final bool? propertyNav;
  final ValueSetter<dynamic>? callback;
  const DashboardAppbar({
    super.key,
    this.headerText,
    this.headerBody,
    this.leftHeader,
    this.icon,
    this.propertyNav,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return propertyNav == true
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/icons/left-arrow.png',
                    width: 15,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  callback!('date');
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Aug 2023',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black.withOpacity(0.2),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  callback!('');
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/icons/info.png',
                    width: 15,
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: leftHeader == 1
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headerText!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            headerBody!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headerText!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            headerBody!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
              ),
              GestureDetector(
                onTap: () {
                  callback!('1');
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: icon,
                ),
              ),
            ],
          );
  }
}

// Progress Bar
class ProgressBar extends StatelessWidget {
  final double? progress;
  final ValueSetter<dynamic>? callback;
  const ProgressBar({
    super.key,
    this.progress,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress! / 100,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: mintyGreen,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

// Transaction card
class TransactionCard extends StatelessWidget {
  final String? name;
  final String? date;
  final num? amount;
  final ValueSetter<dynamic>? callback;
  const TransactionCard({
    super.key,
    this.name,
    this.date,
    this.amount,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getRandomColor();
    return Container(
      // margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border(
          bottom: BorderSide(
            //                   <--- left side
            color: Colors.grey.withOpacity(0.1),
            width: 1.0,
          ),
        ),
        // borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 0.5,
        //     blurRadius: 1,
        //     offset: const Offset(0, 1),
        //   ),
        // ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: const Text('M'),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name!),
                      Text(
                        date!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '+ Kes. 40,000',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        'House Rent',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Tenants Widget
class TenantWidget extends StatelessWidget {
  final String? name;
  final String? date;
  final num? amount;
  final ValueSetter<dynamic>? callback;
  const TenantWidget({
    super.key,
    this.name,
    this.date,
    this.amount,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    final backgroundColor = getRandomColor();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text('M'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name!),
                        Text(
                          'Elgon Court',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.phone,
                  color: Colors.green,
                  size: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$date',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Kes. -27,000',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Pending',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Bottom Sheet Modal
showBottomModal(BuildContext context, Widget content) {
  showModalBottomSheet<void>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return _buildBottomModalContent(context, content);
    },
  );
}

Widget _buildBottomModalContent(BuildContext context, Widget content) {
  return ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
    child: Container(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        child: content,
      ),
    ),
  );
}
