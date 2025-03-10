class UserModel {
  final int id;
  final String name;
  final String email;
  final String userType;
  final String? referralCode;
  final String? earnings;
  final int? companyId;
  final int status;
  final String? emailVerifiedAt;
  final String? userTypeText;
  final int? planId;
  final int mobile;
  final String? mobileIntro;
  final int countryId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    this.referralCode,
    this.earnings,
    this.companyId,
    required this.status,
    this.emailVerifiedAt,
    this.userTypeText,
    this.planId,
    required this.mobile,
    this.mobileIntro,
    required this.countryId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userType: json['user_type'],
      referralCode: json['referral_code'],
      earnings: json['earnings'],
      companyId: json['company_id'],
      status: json['status'],
      emailVerifiedAt: json['email_verified_at'],
      userTypeText: json['user_type_text'],
      planId: json['plan_id'],
      mobile: json['mobile'] is int
          ? json['mobile']
          : int.tryParse(json['mobile'].toString()) ?? 0,
      mobileIntro: json['mobile_intro']?.toString(), // يحول إلى String دائمًا
      countryId: json['country_id'] is int
          ? json['country_id']
          : int.tryParse(json['country_id'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'user_type': userType,
      'referral_code': referralCode,
      'earnings': earnings,
      'company_id': companyId,
      'status': status,
      'email_verified_at': emailVerifiedAt,
      'user_type_text': userTypeText,
      'plan_id': planId,
      'mobile': mobile,
      'mobile_intro': mobileIntro,
      'country_id': countryId,
    };
  }
}
