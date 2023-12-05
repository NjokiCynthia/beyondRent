class Response {
  String? propertyId;
  String? from;
  String? to;
  int? amountExpected;
  int? amountCollected;
  int? amountInArrears;

  Response(
      {this.propertyId,
      this.from,
      this.to,
      this.amountExpected,
      this.amountCollected,
      this.amountInArrears});
}
