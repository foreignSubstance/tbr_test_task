class ImageModel {
  List imageLinks;

  ImageModel.fromJson(Map<String, dynamic> json)
      : imageLinks = json['links']['flickr_images'];
}
