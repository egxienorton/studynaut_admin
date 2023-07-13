class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class SuperUser {
  SuperUser(
      {required this.id,
      required this.firstName,
      required this.middleName, // specify if any
      required this.lastName,
      required this.avatarUrl,
      required this.image,
      required this.about,
      required this.nickname,
      required this.createdAt,
      required this.isOnline,
      required this.lastActive,
      required this.email,
      required this.pushToken,
      required this.dateOfBirth,
      required this.level,
      required this.department,
      required this.faculty,
      required this.matriculationNumber,
      required this.institution,
      required this.phoneNumber});

  late String id;
  late String avatarUrl;

  //NEW
  late String image;
  late String about;
  late String nickname;
  late String createdAt;
  late bool isOnline;

  late String lastActive;
  late String email;
  late String pushToken;

  //MORE FIELDS

  late String dateOfBirth;
  late String level;
  late String department;
  late String faculty;
  late String matriculationNumber;
  late String institution;
  late String phoneNumber;
  late String firstName;
  late String lastName;
  late String middleName;

  //! Dependent Fields

  //? need for institutional mail?

  late String registrationNumber;
  late String studentID; //? Need for this?
  late String desiredInstitution;

  //? Promotional fields

  late String stars;
  late String rank; //TODO -- should override userLevel in OAUTH

  // do we need this copywith method?
  SuperUser copyWith({
    required String id,
    // required String firstName,
    // required String avatarUrl,
    required DateTime lastMessageTime,
  }) =>
      SuperUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        avatarUrl: avatarUrl,
        about: about,
        image: image,
        createdAt: createdAt,
        isOnline: isOnline,
        lastActive: lastActive,
        email: email,
        pushToken: pushToken, nickname: nickname,

        //* NEW
        dateOfBirth: dateOfBirth,
        level: level,
        department: department,
        faculty: faculty,
        matriculationNumber: matriculationNumber,
        institution: institution,
        phoneNumber: phoneNumber,
      );

  // NEW
  SuperUser.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] ?? '';
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    nickname = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    isOnline = json['isOnline'] ?? false;
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  //TODO: should All fields be encapsulated in one JSON shot ??
  //* NEW

  //! Generic
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = nickname;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }

  Map<String, dynamic> toPrimeJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = nickname;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }

  Map<String, dynamic> toEruditeJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = nickname;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }

  Map<String, dynamic> toNoobieJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = nickname;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }

  //? Add more abstractive methods for searching like the UserGen
}
