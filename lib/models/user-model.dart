class UserModel {
  String? name;

  String? email;

  String? phone;

  String? uId;
  String? bio;
  bool? isEmailVerified;
  String? profileImage ;
  String? profileCover ;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
    required this.profileImage,
    required this.profileCover,
    required this.bio
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    profileImage = json['profileImage'];
    profileCover = json['profileCover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'profileImage': profileImage,
      'profileCover': profileCover,
      'bio': bio,
    };
  }
}
