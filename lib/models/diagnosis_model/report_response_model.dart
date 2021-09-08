class ReportResponseModel {
  int status;
  String message;
  List<Reports> reports;

  ReportResponseModel({this.status, this.message, this.reports});

  ReportResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports.add(new Reports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reports != null) {
      data['reports'] = this.reports.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reports {
  int id;
  int userId;
  String legalName;
  String firstName;
  String middleName;
  String lastName;
  String labCerti;
  String permissionCerti;
  String pci;
  String cea;
  String startTime;
  String endTime;
  String address;
  String state;
  String city;
  String pincode;
  String lng;
  String lat;
  String googleSearchName;
  String createdAt;
  String updatedAt;
  String speciality;
  String description;
  String avgRatings;
  int orderId;
  int labId;
  String report;
  int orderDetailId;
  String name;
  String packagePrice;

  Reports(
      {this.id,
        this.userId,
        this.legalName,
        this.firstName,
        this.middleName,
        this.lastName,
        this.labCerti,
        this.permissionCerti,
        this.pci,
        this.cea,
        this.startTime,
        this.endTime,
        this.address,
        this.state,
        this.city,
        this.pincode,
        this.lng,
        this.lat,
        this.googleSearchName,
        this.createdAt,
        this.updatedAt,
        this.speciality,
        this.description,
        this.avgRatings,
        this.orderId,
        this.labId,
        this.report,
        this.orderDetailId,
        this.name,
        this.packagePrice});

  Reports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    legalName = json['legal_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    labCerti = json['lab_certi'];
    permissionCerti = json['permission_certi'];
    pci = json['pci'];
    cea = json['cea'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    lng = json['lng'];
    lat = json['lat'];
    googleSearchName = json['google_search_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    speciality = json['speciality'];
    description = json['description'];
    avgRatings = json['avg_ratings'];
    orderId = json['order_id'];
    labId = json['lab_id'];
    report = json['report'];
    orderDetailId = json['order_detail_id'];
    name = json['name'];
    packagePrice = json['package_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['legal_name'] = this.legalName;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['lab_certi'] = this.labCerti;
    data['permission_certi'] = this.permissionCerti;
    data['pci'] = this.pci;
    data['cea'] = this.cea;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['google_search_name'] = this.googleSearchName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['speciality'] = this.speciality;
    data['description'] = this.description;
    data['avg_ratings'] = this.avgRatings;
    data['order_id'] = this.orderId;
    data['lab_id'] = this.labId;
    data['report'] = this.report;
    data['order_detail_id'] = this.orderDetailId;
    data['name'] = this.name;
    data['package_price'] = this.packagePrice;
    return data;
  }
}

