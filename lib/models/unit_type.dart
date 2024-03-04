class UnitType {
  final String id;
  final String name;
  final String amount;
  final String type;
  final String contributionType;
  final String frequency;
  final String invoiceDate;
  final String contributionDate;
  final bool oneTimeContributionSetting;
  final bool isHidden;
  final bool active;

  UnitType({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.contributionType,
    required this.frequency,
    required this.invoiceDate,
    required this.contributionDate,
    required this.oneTimeContributionSetting,
    required this.isHidden,
    required this.active,
  });
}
