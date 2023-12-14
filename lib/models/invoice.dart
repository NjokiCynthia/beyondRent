class PendingInvoice {
  String? id;
  String? invoiceDate;
  String? month;
  String? dueDate;
  String? tenant;
  String? type;
  String? amountPayable;
  double? amountPaid; // Change the type to double
  Unit? unit; // Include the unit field

  PendingInvoice({
    this.id,
    this.invoiceDate,
    this.month,
    this.dueDate,
    this.tenant,
    this.type,
    this.amountPayable,
    this.amountPaid,
    this.unit,
  });

  // Factory method to create a PendingInvoice from a JSON object
  factory PendingInvoice.fromJson(Map<String, dynamic> json) {
    return PendingInvoice(
      id: json['id'],
      invoiceDate: json['invoice_date'],
      month: json['month'],
      dueDate: json['due_date'],
      tenant: json['tenant'],
      type: json['type'],
      amountPayable: json['amount_payable'],
      amountPaid: json['amount_paid'] != null
          ? (json['amount_paid'] is int
              ? (json['amount_paid'] as int).toDouble()
              : json['amount_paid'].toDouble())
          : null,
      unit: json['unit'] != null ? Unit.fromJson(json['unit']) : null,
    );
  }
}

class Unit {
  String? houseNumber;
  String? floor;
  String? block;

  Unit({
    this.houseNumber,
    this.floor,
    this.block,
  });

  // Factory method to create a Unit from a JSON object
  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      houseNumber: json['house_number'],
      floor: json['floor'],
      block: json['block'],
    );
  }
}
