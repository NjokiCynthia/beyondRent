import 'package:flutter/material.dart';
import 'dart:math';
import 'package:x_rent/utilities/constants.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    100,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

class DashboardAppbar extends StatelessWidget {
  final String? headerText;
  final String? headerBody;
  final num? leftHeader;
  final Icon? icon;
  const DashboardAppbar({
    super.key,
    this.headerText,
    this.headerBody,
    this.leftHeader,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    ),
                    Text(
                      headerBody!,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: icon,
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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  '+ Kes. 40,000',
                  style: Theme.of(context).textTheme.labelMedium,
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
  const TenantWidget({super.key});
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
                        const Text('Gaseema Nudngu'),
                        Text(
                          'The Icon Heights',
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
                '10, Oct 2022',
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
