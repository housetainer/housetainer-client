import 'dart:convert';

class SignUpRequest {
  final String email;
  final String authId;
  final String authProvider;
  final String name;
  final String nickname;
  final String gender;
  final String birthday;
  final String phoneNumber;
  final String profileImage;
  final String countryCode;
  final String languageCode;
  SignUpRequest({
    this.email = '',
    this.authId = '',
    this.authProvider = '',
    this.name = '',
    this.nickname = '',
    this.gender = '',
    this.birthday = '',
    this.phoneNumber = '',
    this.profileImage = '',
    this.countryCode = '',
    this.languageCode = '',
  });

  SignUpRequest copyWith({
    String? email,
    String? authId,
    String? authProvider,
    String? name,
    String? nickname,
    String? gender,
    String? birthday,
    String? phoneNumber,
    String? profileImage,
    String? countryCode,
    String? languageCode,
  }) {
    return SignUpRequest(
      email: email ?? this.email,
      authId: authId ?? this.authId,
      authProvider: authProvider ?? this.authProvider,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      countryCode: countryCode ?? this.countryCode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'authId': authId,
      'authProvider': authProvider,
      'name': name,
      'nickname': nickname,
      'gender': gender,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'countryCode': countryCode,
      'languageCode': languageCode,
    };
  }

  factory SignUpRequest.fromMap(Map<String, dynamic> map) {
    return SignUpRequest(
      email: map['email'] as String,
      authId: map['authId'] as String,
      authProvider: map['authProvider'] as String,
      name: map['name'] as String,
      nickname: map['nickname'] as String,
      gender: map['gender'] as String,
      birthday: map['birthday'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profileImage: map['profileImage'] as String,
      countryCode: map['countryCode'] as String,
      languageCode: map['languageCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpRequest.fromJson(String source) => SignUpRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpRequest(email: $email, authId: $authId, authProvider: $authProvider, name: $name, nickname: $nickname, gender: $gender, birthday: $birthday, phoneNumber: $phoneNumber, profileImage: $profileImage, countryCode: $countryCode, languageCode: $languageCode)';
  }

  @override
  bool operator ==(covariant SignUpRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.authId == authId &&
      other.authProvider == authProvider &&
      other.name == name &&
      other.nickname == nickname &&
      other.gender == gender &&
      other.birthday == birthday &&
      other.phoneNumber == phoneNumber &&
      other.profileImage == profileImage &&
      other.countryCode == countryCode &&
      other.languageCode == languageCode;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      authId.hashCode ^
      authProvider.hashCode ^
      name.hashCode ^
      nickname.hashCode ^
      gender.hashCode ^
      birthday.hashCode ^
      phoneNumber.hashCode ^
      profileImage.hashCode ^
      countryCode.hashCode ^
      languageCode.hashCode;
  }
}