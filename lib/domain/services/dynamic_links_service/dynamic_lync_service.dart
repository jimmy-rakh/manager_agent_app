import 'package:bingo/app/locator.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:stacked/stacked.dart';

class DynamicLinkService with ListenableServiceMixin {
  static final AuthService _authService = getIt();

  DynamicLinkService() {
    listenToReactiveValues([_initialLink, _listeningLink, _generatedLink]);
  }

  static final ReactiveValue<Uri?> _initialLink = ReactiveValue(null);
  static final ReactiveValue<Uri?> _listeningLink = ReactiveValue(null);
  final ReactiveValue<Uri?> _generatedLink = ReactiveValue(null);

  static Uri? get initialLink => _initialLink.value;
  static Uri? get listeningLink => _listeningLink.value;
  Uri? get generatedLink => _generatedLink.value;
  static UserStatus get userStatus => _authService.getUserStatus();

  static Future<void> initialDynamicLink() async {
    // final PendingDynamicLinkData? initialDynamicLinkData =
    //     await FirebaseDynamicLinks.instance.getInitialLink();
    // if (initialDynamicLinkData != null) {
    //   _initialLink.value = initialDynamicLinkData.link;
    //   print(initialLink);
    // }

    listenLink();
  }

  static listenLink() {
    // FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    //   _listeningLink.value = dynamicLinkData.link;
    //   print(listeningLink);
    // }).onError((error) {
    //   debugPrint(error);
    // });
  }

  // Future<void> generateReferalLink(int referalId) async {
  //   final dynamicLinkParams = DynamicLinkParameters(
  //     link: Uri.parse("https://okans.uz"),
  //     uriPrefix: "https://share.okans.uz",
  //     androidParameters: const AndroidParameters(
  //       packageName: "com.click.clickstart",
  //       minimumVersion: 133,
  //     ),
  //     iosParameters: const IOSParameters(
  //       bundleId: "com.click.clickstart",
  //       appStoreId: "1590997023",
  //       minimumVersion: "2.0.2",
  //     ),
  //     socialMetaTagParameters: SocialMetaTagParameters(
  //       title: "Приглашаю тебя на увлекательное путешествие в CLICK Start!",
  //       imageUrl: Uri.parse(
  //           "https://cdn.click.uz/app/start/referral/background.jpeg"),
  //     ),
  //   );
  //   final generatedDynamicLink =
  //       await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  //   _generatedLink.value = generatedDynamicLink.shortUrl;
  // }
}
