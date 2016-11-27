

#define TXNID @"txnid"
#define MERCHANTID @"merchantId"
#define SURL @"surl"
#define FURL @"furl"
#define PRODUCT_INFO @"productinfo"
#define FIRSTNAME @"firstname"
#define USER_EMAIL @"email"
#define USER_PHONE @"phone"
#define OTP_LOGIN @"quickLogin"
#define FONT_NORMAL(xx) [UIFont fontWithName:@"HelveticaNeue" size:xx]
#define FONT_MEDIUM(xx) [UIFont fontWithName:@"HelveticaNeue-Medium" size:xx]
#define FONT_BOLD(xx) [UIFont fontWithName:@"HelveticaNeue-Bold" size:xx]
#define RUPEES_SIGN_TEXT @"₹"
#define baseURL @"http://139.59.38.127"
#define CHIRP_APP_KEY          @"zyLo8iqAxzKKKeT7wpbU6i65K"
#define CHIRP_APP_SECRET       @"vLvnTRZIScqC4WOMuzoLyKNseerWGPQ4OBdPV9Bl6gJGNhz9bL"
#define SDK_BUNDLE_IDENTIFIER   [[[NSBundle bundleForClass:[self class]] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define SDK_KEYCHAIN_ACCOUNT_KEY @"MPOSUnique"
/*!
 ************************************************** ENUMs **************************************
 */
typedef NS_ENUM(NSInteger,SDK_REQUEST_TYPE ) {
    // SDK Enums
   LOGIN,
  
};

typedef NS_ENUM(NSInteger, PUMEnvironment) {
    PUMEnvironmentProduction = 0,
    PUMEnvironmentTest = 1
};

@interface PUMConstants : NSObject
@end
