// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      client_identity_id: json['client_identity_id'] as String?,
      password: json['password'] as String?,
      last_login: json['last_login'] as String?,
      isSuperuser: json['isSuperuser'] as bool?,
      username: json['username'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      is_staff: json['is_staff'] as bool?,
      is_active: json['is_active'] as bool?,
      date_joined: json['date_joined'] as String?,
      phone_number: json['phone_number'] as String?,
      current_balance: json['current_balance'] as dynamic,
      user_pin: json['user_pin'] as int?,
      mobile_banking: (json['mobile_banking'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mobile_recharge: (json['mobile_recharge'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gift_card: json['gift_card'].toString() as dynamic,
      bank: (json['bank'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isReseller: json['isReseller'] as bool?,
      groups: json['groups'] as List<dynamic>?,
      user_permissions: json['user_permissions'] as List<dynamic>?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'client_identity_id': instance.client_identity_id,
      'password': instance.password,
      'last_login': instance.last_login,
      'isSuperuser': instance.isSuperuser,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'is_staff': instance.is_staff,
      'is_active': instance.is_active,
      'date_joined': instance.date_joined,
      'phone_number': instance.phone_number,
      'current_balance': instance.current_balance,
      'user_pin': instance.user_pin,
      'mobile_banking': instance.mobile_banking.toString(),
      'mobile_recharge': instance.mobile_recharge.toString(),
      'gift_card': instance.gift_card,
      'bank': instance.bank,
      'isReseller': instance.isReseller,
      'groups': instance.groups,
      'user_permissions': instance.user_permissions,
    };
