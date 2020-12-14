class Constants {
  static String baseUrl = 'https://api.viiddo.net/';

  static String rsaPrivateKey =
      'MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBAK1CyOWE7APssHq0571f9ogrd13PrDIxps+AP2nFpdoBgIUmrRfh3YcIl3OC3IZu1Qe2dzkF6IaU17U2DA9BO+WyhbGfSIoun/stxhdRRh9y1F0KxcE7DmZygLpEU11p5WUWR2G1BVsKqoZ3+8jxJicZvPlbWAgabrfVO9cES05LAgMBAAECgYEAgq26hJJqyNL+kK5dk1ILycyu7UyzXfBhFmRub8KpQvKbEtKG/1pWEYEDahYraiGx/206IwI3zTn6MC0hj2fuWiF9/CGWTnL2C/9YM/JbiU31OUxxxTXIotmMugMIBdO7IwkzKR4shzMBZf1JK2szcAZJBkJGsiC97MX0VthcfOECQQD1vdUDzuHVQoUKr7yvRSfLVbqWWksRu/wqOsX8lcm8gvfOo9aoINULSExdr/gslzE1RY1tVXc/VQ1u2vtRGpGTAkEAtH5fg9X3+bdKyqjKN7DsAQmc4kL+jHBwoX/+KcDy+7e4weeVcWYjKca3Rs8m/zY6Eh6WfqU008Q2xfT8KJejaQJBAPTmz8Bw0C25kl85DmDaGbOR51bp+4BcCQ2I70EvghJFr3MXYtjBh7AryDdiJIFD2D2P6Ec68pGCUNXWlLmaMdMCQQCjX9QjKDU6Up+fSyMnP7yPv9zCrTNteYVpmco8jwshr43L7kxGBdaERPu2W2GIFtR/fDJq1i04Fd4iVvs73u4pAkEArN7HtFWtrvpNuMU4ZQSXMeurHLER2SyUYn1WSH50noH4tzLm3RzuzKPfArF6xOihnJr3J/3HYRmzXR7tIQnQDg==';
  static String rsaPublicKey =
      'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCjTc20H6i7UnNkLDk90FD8LbedYJE0Lt/bGFQ4rSk+EowBEM1guynv5Gju7OFCQfv3bz3zqZ55/03Ge+DNRAf7zzOWnj3GvEC7A4xeXh7Efs+KUjJHjEKPYATSmd+fAHLjbuONf2dtpoEyvt6D5AkI+q2Xfo1O2oiV5WVPmuAQpwIDAQAB';
  static String netWorkTicket = '054b0d16dc6146eb9b03743a19807253';

  static String cognitoPoolId =
      'us-east-2:c7128890-214d-48f4-807c-3275e8501928';
  static String cognitoRegion = 'us-east-2';
  static String bucket = 'imgbaby';

  // Paramenters
  static const String TOKEN = 'token';
  static const String OBJECT_ID = 'objectId';
  static const String FACEBOOK_LOGIN = 'isFacebookLogin';
  static const String EMAIL = 'email';
  static const String IS_VERI_CAL = 'isVerical';
  static const String SHOW_WELCOME = 'isShowWelcome';

  static const String USERNAME = 'nikName';
  static const String AVATAR = 'avatar';
  static const String BIRTHDAY = 'birthday';
  static const String LOCATION = 'area';
  static const String GENDER = 'gender';
  static const String IS_REFRESH = 'isRefresh';

  static const String BABY_ID = 'babyId';
  static const String BABY_ICON = 'babyIcon';
  static const String IS_CREATOR = 'isCreator';
  static const String IS_BIRTH = 'isBirth';

  static const String welcomeURL = 'https://www.viiddo.com/welcome';
  static const String termsURL = 'https://www.viiddo.com/terms';
  static const String privacyURL = 'https://www.viiddo.com/privacy';
}

enum Gender { M, F }

enum MessageStatus { NORMAL, INVITE, GUIDE }
const List<String> routeNames = <String>[
  'viiddo://picswiper',
  'viiddo://mainpage',
  // 'viiddo//customimage',
  // 'viiddo//image',
  // 'viiddo//imageeditor',
  // 'viiddo//loadingprogress',
  // 'viiddo//mainpage',
  // 'viiddo//paintimage',
  // 'viiddo//photoview',
  // 'viiddo//picswiper',
  // 'viiddo//zoomimage'
];
class Routes {
  const Routes._();

  /// "show how to build loading more WaterfallFlow with ExtendedImage."
  ///
  /// [name] : viiddo//WaterfallFlowDemo
  ///
  /// [routeName] : WaterfallFlow
  ///
  /// [description] : "show how to build loading more WaterfallFlow with ExtendedImage."
  static const String fluttercandiesWaterfallFlowDemo =
      'viiddo://WaterfallFlowDemo';

  /// "show image with loading,failed,animation state"
  ///
  /// [name] : viiddo//customimage
  ///
  /// [routeName] : custom image load state
  ///
  /// [description] : "show image with loading,failed,animation state"
  static const String fluttercandiesCustomimage =
      'viiddo://customimage';

  /// "cache image,save to photo Library,image border,shape,borderRadius"
  ///
  /// [name] : viiddo//image
  ///
  /// [routeName] : image
  ///
  /// [description] : "cache image,save to photo Library,image border,shape,borderRadius"
  static const String fluttercandiesImage = 'viiddo://image';

  /// "crop,rotate and flip with image editor"
  ///
  /// [name] : viiddo//imageeditor
  ///
  /// [routeName] : image editor
  ///
  /// [description] : "crop,rotate and flip with image editor"
  static const String fluttercandiesImageeditor =
      'viiddo://imageeditor';

  /// "show how to make loading progress for network image"
  ///
  /// [name] : viiddo//loadingprogress
  ///
  /// [routeName] : loading progress
  ///
  /// [description] : "show how to make loading progress for network image"
  static const String fluttercandiesLoadingprogress =
      'viiddo://loadingprogress';

  /// MainPage
  ///
  /// [name] : viiddo//mainpage
  ///
  /// [routeName] : MainPage
  static const String fluttercandiesMainpage = 'viiddo//mainpage';

  /// "show how to paint any thing before/after image is painted"
  ///
  /// [name] : viiddo//paintimage
  ///
  /// [routeName] : paint image
  ///
  /// [description] : "show how to paint any thing before/after image is painted"
  static const String fluttercandiesPaintimage = 'viiddo://paintimage';

  /// "show how to zoom/pan image in page view like WeChat"
  ///
  /// [name] : viiddo//photoview
  ///
  /// [routeName] : photo view
  ///
  /// [description] : "show how to zoom/pan image in page view like WeChat"
  static const String fluttercandiesPhotoview = 'viiddo://photoview';

  /// PicSwiper
  ///
  /// [name] : viiddo://picswiper
  ///
  /// [routeName] : PicSwiper
  ///
  /// [arguments] : [index, pics, tuChongItem]
  ///
  /// [showStatusBar] : false
  ///
  /// [pageRouteType] : PageRouteType.transparent
  static const String fluttercandiesPicswiper = 'viiddo://picswiper';

  /// "show how to zoom/pan image"
  ///
  /// [name] : viiddo//zoomimage
  ///
  /// [routeName] : image zoom
  ///
  /// [description] : "show how to zoom/pan image"
  static const String fluttercandiesZoomimage = 'viiddo://zoomimage';
}
