import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/dashboard/invoices/list_invoices.dart';

class CreateInvoice extends StatefulWidget {
  const CreateInvoice({super.key});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  bool sendEmail = false;
  bool sendSMS = false;
  DateTime? selectedDueDate;
  TextEditingController dueDateController = TextEditingController();
  Future<void> _selectDueDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime day) {
        // Allow selecting only days from today and onward
        return day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: primaryDarkColor,
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(primary: primaryDarkColor)
                .copyWith(secondary: primaryDarkColor),
            dialogBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              displayLarge:
                  TextStyle(color: Colors.white), // Change number color
              bodyLarge:
                  TextStyle(color: primaryDarkColor), // Change text color
            ),
          ),
          child: child!,
        );
      },
    ).then((DateTime? picked) {
      if (picked != null && picked != selectedDueDate) {
        setState(() {
          selectedDueDate = picked;
          dueDateController.text = picked.toLocal().toString();
        });
      }
    });
  }

  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime day) {
        // Allow selecting only days from today and onward
        return day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: primaryDarkColor,
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(primary: primaryDarkColor)
                .copyWith(secondary: primaryDarkColor),
            dialogBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              displayLarge:
                  TextStyle(color: Colors.white), // Change number color
              bodyLarge:
                  TextStyle(color: primaryDarkColor), // Change text color
            ),
          ),
          child: child!,
        );
      },
    ).then((DateTime? picked) {
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          dateController.text = picked.toLocal().toString();
        });
      }
    });
  }

  String? selectedInvoiceType;
  String? selectedTenantsOption;
  String? selectedUnit;
  String? selectedTenant;
  String? selectedBill;
  bool includeSupplementaryBills = false;
  String selectedSupplementaryBill = '';
  String billName = '';
  String billOption = 'Varying';
  String amount = '';
  List<Map<String, dynamic>> bills = [];
  List<DropdownMenuItem<String>> dropdownItems = [];
  Future<void> _showAddUtilitiesBottomSheet(BuildContext context) async {
    final TextEditingController billNameController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Dismiss the keyboard
          },
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Enter the bill name'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: billNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: ' eg, water',
                          labelStyle:
                              MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            billName = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text('Select the Bill Option: '),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Select option',
                          labelStyle:
                              MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        value: billOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            billOption = newValue!;
                          });
                        },
                        items: <String>['Varying', 'Fixed']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      if (billOption == 'Varying')
                        const Text('Specify the bill amount'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter bill amount',
                          labelStyle:
                              MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            amount = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: primaryDarkColor),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Check the values and act accordingly
                              print(
                                  'Bill Name: $billName, Bill Option: $billOption');

                              if (billOption == 'Varying') {
                                print('Amount: $amount');
                              }

                              // Add the bill to the list
                              setState(() {
                                bills.add({
                                  'billName': billName,
                                  'billOption': billOption,
                                  'amount': amount,
                                });
                                selectedBill = billName;
                              });

                              Navigator.of(context)
                                  .pop(); // Close the bottom sheet
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryDarkColor),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor.withOpacity(0.02),
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: primaryDarkColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Create an invoice',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Container(
                decoration: BoxDecoration(
                    color: primaryDarkColor.withOpacity(0.1),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.check,
                    color: primaryDarkColor,
                  ),
                )),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.price_change_outlined,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Select your preferred invoice type'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: selectedInvoiceType,
              items: [
                'Rent Invoice',
                'Supplementary Bill Invoice',
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedInvoiceType = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Select invoice type',
                labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.home_outlined,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Select unit to invoice'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: selectedUnit,
              items: [
                'F1',
                'F2',
                'F3',
                'F4',
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedUnit = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Select unit',
                labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.people_alt_outlined,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Select tenants option to invoice'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: selectedTenantsOption,
              items: [
                'All Tenants',
                'Individual Tenants',
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedTenantsOption = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Send invoice to',
                labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Visibility(
              visible: selectedTenantsOption == 'Individual Tenants',
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryDarkColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Select tenant to invoice'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedTenant,
                    items: [
                      'Cynthia Njoki',
                      'Kennedy Mwangi',
                      'Fred Murigi',
                      'Samuel Wahome',
                      'Jane Mugo'
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedTenant = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Select tenant to invoice',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.money_off,
                        color: primaryDarkColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Enter the total amount payable',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: bodyText,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'KES 20,000',
                      // labelText: 'KES 20,000',

                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: selectedInvoiceType == 'Rent Invoice',
              child: Row(
                children: [
                  Checkbox(
                    activeColor: primaryDarkColor,
                    value: includeSupplementaryBills,
                    onChanged: (value) {
                      setState(() {
                        includeSupplementaryBills = value!;
                        // Reset selected supplementary bill when checkbox is unchecked
                        if (!includeSupplementaryBills) {
                          selectedSupplementaryBill = '';
                        }
                      });
                    },
                  ),
                  const Text('Include supplementary bills'),
                ],
              ),
            ),
            if (includeSupplementaryBills)
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select bill'),
                      GestureDetector(
                        onTap: () async {
                          // Show the add bill bottom sheet and wait for the result
                          await _showAddUtilitiesBottomSheet(context);

                          // Update the dropdown items with the new bill
                          setState(() {
                            dropdownItems.add(DropdownMenuItem<String>(
                              value: billName,
                              child: Text(billName),
                            ));
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: primaryDarkColor,
                            ),
                            Text(
                              'Add a bill',
                              style: TextStyle(color: primaryDarkColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    items:
                        dropdownItems, // Use the updated list of dropdown items
                    onChanged: (String? value) {
                      setState(() {
                        selectedBill = value!;
                      });
                    },
                    value: selectedBill,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Select bill to invoice',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Select invoice date',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: dateController,
              onTap: () => _selectDate(context),
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: primaryDarkColor,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Select date',
                labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Select invoice due date',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: dueDateController,
              onTap: () => _selectDueDate(context),
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: primaryDarkColor,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Select due date',
                labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.edit_document,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Enter the invoice description',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              minLines: 3, // Set this
              maxLines: 6,
              style: bodyText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter the description',
                labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
                    .copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  activeColor: primaryDarkColor,
                  value: sendEmail,
                  onChanged: (bool? value) {
                    setState(() {
                      sendEmail = value ?? false;
                    });
                  },
                ),
                const Text('Send Email'),
                const SizedBox(width: 20),
                Checkbox(
                  activeColor: primaryDarkColor,
                  value: sendSMS,
                  onChanged: (bool? value) {
                    setState(() {
                      sendSMS = value ?? false;
                    });
                  },
                ),
                const Text('Send SMS'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const ListInvoices())));
                  },
                  child: const Text('Confirm')),
            )
          ],
        ),
      ))),
    );
  }
}
