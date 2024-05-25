import 'package:share_plus/share_plus.dart';

class ShareService {
  static share(String text, {String? title, String? subject}) {
    Share.share(text, subject: subject);
  }
}
