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
        bankBranches!.add(new BankBranches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.bankBranches != null) {
      data['bank_branches'] =
          this.bankBranches!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}