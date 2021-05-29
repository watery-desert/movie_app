class BackgroundImage {
  final String location;
  final int index;
  final double imageOffset;
  BackgroundImage({
    required this.index,
    required this.location,
    required this.imageOffset,
  });

  factory BackgroundImage.fromMap(Map<String, dynamic> data, deviceWidth) {
    return BackgroundImage(
      location: data['image'],
      index: data['index'],
      imageOffset: data['index'] * deviceWidth,
    );
  }
}
