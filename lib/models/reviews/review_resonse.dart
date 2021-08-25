class ReviewsModel {
  int status;
  String message;
  var avgRatings;
  List<Reviews> reviews;

  ReviewsModel({this.status, this.message, this.avgRatings, this.reviews});

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    avgRatings = json['avg_ratings'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['avg_ratings'] = this.avgRatings;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int id;
  int appointmentId;
  int docLabId;
  int userId;
  String review;
  String ratings;
  String createdAt;
  String updatedAt;

  Reviews(
      {this.id,
        this.appointmentId,
        this.docLabId,
        this.userId,
        this.review,
        this.ratings,
        this.createdAt,
        this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    docLabId = json['doc_lab_id'];
    userId = json['user_id'];
    review = json['review'];
    ratings = json['ratings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
    data['doc_lab_id'] = this.docLabId;
    data['user_id'] = this.userId;
    data['review'] = this.review;
    data['ratings'] = this.ratings;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
