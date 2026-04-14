class DbKeys {
  static const ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const REFRESH_TOKEN = 'REFRESH_TOKEN';
  static const USER_MODEL = 'USER_MODEL';
  static const USER_SETTINGS = 'USER_SETTINGS';
}

class AppUrls {
  static const OASIS_WEB_URL = 'https://oasis-seven-puce.vercel.app/';
}

class Endpoints {
  ///////////////////////
  // AUTH
  ///////////////////////
  static const String ME = '/auth/me';
  static const String REFRESH = '/auth/refresh';
  static const String EXCHANGE = '/auth/exchange';
  static const String REGISTER = '/auth/register';
  static const String LOGIN = '/auth/login';
  static const String LOGOUT = '/auth/logout';
  static const String LOGOUT_ALL = '/auth/logout/all';
  static const String EMAIL_VERIFY = '/auth/email/verify';
  static const String EMAIL_SEND_CODE = '/auth/email/send-code';
  static const String FORGOT_PASSWORD = '/auth/password/forgot';
  static const String RESET_PASSWORD = '/auth/password/reset';

  static String socialLogin(String provider) => '/auth/provider/$provider';

  static String provider(String provider) => '/auth/provider/$provider';

  ///////////////////////
  // CATEGORY
  ///////////////////////
  static String categoryAll([String? query]) =>
      '/categories${query != null ? '?$query' : ''}';

  static String categoryContent(String slug) => '/categories/$slug';

  ///////////////////////
  // TAG
  ///////////////////////
  static const String TAGS_ALL = '/tags';

  ///////////////////////
  // PRODUCT
  ///////////////////////
  static const String PRODUCTS_TOP = '/products/top';

  static String productsAll([String? query]) =>
      '/products${query != null && query.isNotEmpty ? '?$query' : ''}';

  static String productDetails(String id) => '/products/$id';

  ///////////////////////
  // INSPIRATION
  ///////////////////////
  static const String INSPIRATIONS_ALL = '/inspirations';

  ///////////////////////
  // BLOG
  ///////////////////////
  static const String BLOGS_ALL = '/blogs';

  static String blogContent(String slug) => '/blogs/$slug';

  ///////////////////////
  // CART
  ///////////////////////
  static const String CART_ALL = '/cart';
  static const String CART_ADD = '/cart/items';
  static const String CART_SYNC = '/cart/sync';
  static const String CART_CLEAR = '/cart';

  static String cartIncrementQuantity(int productId) =>
      '/cart/items/$productId/quantity/increment';

  static String cartDecrementQuantity(int productId) =>
      '/cart/items/$productId/quantity/decrement';

  static String cartRemove(int productId) => '/cart/items/$productId';

  ///////////////////////
  // CHECKOUT
  ///////////////////////
  static const String CHECKOUT_GET = '/checkout';
  static const String CHECKOUT_MAKE = '/checkout';
  static const String CHECKOUT_ADDRESS = '/checkout/address';

  ///////////////////////
  // PAYMENT
  ///////////////////////
  static const String PAYMENT_GET_INTENT = '/payment/show';
  static const String PAYMENT_INTENT = '/payment/intent';
  static const String PAYMENT_CONFIRM = '/payment/confirm';

  ///////////////////////
  // ORDER
  ///////////////////////
  static const String ORDERS_ALL = '/orders';

  static String orderGet(String id) => '/orders/$id';
}

class AppTexts {
  static const GENERIC_ERROR =
      'Looks like something went wrong and we can’t process this request right now. Please try again.';

  static const UNAUTHORIZED_ERROR = 'Session expired, please login again.';
}