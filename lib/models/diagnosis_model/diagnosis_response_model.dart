class DiagnosisResponseModel {
  int status;
  String message;
  List<Diagnoses> diagnoses;

  DiagnosisResponseModel({this.status, this.message, this.diagnoses});

  DiagnosisResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['diagnoses'] != null) {
      diagnoses = <Diagnoses>[];
      json['diagnoses'].forEach((v) {
        diagnoses.add(new Diagnoses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.diagnoses != null) {
      data['diagnoses'] = this.diagnoses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Diagnoses {
  int id;
  int appointmentId;
  int userId;
  String prescription;
  String remarks;
  String createdAt;
  String updatedAt;
  String docID;

  Diagnoses(
      {this.id,
        this.appointmentId,
        this.userId,
        this.prescription,
        this.remarks,
        this.docID,
        this.createdAt,
        this.updatedAt});

  Diagnoses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    userId = json['user_id'];
    prescription = json['prescription'];
    docID = json['doc_lab_id'];
    remarks = json['remarks'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
    data['user_id'] = this.userId;
    data['prescription'] = this.prescription;
    data['remarks'] = this.remarks;
    data['doc_lab_id'] = this.docID;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
