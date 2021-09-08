class HomeScreen {
  List<Doctor> doctors;
  List<Symptom> symptoms;
  List<Category> categories;
  List<Clinic> clinics;
  List<Lab> labs;
  List<Banners> banners;

  HomeScreen(
      {this.doctors,
        this.symptoms,
        this.categories,
        this.clinics,
        this.labs,
        this.banners});

  HomeScreen.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = new List<Doctor>();
      json['doctors'].forEach((v) {
        doctors.add(new Doctor.fromJson(v));
      });
    }
    if (json['symptoms'] != null) {
      symptoms = new List<Symptom>();
      json['symptoms'].forEach((v) {
        symptoms.add(new Symptom.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<Category>();
      json['categories'].forEach((v) {
        categories.add(new Category.fromJson(v));
      });
    }
    if (json['clinics'] != null) {
      clinics = new List<Clinic>();
      json['clinics'].forEach((v) {
        clinics.add(new Clinic.fromJson(v));
      });
    }
    if (json['labs'] != null) {
      labs = new List<Lab>();
      json['labs'].forEach((v) {
        labs.add(new Lab.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = new List<Banners>();
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['doctors'] = this.doctors.map((v) => v.toJson()).toList();
    }
    if (this.symptoms != null) {
      data['symptoms'] = this.symptoms.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.clinics != null) {
      data['clinics'] = this.clinics.map((v) => v.toJson()).toList();
    }
    if (this.labs != null) {
      data['labs'] = this.labs.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  int id;
  String name;
  String email;
  String phone;
  var emailVerifiedAt;
  String avatar;
  int isAdmin;
  String userType;
  int isActive;
  String createdAt;
  String updatedAt;
  DoctorDetailsNew doctorDetailsNew;

  Doctor(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.avatar,
        this.isAdmin,
        this.userType,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.doctorDetailsNew});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    isAdmin = json['is_admin'];
    userType = json['user_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctorDetailsNew = json['doctor_details_new'] != null
        ? new DoctorDetailsNew.fromJson(json['doctor_details_new'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['is_admin'] = this.isAdmin;
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.doctorDetailsNew != null) {
      data['doctor_details_new'] = this.doctorDetailsNew.toJson();
    }
    return data;
  }
}

class DoctorDetailsNew {
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
  String speciality;
  String description;
  String lat;
  String lng;
  int isFeatured;
  String avgRatings;
  double distance;

  DoctorDetailsNew(
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
        this.appType,
        this.speciality,
        this.description,
        this.lat,
        this.lng,
        this.isFeatured,
        this.avgRatings,
        this.distance});

  DoctorDetailsNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clinicDetailsId = json['clinic_details_id'];
    firstName = json['first_name'];
    middleName = json['middle_name']??'';
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
    speciality = json['speciality'];
    description = json['description'];
    lat = json['lat'];
    lng = json['lng'];
    isFeatured = json['is_featured'];
    avgRatings = json['avg_ratings'];
    distance = json['distance'];
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
    data['speciality'] = this.speciality;
    data['description'] = this.description;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['is_featured'] = this.isFeatured;
    data['avg_ratings'] = this.avgRatings;
    data['distance'] = this.distance;
    return data;
  }
}

class Symptom {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String icon;

  Symptom({this.id, this.name, this.createdAt, this.updatedAt, this.icon});

  Symptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['icon'] = this.icon;
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

class Clinic {
  int id;
  String name;
  String email;
  String phone;
  var emailVerifiedAt;
  String avatar;
  int isAdmin;
  String userType;
  int isActive;
  String createdAt;
  String updatedAt;
  ClinicDetailsNew clinicDetailsNew;

  Clinic(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.avatar,
        this.isAdmin,
        this.userType,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.clinicDetailsNew});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    isAdmin = json['is_admin'];
    userType = json['user_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    clinicDetailsNew = json['clinic_details_new'] != null
        ? new ClinicDetailsNew.fromJson(json['clinic_details_new'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['is_admin'] = this.isAdmin;
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.clinicDetailsNew != null) {
      data['clinic_details_new'] = this.clinicDetailsNew.toJson();
    }
    return data;
  }
}

class ClinicDetailsNew {
  int id;
  int userId;
  String legalName;
  String firstName;
  String middleName;
  String lastName;
  String address;
  String state;
  String city;
  String pincode;
  String lng;
  String lat;
  String googleSearchName;
  String createdAt;
  String updatedAt;
  String speciality;
  String description;
  String avgRatings;
  var distance;

  ClinicDetailsNew(
      {this.id,
        this.userId,
        this.legalName,
        this.firstName,
        this.middleName,
        this.lastName,
        this.address,
        this.state,
        this.city,
        this.pincode,
        this.lng,
        this.lat,
        this.googleSearchName,
        this.createdAt,
        this.updatedAt,
        this.speciality,
        this.description,
        this.avgRatings,
        this.distance});

  ClinicDetailsNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    legalName = json['legal_name'];
    firstName = json['first_name'];
    middleName = json['middle_name']??'';
    lastName = json['last_name'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    lng = json['lng'];
    lat = json['lat'];
    googleSearchName = json['google_search_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    speciality = json['speciality'];
    description = json['description'];
    avgRatings = json['avg_ratings'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['legal_name'] = this.legalName;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName??'';
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['google_search_name'] = this.googleSearchName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['speciality'] = this.speciality;
    data['description'] = this.description;
    data['avg_ratings'] = this.avgRatings;
    data['distance'] = this.distance;
    return data;
  }
}

class Lab {
  int id;
  String name;
  String email;
  String phone;
  var emailVerifiedAt;
  String avatar;
  int isAdmin;
  String userType;
  int isActive;
  var createdAt;
  String updatedAt;
  LabDetailsNew labDetailsNew;

  Lab(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.avatar,
        this.isAdmin,
        this.userType,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.labDetailsNew});

  Lab.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    isAdmin = json['is_admin'];
    userType = json['user_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    labDetailsNew = json['lab_details_new'] != null
        ? new LabDetailsNew.fromJson(json['lab_details_new'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['is_admin'] = this.isAdmin;
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.labDetailsNew != null) {
      data['lab_details_new'] = this.labDetailsNew.toJson();
    }
    return data;
  }
}

class LabDetailsNew {
  int id;
  int userId;
  String legalName;
  String firstName;
  String middleName;
  String lastName;
  String labCerti;
  String permissionCerti;
  String pci;
  String cea;
  String startTime;
  String endTime;
  String address;
  String state;
  String city;
  String pincode;
  String lng;
  String lat;
  String googleSearchName;
  var createdAt;
  String updatedAt;
  String speciality;
  String description;
  String avgRatings;
  double distance;

  LabDetailsNew(
      {this.id,
        this.userId,
        this.legalName,
        this.firstName,
        this.middleName,
        this.lastName,
        this.labCerti,
        this.permissionCerti,
        this.pci,
        this.cea,
        this.startTime,
        this.endTime,
        this.address,
        this.state,
        this.city,
        this.pincode,
        this.lng,
        this.lat,
        this.googleSearchName,
        this.createdAt,
        this.updatedAt,
        this.speciality,
        this.description,
        this.avgRatings,
        this.distance});

  LabDetailsNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    legalName = json['legal_name'];
    firstName = json['first_name'];
    middleName = json['middle_name']??'';
    lastName = json['last_name'];
    labCerti = json['lab_certi'];
    permissionCerti = json['permission_certi'];
    pci = json['pci'];
    cea = json['cea'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    lng = json['lng'];
    lat = json['lat'];
    googleSearchName = json['google_search_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    speciality = json['speciality'];
    description = json['description'];
    avgRatings = json['avg_ratings'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['legal_name'] = this.legalName;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName??'';
    data['last_name'] = this.lastName;
    data['lab_certi'] = this.labCerti;
    data['permission_certi'] = this.permissionCerti;
    data['pci'] = this.pci;
    data['cea'] = this.cea;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['google_search_name'] = this.googleSearchName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['speciality'] = this.speciality;
    data['description'] = this.description;
    data['avg_ratings'] = this.avgRatings;
    data['distance'] = this.distance;
    return data;
  }
}

class Banners {
  int id;
  String bannerName;
  String bannerImage;
  String createdAt;
  String updatedAt;

  Banners(
      {this.id,
        this.bannerName,
        this.bannerImage,
        this.createdAt,
        this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerName = json['banner_name'];
    bannerImage = json['banner_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_name'] = this.bannerName;
    data['banner_image'] = this.bannerImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
