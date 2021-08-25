class AllBlogsResponse {
  int status;
  String message;
  List<Blogs> blogs;

  AllBlogsResponse({this.status, this.message, this.blogs});

  AllBlogsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['blogs'] != null) {
      blogs = new List<Blogs>();
      json['blogs'].forEach((v) {
        blogs.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.blogs != null) {
      data['blogs'] = this.blogs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  int id;
  String title;
  String sortDescription;
  String description;
  String featuredImage;
  int userId;
  String createdAt;
  String updatedAt;

  Blogs(
      {this.id,
      this.title,
      this.sortDescription,
      this.description,
      this.featuredImage,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sortDescription = json['sort_description'];
    description = json['description'];
    featuredImage = json['featured_image'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sort_description'] = this.sortDescription;
    data['description'] = this.description;
    data['featured_image'] = this.featuredImage;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
