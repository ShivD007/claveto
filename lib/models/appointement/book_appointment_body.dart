class BookAppointmentRequestModel {
  String appointmentType;
  String docLabId;
  String dateOfAppointment;
  String timeOfAppointment;
  String razorpayId;
  String totalAmount;
  String calculatedDiscountAmount;
  String amountToBePaid;
  String newClave;
  String familyMemberId;
  List packages;

  bool isLab;
  BookAppointmentRequestModel(
      {this.appointmentType,
        this.docLabId,
        this.packages,
        this.isLab=false,
        this.dateOfAppointment,
        this.timeOfAppointment,
        this.razorpayId,
        this.totalAmount,
        this.calculatedDiscountAmount,
        this.amountToBePaid,
        this.familyMemberId,
        this.newClave});

  BookAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    appointmentType = json['appointment_type'];
    docLabId = json['doc_lab_id'];
    dateOfAppointment = json['date_of_appointment'];
    timeOfAppointment = json['time_of_appointment'];
    razorpayId = json['razorpay_id'];
    packages = json['packages'];
    totalAmount = json['total_amount'];
    calculatedDiscountAmount = json['calculated_discount_amount'];
    amountToBePaid = json['amount_to_be_paid'];
    newClave = json['newclave'];
    amountToBePaid = json['family_member_id'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    print('In json model printing family id ${this.familyMemberId}');
    String id = this.familyMemberId;
    data['appointment_type'] = this.appointmentType;
    data['doc_lab_id'] = this.docLabId;

    if(id!=(-10).toString()){
      print('True1');
      data['family_member_id'] = this.familyMemberId;
    }
    else{
      print('Family member id is null');
    }

    if(this.isLab){
      print('True1');
      data['packages'] = this.packages;
    }
    else{
      print('No packages because it is not lab appointment');
    }

    data['date_of_appointment'] = this.dateOfAppointment;
    data['time_of_appointment'] = this.timeOfAppointment;
    data['razorpay_id'] = this.razorpayId;
    data['total_amount'] = this.totalAmount;
    data['calculated_discount_amount'] = this.calculatedDiscountAmount;
    data['amount_to_be_paid'] = this.amountToBePaid;
    data['newclave'] = this.newClave;
    return data;
  }
}


// {
// "appointment_type": "required",
// "doc_lab_id": "required",
// "date_of_appointment": "required",
// "time_of_appointment": "required",
// "razorpay_id": "required",
// "total_amount": "required",
// "calculated_discount_amount": "required",
// "amount_to_be_paid": "required",
// "new_clave": 0
// }