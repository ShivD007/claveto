class StaticBanner {
  String message;
  String status;
  List<Products> data;

  StaticBanner(this.message, this.status, this.data);

  StaticBanner.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      data =  <Products>[];
      json["data"].forEach((v) {
        data.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> product = new Map<String, dynamic>();
    product['status'] = this.status;
    product['message'] = this.message;
    if (this.data != null) {
      product['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return product;
  }
}

class Products {
  int id;
  String image;
  String title;
  String description;
  String link;

  Products(this.id, this.title, this.image, this.description, this.link);

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    title = json["title"];
    description = json["description"];
    link = json["link"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["image"] = this.image;
    data["title"] = this.title;
    data["description"] = this.description;
    data["link"] = this.link;

    return data;
  }
}
