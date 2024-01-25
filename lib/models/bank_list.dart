class BanksList {
  int? status;
  String? message;
  List<Banks>? banks;

  BanksList({this.status, this.message, this.banks});

  BanksList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.banks != null) {
      data['banks'] = this.banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  String? id;
  String? name;
  String? logo;

  Banks({this.id, this.name, this.logo});

  Banks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}