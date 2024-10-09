class NotificationModel {
  String? storyId;
  String? name;
  String? phone;
  String? about;
  String? image;

  NotificationModel({
    this.storyId,
    this.name,
    this.phone,
    this.about,
    this.image,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    storyId = json['storyId'];
    name = json['name'];
    phone = json['phone'];
    about = json['about'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storyId'] = storyId;
    data['name'] = name;
    data['phone'] = phone;
    data['about'] = about;
    data['image'] = image;
    return data;
  }
}
