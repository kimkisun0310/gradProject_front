class Member{
  String? memberName;
  String memberEmail;
  String memberPassword;

  Member(this.memberName, this.memberEmail, this.memberPassword);
  Member.login(this.memberEmail, this.memberPassword);

  Map<String, dynamic>toJson()=>{
    'name' : memberName,
    'email' : memberEmail,
    'password' : memberPassword
  };

  Map<String, dynamic>toLogIn()=>{
    'email' : memberEmail,
    'password' : memberPassword
  };
}