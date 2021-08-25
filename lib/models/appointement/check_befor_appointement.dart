// {
// "time_of_appointment": "04:00:00",
// "date_of_appointment": "2020-11-07",
// "doc_lab_id": "3"
// }

class CheckBeforeRequestModel {
  String timeOfAppointment;
  String dateOfAppointment;
  String docLabId;

  CheckBeforeRequestModel(
      {this.timeOfAppointment, this.dateOfAppointment, this.docLabId});

  CheckBeforeRequestModel.fromJson(Map<String, dynamic> json) {
    timeOfAppointment = json['time_of_appointment'];
    dateOfAppointment = json['date_of_appointment'];
    docLabId = json['doc_lab_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_of_appointment'] = this.timeOfAppointment;
    data['date_of_appointment'] = this.dateOfAppointment;
    data['doc_lab_id'] = this.docLabId;
    return data;
  }
}
