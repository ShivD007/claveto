import 'doctor_appointement_detail.dart';

class LabBookAppointment {
  List<Appointments> appointments;
  LabDetails labDetails;
  List<LabPackages> labPackages;

  LabBookAppointment({this.appointments, this.labDetails, this.labPackages});

  LabBookAppointment.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      appointments = new List<Appointments>();
      json['appointments'].forEach((v) {
        appointments.add(new Appointments.fromJson(v));
      });
    }
    labDetails = json['lab_details'] != null
        ? new LabDetails.fromJson(json['lab_details'])
        : null;
    if (json['lab_packages'] != null) {
      labPackages = new List<LabPackages>();
      json['lab_packages'].forEach((v) {
        labPackages.add(new LabPackages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointments != null) {
      data['appointments'] = this.appointments.map((v) => v.toJson()).toList();
    }
    if (this.labDetails != null) {
      data['lab_details'] = this.labDetails.toJson();
    }
    if (this.labPackages != null) {
      data['lab_packages'] = this.labPackages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Appointments {
//   int id;
//   int userId;
//   String appointmentType;
//   String docLabId;
//   Null familyMemberId;
//   String dateOfAppointment;
//   String timeOfAppointment;
//   String patientName;
//   String paymentStatus;
//   String status;
//   String createdAt;
//   String updatedAt;
//
//   Appointments(
//       {this.id,
//         this.userId,
//         this.appointmentType,
//         this.docLabId,
//         this.familyMemberId,
//         this.dateOfAppointment,
//         this.timeOfAppointment,
//         this.patientName,
//         this.paymentStatus,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Appointments.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     appointmentType = json['appointment_type'];
//     docLabId = json['doc_lab_id'];
//     familyMemberId = json['family_member_id'];
//     dateOfAppointment = json['date_of_appointment'];
//     timeOfAppointment = json['time_of_appointment'];
//     patientName = json['patient_name'];
//     paymentStatus = json['payment_status'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['appointment_type'] = this.appointmentType;
//     data['doc_lab_id'] = this.docLabId;
//     data['family_member_id'] = this.familyMemberId;
//     data['date_of_appointment'] = this.dateOfAppointment;
//     data['time_of_appointment'] = this.timeOfAppointment;
//     data['patient_name'] = this.patientName;
//     data['payment_status'] = this.paymentStatus;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

class LabDetails {
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
  String long;
  String lat;
  String googleSearchName;
  String createdAt;
  String updatedAt;

  LabDetails(
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
        this.long,
        this.lat,
        this.googleSearchName,
        this.createdAt,
        this.updatedAt});

  LabDetails.fromJson(Map<String, dynamic> json) {
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
    long = json['long'];
    lat = json['lat'];
    googleSearchName = json['google_search_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['google_search_name'] = this.googleSearchName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LabPackages {
  int id;
  String name;
  String description;
  String packagePrice;
  String createdAt;
  String updatedAt;

  LabPackages(
      {this.id,
        this.name,
        this.description,
        this.packagePrice,
        this.createdAt,
        this.updatedAt});

  LabPackages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    packagePrice = json['package_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['package_price'] = this.packagePrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
