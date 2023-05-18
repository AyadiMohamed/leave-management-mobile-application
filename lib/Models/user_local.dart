class User {

  String? userId;
  String? firstname;
  String? lastname;
  String? email;
  String? birthday;
  String? phoneNumber;
  List<String>? roles;
  double? earnedBalance;
  //int? sickBalance;
  String? token;

  

  User({this.userId, this.firstname, this.lastname, this.email, this.birthday, this.phoneNumber, this.roles, this.earnedBalance,  this.token
      }); // now create converter

 factory User.fromJson(Map<String,dynamic> responseData){
   return User(
     userId: responseData['id'],
     firstname: responseData['firstName'],
     lastname: responseData['lastName'],
     email : responseData['email'],
     phoneNumber: responseData['phoneNumber'],
     roles : responseData['roles'],
     earnedBalance : responseData['earnedBalance'],
     //sickBalance : responseData['sickBalance'],
     token: responseData['access_token']
     
   );
 }
}