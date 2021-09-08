class DoctorBookAppointmentResponse {
  List<Appointments> appointments;
  DoctorDetails doctorDetails;
  Category category;

  DoctorBookAppointmentResponse(
      {this.appointments, this.doctorDetails, this.category});

  DoctorBookAppointmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      appointments = new List<Appointments>();
      json['appointments'].forEach((v) {
        appointments.add(new Appointments.fromJson(v));
      });
    }
    doctorDetails = json['doctor_details'] != null
        ? new DoctorDetails.fromJson(json['doctor_details'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointments != null) {
      data['appointments'] = this.appointments.map((v) => v.toJson()).toList();
    }
    if (this.doctorDetails != null) {
      data['doctor_details'] = this.doctorDetails.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Appointments {
  int id;
  int userId;
  String appointmentType;
  String docLabId;
  String familyMemberId;
  String dateOfAppointment;
  String timeOfAppointment;
  String patientName;
  String paymentStatus;
  String status;
  String createdAt;
  String updatedAt;

  Appointments(
      {this.id,
        this.userId,
        this.appointmentType,
        this.docLabId,
        this.familyMemberId,
        this.dateOfAppointment,
        this.timeOfAppointment,
        this.patientName,
        this.paymentStatus,
        this.status,
        this.createdAt,
        this.updatedAt});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    appointmentType = json['appointment_type'];
    docLabId = json['doc_lab_id'];
    familyMemberId = json['family_member_id'];
    dateOfAppointment = json['date_of_appointment'];
    timeOfAppointment = json['time_of_appointment'];
    patientName = json['patient_name'];
    paymentStatus = json['payment_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['appointment_type'] = this.appointmentType;
    data['doc_lab_id'] = this.docLabId;
    data['family_member_id'] = this.familyMemberId;
    data['date_of_appointment'] = this.dateOfAppointment;
    data['time_of_appointment'] = this.timeOfAppointment;
    data['patient_name'] = this.patientName;
    data['payment_status'] = this.paymentStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DoctorDetails {
  int id;
  int userId;
  int clinicDetailsId;
  String firstName;
  String middleName;
  String lastName;
  String dob;
  String gender;
  String expCerti;
  String degreeCerti;
  String grNo;
  int catagoryId;
  String startTime;
  String endTime;
  String adharNo;
  String address;
  String state;
  String city;
  String pincode;
  String createdAt;
  String updatedAt;
  String appType;

  DoctorDetails(
      {this.id,
        this.userId,
        this.clinicDetailsId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dob,
        this.gender,
        this.expCerti,
        this.degreeCerti,
        this.grNo,
        this.catagoryId,
        this.startTime,
        this.endTime,
        this.adharNo,
        this.address,
        this.state,
        this.city,
        this.pincode,
        this.createdAt,
        this.updatedAt,
        this.appType});

  DoctorDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clinicDetailsId = json['clinic_details_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    gender = json['gender'];
    expCerti = json['exp_certi'];
    degreeCerti = json['degree_certi'];
    grNo = json['gr_no'];
    catagoryId = json['catagory_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    adharNo = json['adhar_no'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appType = json['app_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['clinic_details_id'] = this.clinicDetailsId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['exp_certi'] = this.expCerti;
    data['degree_certi'] = this.degreeCerti;
    data['gr_no'] = this.grNo;
    data['catagory_id'] = this.catagoryId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['adhar_no'] = this.adharNo;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['app_type'] = this.appType;
    return data;
  }
}

class Category {
  int id;
  String name;
  String fees;
  String createdAt;
  String updatedAt;
  String icon;

  Category(
      {this.id,
        this.name,
        this.fees,
        this.createdAt,
        this.updatedAt,
        this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fees = json['fees'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fees'] = this.fees;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['icon'] = this.icon;
    return data;
  }
}
