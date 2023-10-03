class BookingHistoryModel {
  String? id;
  String? bookingId;
  String? regno;
  String? tripId;
  String? subtripId;
  String? id_number;
  String? first_name;
  String? name;
  String? last_name;
  String? pickLocationId;
  String? picklocation;
  String? dropLocationId;
  String? drop_stand_id;
  String? droplocation;
  String? pickStandId;
  String? dropStandId;
  String? dropStand;
  String? price;
  String? discount;
  String? companyName;

  String? totaltax;
  String? paidamount;
  String? offerer;
  String? adult;
  String? chield;
  String? special;
  // String? seatnumber;
  String? totalseat;
  String? journeydata;
  String? paymentStatus;
  String? vehicleId;
  String? paymentDetail;
  String? startime;
  String? endtime;
  String? refund;
  String? cancelStatus;
  int? reviewStatus;

  BookingHistoryModel(
      {this.id,
        this.bookingId,
        this.regno,
        this.tripId,
        this.subtripId,
        this.id_number,
        this.name,
        this.first_name,
        this.last_name,
        this.pickLocationId,
        this.picklocation,
        this.dropLocationId,
        this.drop_stand_id,
        this.droplocation,
        this.pickStandId,
        this.dropStandId,
        this.price,
        this.discount,
        this.companyName,
        this.totaltax,
        this.paidamount,
        this.offerer,
        this.adult,
        this.chield,
        this.special,
        // this.seatnumber,
        this.totalseat,
        this.journeydata,
        this.paymentStatus,
        this.vehicleId,
        this.paymentDetail,
        this.startime,
        this.endtime,
        this.refund,
        this.cancelStatus,
        this.reviewStatus});

  BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    regno = json['regno'];
    tripId = json['trip_id'];
    subtripId = json['subtrip_id'];
    name = json['name'];
    last_name = json['last_name'];
    first_name = json['first_name'];
    id_number = json['id_number'];
    pickLocationId = json['pick_location_id'];
    picklocation = json['picklocation'];
    droplocation = json['drop_location_id'];
    droplocation = json['droplocation'];
    pickStandId = json['pick_stand_id'];
    dropStandId = json['drop_stand_id'];
    price = json['price'];
    discount = json['discount'];
    companyName = json['companyName'];
    totaltax = json['totaltax'];
    paidamount = json['paidamount'];
    offerer = json['offerer'];
    adult = json['adult'];
    chield = json['chield'];
    special = json['special'];
    // seatnumber = json['seatnumber'];
    totalseat = json['totalseat'];
    journeydata = json['journeydata'];
    paymentStatus = json['payment_status'];
    vehicleId = json['vehicle_id'];
    paymentDetail = json['payment_detail'];
    startime = json['startime'];
    endtime = json['endtime'];
    refund = json['refund'];
    cancelStatus = json['cancel_status'];
    reviewStatus = json['review_status'];
  }

  get fleetName => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['regno'] = this.regno;
    data['trip_id'] = this.tripId;
    data['subtrip_id'] = this.subtripId;
    data['first_name'] = this.first_name;
    data['name'] = this.name;
    data['last_name'] = this.last_name;
    data['id_number'] = this.id_number;
    data['pick_location_id'] = this.pickLocationId;
    data['picklocation'] = this.picklocation;
    data['drop_location_id'] = this.dropLocationId;
    data['drop_stand_id'] = this.drop_stand_id;
    data['droplocation'] = this.droplocation;
    data['pick_stand_id'] = this.pickStandId;
    data['drop_stand_id'] = this.dropStandId;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['companyName'] = this.companyName;
    data['totaltax'] = this.totaltax;
    data['paidamount'] = this.paidamount;
    data['offerer'] = this.offerer;
    data['adult'] = this.adult;
    data['chield'] = this.chield;
    data['special'] = this.special;
    // data['seatnumber'] = this.seatnumber;
    data['totalseat'] = this.totalseat;
    data['journeydata'] = this.journeydata;
    data['payment_status'] = this.paymentStatus;
    data['vehicle_id'] = this.vehicleId;
    data['payment_detail'] = this.paymentDetail;
    data['startime'] = this.startime;
    data['endtime'] = this.endtime;
    data['refund'] = this.refund;
    data['cancel_status'] = this.cancelStatus;
    data['review_status'] = this.reviewStatus;
    return data;
  }
}
