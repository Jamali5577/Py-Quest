class CurrentUserData {
  final String? UserId;
  final String? Password;
  final String? UserName;
  final String? Email;

  CurrentUserData(
      {required this.UserId,
      this.Password,
      required this.UserName,
      required this.Email});

  Map<String, dynamic> toJson() => {
        'userid': UserId,
        'username': UserName,
        'pass': Password,
        'email': Email
      };

  // static CurrentUserData fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return CurrentUserData(
  //     Email: snapshot['email'],
  //     UserId: snapshot['userid'],
  //     UserName: snapshot['username'],
  //   );
  // }
}
