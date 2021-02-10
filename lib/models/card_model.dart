import 'dart:convert';

class CardModel {
  String cardSerialNumber;
  String cardNumber;
  double balance;
  int statusCardId;
  String cardExpirationDate;
  String cardVerificationValue;
  String cardLastNumbers;
  bool showDetails;

  CardModel({
    this.cardSerialNumber,
    this.cardNumber,
    this.balance,
    this.statusCardId,
    this.cardExpirationDate,
    this.cardVerificationValue,
    this.cardLastNumbers,
  });

  CardModel.fromJson(Map<String, dynamic> json) {
    cardSerialNumber = json['cardSerialNumber'];
    // cardNumber = json['cardNumber'].replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
    cardNumber = json['cardNumber'];
    balance = json['balance'];
    statusCardId = json['statusCardId'];
    cardExpirationDate = json['cardExpirationDate'];
    cardVerificationValue = json['cardVerificationValue'];
    cardLastNumbers = json['cardLastNumbers'];
    showDetails = json[false];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cardSerialNumber'] = this.cardSerialNumber;
    data['cardNumber'] = this.cardNumber;
    data['balance'] = this.balance;
    data['statusCardId'] = this.statusCardId;
    data['cardExpirationDate'] = this.cardExpirationDate;
    data['cardVerificationValue'] = this.cardVerificationValue;
    data['cardLastNumbers'] = this.cardLastNumbers;
    data['showDetails'] = false;

    return data;
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
