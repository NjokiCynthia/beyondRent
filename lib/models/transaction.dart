class Contributions {
  String? id;
  String? name;
  String? amount;
  String? type;
  String? contributionType;
  String? frequency;
  String? invoiceDate;
  String? contributionDate;
  int? oneTimeContributionSetting;
  int? isHidden;
  int? active;

  Contributions(
      {this.id,
      this.name,
      this.amount,
      this.type,
      this.contributionType,
      this.frequency,
      this.invoiceDate,
      this.contributionDate,
      this.oneTimeContributionSetting,
      this.isHidden,
      this.active});
}
