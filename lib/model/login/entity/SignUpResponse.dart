import 'dart:convert';

class SignUpResponse {
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
  final String userId;
  final String type;
  final String status;
  final int createTime;
  final int updateTime;
  SignUpResponse({
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
    this.userId = '',
    this.type = '',
    this.status = '',
    this.createTime = 0,
    this.updateTime = 0,
  });

  SignUpResponse copyWith({
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
    String? userId,
    String? type,
    String? status,
    int? createTime,
    int? updateTime,
  }) {
    return SignUpResponse(
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
      userId: userId ?? this.userId,
      type: type ?? this.type,
      status: status ?? this.status,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
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
      'userId': userId,
      'type': type,
      'status': status,
      'createTime': createTime,
      'updateTime': updateTime,
    };
  }

  factory SignUpResponse.fromMap(Map<String, dynamic> map) {
    return SignUpResponse(
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
      userId: map['userId'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
      createTime: map['createTime'].toInt() as int,
      updateTime: map['updateTime'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpResponse.fromJson(String source) => SignUpResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpResponse(email: $email, authId: $authId, authProvider: $authProvider, name: $name, nickname: $nickname, gender: $gender, birthday: $birthday, phoneNumber: $phoneNumber, profileImage: $profileImage, countryCode: $countryCode, languageCode: $languageCode, userId: $userId, type: $type, status: $status, createTime: $createTime, updateTime: $updateTime)';
  }

  @override
  bool operator ==(covariant SignUpResponse other) {
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
      other.languageCode == languageCode &&
      other.userId == userId &&
      other.type == type &&
      other.status == status &&
      other.createTime == createTime &&
      other.updateTime == updateTime;
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
      languageCode.hashCode ^
      userId.hashCode ^
      type.hashCode ^
      status.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode;
  }
}