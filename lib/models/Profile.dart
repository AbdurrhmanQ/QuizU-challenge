class Profile {
  String name, mobile;

  Profile(this.name, this.mobile);

  Profile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mobile = json['mobile'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobile': mobile,
      };
}
