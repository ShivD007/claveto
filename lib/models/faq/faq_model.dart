class FAQResponseModel {
  int status;
  List<Faqs> faqs;

  FAQResponseModel({this.status, this.faqs});

  FAQResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['faqs'] != null) {
      faqs = new List<Faqs>();
      json['faqs'].forEach((v) {
        faqs.add(new Faqs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.faqs != null) {
      data['faqs'] = this.faqs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  int id;
  String que;
  String ans;
  String createdAt;
  String updatedAt;

  Faqs({this.id, this.que, this.ans, this.createdAt, this.updatedAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    que = json['que'];
    ans = json['ans'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['que'] = this.que;
    data['ans'] = this.ans;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
