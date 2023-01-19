class itemContact {
  final String itemName;
  final String itemPhone;
  final String itemPhone2;
  final String itemEmail;

  itemContact({required this.itemName, required this.itemPhone, required this.itemPhone2, required this.itemEmail});

  Map<String, dynamic> toJson(){
    return{
      'name' : itemName,
      'phone' : itemPhone,
      'phone2' : itemPhone2,
      'email' : itemEmail
    };
  }

  factory itemContact.fromJson(Map<String, dynamic> json){
    return itemContact(itemName: json["name"], itemPhone: json["phone"], itemPhone2: json["phone2"], itemEmail: json['email']);
  }

}