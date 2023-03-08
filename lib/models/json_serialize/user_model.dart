// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()

/// user model class
class UserModel {
  /// constractor
  UserModel({
    this.id,
    this.client_identity_id,
    this.password,
    this.last_login,
    this.isSuperuser,
    this.username,
    this.first_name,
    this.last_name,
    this.email,
    this.is_staff,
    this.is_active,
    this.date_joined,
    this.phone_number,
    this.current_balance,
    this.user_pin,
    this.mobile_banking,
    this.mobile_recharge,
    this.gift_card,
    this.bank,
    this.isReseller,
    this.groups,
    this.user_permissions,
  });

  /// convert from json
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// id
  int? id;

  ///client identity id
  String? client_identity_id;

  /// password
  String? password;

  /// last login
  String? last_login;

  /// is super user
  bool? isSuperuser;

  /// username
  String? username;

  /// first name
  String? first_name;

  /// last name
  String? last_name;

  /// email
  String? email;

  /// is staff
  bool? is_staff;

  /// is active
  bool? is_active;

  /// date joined
  String? date_joined;

  /// phone number
  String? phone_number;

  /// current balance
  int? current_balance;

  /// user pin
  int? user_pin;

  /// mobile banking
  List<String>? mobile_banking;

  /// mobile recharge
  List<String>? mobile_recharge;

  /// gift card
  String? gift_card;

  /// bank
  List<String>? bank;

  /// is reseller
  bool? isReseller;

  /// groups
  List<dynamic>? groups;

  /// user permissions
  List<dynamic>? user_permissions;

  /// convert to json
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
