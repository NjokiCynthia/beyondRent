import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/models/invoice.dart';
import 'package:x_rent/screens/dashboard/invoices.dart';
import 'dart:math';
import 'package:x_rent/utilities/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';
import 'package:overlay_support/overlay_support.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(150),
    random.nextInt(256),
    random.nextInt(256),
    0.3,
  );
}

class EmptyTenants extends StatelessWidget {
  const EmptyTenants({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/illustrations/tenant.png', width: 250),
        Text(
          'Tenant list empty.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class EmptyInvoices extends StatelessWidget {
  const EmptyInvoices({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/illustrations/transaction.png', width: 250),
        Text(
          'Invoice list empty.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class EmptyUnits extends StatelessWidget {
  const EmptyUnits({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/illustrations/tenant.png', width: 250),
        Text(
          'Units is empty.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class EmptyUnitList extends StatelessWidget {
  const EmptyUnitList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/illustrations/tenant.png', width: 250),
        Text(
          'Unit list is empty.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Use the button below to set up your unit types.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/illustrations/transaction.png', width: 250),
        Text(
          'Transaction list empty.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class MessageNotification extends StatelessWidget {
  final VoidCallback onReply;
  final String message;
  final String? title;
  final Color? color;

  const MessageNotification({
    Key? key,
    required this.onReply,
    required this.message,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 1,
        ),
        color: color ?? Colors.green,
        child: ListTile(
          title: title == null
              ? null
              : Text(
                  '$title',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
          subtitle: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Global Toast
showToast(context, String title, String message, Color color) {
  return showOverlayNotification((context) {
    return MessageNotification(
      title: title,
      message: message,
      color: color,
      onReply: () {
        OverlaySupportEntry.of(context)!.dismiss();
      },
    );
  });
}

class DashboardAppbar extends StatelessWidget {
  final String? headerText;
  final String? headerBody;
  final num? leftHeader;
  final dynamic icon;
  final dynamic action;
  final bool? propertyNav;
  final bool? backButton;
  final String? backButtonText;
  final ValueSetter<dynamic>? callback;
  const DashboardAppbar({
    super.key,
    this.headerText,
    this.headerBody,
    this.leftHeader,
    this.icon,
    this.action,
    this.propertyNav,
    this.backButton,
    this.backButtonText,
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
        : backButton == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(backButtonText!),
                      )
                    ],
                  ),
                  action ?? Container()
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
                                style:
                                    Theme.of(context).textTheme.displayMedium,
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
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('1');
                    },
                    child: icon,
                    // child: Container(
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.2),
                    //         spreadRadius: 2,
                    //         blurRadius: 4,
                    //         offset: const Offset(0, 2),
                    //       ),
                    //     ],
                    //   ),
                    //   child: icon,
                    // ),
                  ),
                ],
              );
  }
}

class ProgressBar extends StatelessWidget {
  final int? collectedAmount;
  final int? expectedAmount;

  const ProgressBar({
    this.collectedAmount,
    this.expectedAmount,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (collectedAmount ?? 0) / (expectedAmount ?? 1) * 100;

    return Stack(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: percentage / 100,
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

// // Progress Bar
// class ProgressBar extends StatelessWidget {
//   final double? progress;
//   final ValueSetter<dynamic>? callback;
//   const ProgressBar({
//     super.key,
//     this.progress,
//     this.callback,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FractionallySizedBox(
//           widthFactor: 1,
//           child: Container(
//             height: 10,
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         FractionallySizedBox(
//           widthFactor: progress! / 100,
//           child: Container(
//             height: 10,
//             decoration: BoxDecoration(
//               color: mintyGreen,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// Transaction card
class TransactionCard extends StatelessWidget {
  final String? type;
  final String? date;
  final String? amount;
  final Map<String, dynamic>? unit;
  final Map<String, dynamic>? bill;
  final String? reconciliation;
  final String? tenant;
  final String? narrative;
  final String? id;
  final String? house_number;

  const TransactionCard({
    Key? key,
    this.type,
    this.date,
    this.amount,
    this.unit,
    this.bill,
    this.reconciliation,
    this.tenant,
    this.narrative,
    this.id,
    this.house_number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getRandomColor();
    final firstLetter = tenant != null && tenant!.isNotEmpty ? tenant![0] : '';

    final tenantName = tenant
            ?.replaceAllMapped(RegExp(r'\s*\([^)]*\)'), (match) => '')
            .trim() ??
        '';

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1.0,
          ),
        ),
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
            child: Text(
              firstLetter,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$tenantName'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$date',
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
                        '${unit?['house_number'] ?? '0'}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'KES ${currencyFormat.format(double.parse(amount.toString()))}',
                        //'KES. $amount',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: primaryDarkColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${unit?['name'] ?? 'Unit Name'}',
                        // '$unit',
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
                    Text(name!),
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

// Units Widget
class UnitWidget extends StatelessWidget {
  final String? name;
  final String? tenant;
  final num? id;
  final String? unitNo;
  final ValueSetter<dynamic>? callback;
  const UnitWidget({
    super.key,
    this.name,
    this.tenant,
    this.id,
    this.unitNo,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    final backgroundColor = getRandomColor();
    return GestureDetector(
      onTap: () {
        var theObj = {'id': id, 'unitNo': unitNo, 'tenant': tenant};
        callback!(theObj);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: const Text('U'),
                      ),
                      Text(name!),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    tenant == null ? 'Unit not occupied' : 'Unit occupied',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom Sheet Modal
void showBottomModal(BuildContext context, Widget content) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return _buildBottomModalContent(context, content);
    },
  );
}

Widget _buildBottomModalContent(BuildContext context, Widget content) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: content,
    ),
  );
}

class CustomOutlinedButton extends StatefulWidget {
  final String? authorization;
  final String? cookie;
  final bool? buttonError;
  final String? buttonErrorMessage;
  final String? url;
  final String method;
  final String buttonText;
  final Map<String, dynamic> body;
  final dynamic onSuccess;

  const CustomOutlinedButton({
    super.key,
    this.authorization,
    this.cookie,
    this.buttonError,
    this.buttonErrorMessage,
    this.url,
    required this.method,
    required this.buttonText,
    required this.body,
    required this.onSuccess,
  });

  @override
  _CustomOutlinedButtonState createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  bool isButtonDisabled = false;
  bool isLoading = false;
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
  }

  Future<void> sendRequest() async {
    if (widget.buttonError == true) {
      return widget.onSuccess({
        'isSuccessful': false,
        'error': widget.buttonErrorMessage,
      });
    }
    if (widget.url == null) {
      return widget.onSuccess({'isSuccessful': true});
    }
    setState(() {
      isButtonDisabled = true;
      isLoading = true;
    });

    try {
      final response = await _makeRequest();
      setState(() {
        isButtonDisabled = false;
        isLoading = false;
      });
      if (response.statusCode == 200) {
        // Request was successful
        widget.onSuccess({'isSuccessful': true, 'data': response.data});
      } else {
        // Request returned an error status code
        widget.onSuccess({
          'isSuccessful': false,
          'error': response.data['error'],
        });
      }
    } on DioException catch (error) {
      print('error');
      print(error);
      // setState(() {
      //   isButtonDisabled = false;
      //   isLoading = false;
      // });
      // var serverError = error.error;
      // var theError = error.response?.data;
      // var theStatus = error.response?.statusCode;

      // print('serverError: $serverError');
      // print('error: $error');
      // print('theError: $theError');
      // print('theStatus: $theStatus');

      // widget.onSuccess({
      //   'isSuccessful': false,
      //   'error': 'Error making request',
      // });
    }

    setState(() {
      isButtonDisabled = false;
      isLoading = false;
    });
  }

  Future<Response<dynamic>> _makeRequest() async {
    // Retrieve user information from provider
    final headers = {
      'Versioncode': 99,
      'version': 99,
      'Authorization': widget.authorization ?? '',
      'Cookie': widget.cookie ?? ''
    };
    final options = Options(contentType: 'application/json', headers: headers);
    try {
      if (widget.method == 'POST') {
        return _dio.post(
          ipAddress + widget.url!,
          data: widget.body,
          options: options,
        );
      } else if (widget.method == 'GET') {
        return _dio.get(ipAddress + widget.url!, options: options);
      }
    } catch (error) {
      throw Exception('Invalid request method: ${widget.method}');
    }
    throw Exception('Invalid request method: ${widget.method}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isButtonDisabled ? null : sendRequest,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2000),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: mintyGreen),
          borderRadius:
              isLoading ? BorderRadius.circular(8) : BorderRadius.circular(8),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: isLoading
              ? SpinKitThreeBounce(
                  color: mintyGreen,
                  size: 20,
                )
              : Text(
                  widget.buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: mintyGreen, fontSize: 16),
                ),
        ),
      ),
    );
  }
}

class CustomRequestButton extends StatefulWidget {
  final String? authorization;
  final String? cookie;
  final bool? buttonError;
  final String? buttonErrorMessage;
  final String? url;
  final String method;
  final String buttonText;
  final Map<String, dynamic> body;
  final dynamic onSuccess;

  const CustomRequestButton({
    super.key,
    this.authorization,
    this.cookie,
    this.buttonError,
    this.buttonErrorMessage,
    this.url,
    required this.method,
    required this.buttonText,
    required this.body,
    required this.onSuccess,
  });

  @override
  _CustomRequestButtonState createState() => _CustomRequestButtonState();
}

class _CustomRequestButtonState extends State<CustomRequestButton> {
  bool isButtonDisabled = false;
  bool isLoading = false;
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
  }

  Future<void> sendRequest() async {
    if (widget.buttonError == true) {
      return widget.onSuccess({
        'isSuccessful': false,
        'error': widget.buttonErrorMessage,
      });
    }
    if (widget.url == null) {
      return widget.onSuccess({'isSuccessful': true});
    }
    setState(() {
      isButtonDisabled = true;
      isLoading = true;
    });

    try {
      final response = await _makeRequest();

      setState(() {
        isButtonDisabled = false;
        isLoading = false;
      });
      if (response.statusCode == 200) {
        // Request was successful
        widget.onSuccess({'isSuccessful': true, 'data': response.data});
      } else {
        // Request returned an error status code
        widget.onSuccess({
          'isSuccessful': false,
          'error': response.data['error'],
        });
      }
    } on DioException catch (error) {
      print('error');
      print(error);
      // setState(() {
      //   isButtonDisabled = false;
      //   isLoading = false;
      // });
      // var serverError = error.error;
      // var theError = error.response?.data;
      // var theStatus = error.response?.statusCode;

      // print('serverError: $serverError');
      // print('error: $error');
      // print('theError: $theError');
      // print('theStatus: $theStatus');

      // widget.onSuccess({
      //   'isSuccessful': false,
      //   'error': 'Error making request',
      // });
    }

    setState(() {
      isButtonDisabled = false;
      isLoading = false;
    });
  }

  Future<Response<dynamic>> _makeRequest() async {
    final headers = {
      'Versioncode': 99,
      'version': 99,
      'Authorization': widget.authorization ?? '',
      'Cookie': widget.cookie ?? ''
    };
    final options = Options(contentType: 'application/json', headers: headers);
    try {
      if (widget.method == 'POST') {
        return _dio.post(
          ipAddress + widget.url!,
          data: widget.body,
          options: options,
        );
      } else if (widget.method == 'GET') {
        return _dio.get(ipAddress + widget.url!, options: options);
      }
    } catch (error) {
      throw Exception('Invalid request method: ${widget.method}');
    }
    throw Exception('Invalid request method: ${widget.method}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isButtonDisabled ? null : sendRequest,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2000),
        decoration: BoxDecoration(
          color: mintyGreen,
          borderRadius:
              isLoading ? BorderRadius.circular(8) : BorderRadius.circular(8),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: isLoading
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                )
              : Text(
                  widget.buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
        ),
      ),
    );
  }
}

// Widget _buildBottomModalContent(BuildContext context, Widget content) {
//   return ClipRRect(
//     borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//     child: Container(
//       color: Colors.white,
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
//         child: content,
//       ),
//     ),
//   );
// }

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
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
      child: ListTile(
        title: Text(invoice.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              invoice.timeline,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: invoice.statusColor.withOpacity(0.2),
                    border: Border.all(),
                  ),
                  child: Text(
                    invoice.status,
                    style: TextStyle(color: invoice.statusColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rent',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Kes ${invoice.amount}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class InvoicesCard extends StatelessWidget {
  final PendingInvoice invoice;

  const InvoicesCard({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getRandomColor();
    final firstLetter = invoice.tenant != null && invoice.tenant!.isNotEmpty
        ? invoice.tenant![0]
        : '';

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  firstLetter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${invoice.tenant}'),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'KES ${currencyFormat.format(double.parse(invoice.pendingAmount.toString()))}',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: primaryDarkColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Text(
                  'Invoice due date:',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 13, color: Colors.black),
                ),
                Text(
                  '${invoice.dueDate}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
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

class WithdrawalCard extends StatelessWidget {
  final Invoice invoice;

  const WithdrawalCard({required this.invoice});

  @override
  Widget build(BuildContext context) {
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
      child: ListTile(
        title: Text(invoice.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              invoice.timeline,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: invoice.statusColor.withOpacity(0.2),
                    border: Border.all(),
                  ),
                  child: Text(
                    invoice.status,
                    style: TextStyle(color: invoice.statusColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rent',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Kes ${invoice.amount}',
              //'Kes ${invoice.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
