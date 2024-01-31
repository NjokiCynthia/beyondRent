class BankBranches {
  final int id;
  final String name;

  BankBranches({
    required this.id,
    required this.name,
  });

  factory BankBranches.fromJson(Map<String, dynamic> json) {
    return BankBranches(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
