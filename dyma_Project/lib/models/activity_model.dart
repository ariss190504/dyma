enum ActivityStatus { ongoing, done }

class Activity {
  String? image;
  String? name;
  String? id;
  String? city;
  double price;
  ActivityStatus status;
  late LocationActivity location;
  Activity({
    required this.name,
    required this.image,
    this.id,
    required this.location,
    required this.city,
    required this.price,
    this.status = ActivityStatus.ongoing,
    
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        image = json['image'],
        name = json['name'],
        city = json['city'],
        price = json['price'].toDouble(),
        status =
            json['status'] == 0 ? ActivityStatus.ongoing : ActivityStatus.done;
  
  Map<String, dynamic> toJson(){
    Map<String, dynamic> value ={
      '_id': id,
      'name': name,
      'image' : image,
      'city' : city,
      'price' : price,
      'status' : price,
      'status' : status == ActivityStatus.ongoing ? 0 : 1,
    };
    if(id != null){
      value['_id'] = id;
    }
    return value;
  }
}

class LocationActivity{
  String? address;
  double? longitude;
  double? latiude;
  LocationActivity({required this.address,required this.latiude, required this.longitude});
}
