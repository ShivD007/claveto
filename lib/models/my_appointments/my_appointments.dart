class MyAppointmentsModel {
  int status;
  String message;
  List<Appointments> appointments;

  MyAppointmentsModel({this.status, this.message, this.appointments});

  MyAppointmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments.add(new Appointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.appointments != null) {
      data['appointments'] = this.appointments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointments {
  int id;
  int userId;
  String appointmentType;
  String phoneNumber;
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
        this.phoneNumber,
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
    phoneNumber = json['phone'];
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
    data['phone'] = this.phoneNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
