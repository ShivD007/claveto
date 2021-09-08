import 'dart:io';

class AdmodService {
  String getAdMobId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3566164120621929~2786435851";
    }
    return null;
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3566164120621929/9707067426";
    }
    return null;
  }
}
