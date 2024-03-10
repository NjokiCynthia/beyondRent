class Branch {
  int? status;
  String? message;
  List<BankBranches>? bankBranches;

  Branch({this.status, this.message, this.bankBranches});

  Branch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['bank_branches'] != null) {
      bankBranches = <BankBranches>[];
      json['bank_branches'].forEach((v) {
        bankBranches!.add(BankBranches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (bankBranches != null) {
      data['bank_branches'] = bankBranches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankBranches {
  int? id;
  String? name;

  BankBranches({this.id, this.name});

  BankBranches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
