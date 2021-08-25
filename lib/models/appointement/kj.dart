class kj {
    String date_of_appointment;
    String doc_lab_id;
    String time_of_appointment;

    kj({this.date_of_appointment, this.doc_lab_id, this.time_of_appointment});

    factory kj.fromJson(Map<String, dynamic> json) {
        return kj(
            date_of_appointment: json['date_of_appointment'], 
            doc_lab_id: json['doc_lab_id'], 
            time_of_appointment: json['time_of_appointment'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['date_of_appointment'] = this.date_of_appointment;
        data['doc_lab_id'] = this.doc_lab_id;
        data['time_of_appointment'] = this.time_of_appointment;
        return data;
    }
}