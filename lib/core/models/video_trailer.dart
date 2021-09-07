class VideoTrailer {
  final String site;
  final String key;

  VideoTrailer(this.site, this.key);

  VideoTrailer.fromJson(Map<String, dynamic> json)
      : site = json['site'],
        key = json['key'];
}
