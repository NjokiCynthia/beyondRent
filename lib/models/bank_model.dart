class Banks {
  String? id;
  String? bankId;
  String? bankBranchId;
  String? groupId;
  String? accountName;
  String? accountNumber;
  Null initialBalance;
  String? currentBalance;
  Null signatoryPhone;
  Null signatoryIdNumber;
  Null isVerified;
  String? active;
  Null isClosed;
  String? createdBy;
  String? createdOn;
  Null modifiedBy;
  String? modifiedOn;
  String? enableEmailTransactionAlertsToMembers;
  Null enableSmsTransactionAlertsToMembers;
  Null isDeleted;
  Null verifiedOn;
  Null accountPassword;
  Null isDefault;
  Null hasTransactionAlerts;
  Null enableEmailTransactionAlertsToGroupAccountManagers;
  Null enableSmsTransactionAlertsToGroupAccountManagers;
  Null enableEmailTransactionAlertsToManagers;
  Null enableSmsTransactionAlertsToManagers;
  Null oldId;
  Null accountCurrencyId;
  Null onboardedFromPanel;
  Null isAccountWhitelisted;
  Null enableEmailTransactionAlertsToTenants;
  String? bankName;
  String? partner;
  String? bankBranch;

  Banks(
      {this.id,
      this.bankId,
      this.bankBranchId,
      this.groupId,
      this.accountName,
      this.accountNumber,
      this.initialBalance,
      this.currentBalance,
      this.signatoryPhone,
      this.signatoryIdNumber,
      this.isVerified,
      this.active,
      this.isClosed,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.enableEmailTransactionAlertsToMembers,
      this.enableSmsTransactionAlertsToMembers,
      this.isDeleted,
      this.verifiedOn,
      this.accountPassword,
      this.isDefault,
      this.hasTransactionAlerts,
      this.enableEmailTransactionAlertsToGroupAccountManagers,
      this.enableSmsTransactionAlertsToGroupAccountManagers,
      this.enableEmailTransactionAlertsToManagers,
      this.enableSmsTransactionAlertsToManagers,
      this.oldId,
      this.accountCurrencyId,
      this.onboardedFromPanel,
      this.isAccountWhitelisted,
      this.enableEmailTransactionAlertsToTenants,
      this.bankName,
      this.partner,
      this.bankBranch});
}
