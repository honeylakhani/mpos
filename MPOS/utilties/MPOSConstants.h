

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

/*!
 ************************************************** ENUMs **************************************
 */
typedef NS_ENUM(NSInteger,SDK_REQUEST_TYPE ) {
    // SDK Enums
    SDK_USER_SAVE_CARDS,
    SDK_SEND_OTP,
    SDK_CC_BIN_DETAILS,
    SDK_REQUEST_SIGNUP = 200,
    SDK_REQUEST_PAYMENT,
    SDK_REQUEST_GET_PAYMENT_MERCHANT,
    SDK_REQUEST_PARAMS,
    SDK_REQUEST_OTP,
    SDK_REQUEST_LOGIN,
    SDK_REQUEST_KVAULT_TEST,
    SDK_REQUEST_KVAULT_PROD,
    SDK_REQUEST_USER_REG_AND_LOGIN,
    SDK_REQUEST_GET_PROFILE,
    SDK_REQUEST_FORGOT_PASSWORD,
    SDK_CANCEL_TRANSACTION,
    SDK_REQUEST_CANCEL_TXN_MANUALLY,
    SDK_REQUEST_POST_PAYMENT,
    SDK_REQUEST_ONE_CLICK,
    SDK_REQUEST_HASH,
    SDK_REQUEST_CARD_ONE_CLICK,
    BANK_REWARDS_FETCH,
    SDK_REQUEST_ONE_TAP,
    SDK_AFTER_LOGIN,
    SDK_REQUEST_BANK_LIST,
    SDK_REQUEST_LOAD_WALLET,
    BANK_REWARDS_FETCH_POINTS,
    SDK_GENERATE_WALLET_CODE,
    SDK_FETCH_PAYMENT_USER_DATA
    
};

typedef NS_ENUM(NSInteger, PUMEnvironment) {
    PUMEnvironmentProduction = 0,
    PUMEnvironmentTest = 1
};

@interface PUMConstants : NSObject
@end
