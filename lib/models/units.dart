class Response {
  int? status;
  int? time;
  String? message;
  int? totalUnits;
  int? totalVacantUnits;
  int? totalActiveUnits;
  int? totalOccupiedUnits;
  int? totalTenants;

  Response(
      {this.status,
      this.time,
      this.message,
      this.totalUnits,
      this.totalVacantUnits,
      this.totalActiveUnits,
      this.totalOccupiedUnits,
      this.totalTenants});
}
