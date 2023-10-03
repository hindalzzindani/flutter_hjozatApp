class StandDroppingBoardModel {
  String? id;
  String? tripId;
  String? standId;
  String? time;
  String? name;
  String? pickdropstand;
  String? type;
  String? dropStand;
  String? detail;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  StandDroppingBoardModel(
      {this.id,
        this.tripId,
        this.standId,
        this.time,
        this.name,
        this.pickdropstand,
        this.type,
        this.dropStand,
        this.detail,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  StandDroppingBoardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripId = json['trip_id'];
    standId = json['stand_id'];
    time = json['time'];
    name = json['name'];
    pickdropstand = json['pickdropstand'];
    type = json['type'];
    dropStand = json['dropStand'];
    detail = json['detail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trip_id'] = this.tripId;
    data['stand_id'] = this.standId;
    data['time'] = this.time;
    data['name'] = this.name;
    data['pickdropstand'] = this.pickdropstand;
    data['type'] = this.type;
    data['dropStand'] = this.dropStand;
    data['detail'] = this.detail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
