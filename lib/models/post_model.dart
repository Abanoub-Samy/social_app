
class PostModel {
  String? name;
  String? uId;
  String? profileImage ;
  String? date ;
  String? text ;
  String? postImage ;

  PostModel({
    required this.name,
    required this.uId,
    required this.date,
    required this.profileImage,
    required this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    date = json['date'];
    profileImage = json['profileImage'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'date': date,
      'profileImage': profileImage,
      'text': text,
      'postImage': postImage,
    };
  }
}
