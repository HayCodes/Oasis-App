class AppUrls {
  static const OASIS_WEB_URL = 'https://oasis-seven-puce.vercel.app/';
  static const BASE_URL = 'http://oasis-be.onrender.com';
}

class AppTexts {
  static const GENERIC_ERROR =
      'Looks like something went wrong and we can’t process this request right now. Please try again.';

  static const UNAUTHORIZED_ERROR = 'Session expired, please login again.';
}

class Endpoints {
  ///////////////////////
  // AUTH
  ///////////////////////
  static const String ME = '/api/auth/me';
  static const String REFRESH = '/api/auth/refresh';
  static const String EXCHANGE = '/api/auth/exchange';
  static const String REGISTER = '/api/auth/register';
  static const String LOGIN = '/api/auth/login';
  static const String LOGOUT = '/api/auth/logout';
  static const String LOGOUT_ALL = '/api/auth/logout/all';
  static const String EMAIL_VERIFY = '/api/auth/email/verify';
  static const String EMAIL_SEND_CODE = '/api/auth/email/send-code';
  static const String FORGOT_PASSWORD = '/api/auth/password/forgot';
  static const String RESET_PASSWORD = '/api/auth/password/reset';
  static String socialLogin(String provider) => '/api/auth/provider/$provider';
  static String provider(String provider) => '/api/auth/provider/$provider';

  ///////////////////////
  // CATEGORY
  ///////////////////////
  static String categoryAll([String? query]) =>
      '/api/categories${query != null ? '?$query' : ''}';

  static String categoryContent(String slug) => '/api/categories/$slug';

  ///////////////////////
  // TAG
  ///////////////////////
  static const String TAGS_ALL = '/api/tags';

  ///////////////////////
  // PRODUCT
  ///////////////////////
  static const String PRODUCTS_TOP = '/api/products/top';

  static String productsAll([String? query]) =>
      '/api/products${query != null && query.isNotEmpty ? '?$query' : ''}';

  static String productDetails(String slug) => '/api/products/$slug';

  ///////////////////////
  // INSPIRATION
  ///////////////////////
  static const String INSPIRATIONS_ALL = '/api/inspirations';

  ///////////////////////
  // BLOG
  ///////////////////////
  static const String BLOGS_ALL = '/api/blogs';
  static String blogContent(String slug) => '/api/blogs/$slug';

  ///////////////////////
  // CART
  ///////////////////////
  static const String CART_ALL = '/api/cart';
  static const String CART_ADD = '/api/cart/items';
  static const String CART_SYNC = '/api/cart/sync';
  static const String CART_CLEAR = '/api/cart';
  static String cartIncrementQuantity(int productId) =>
      '/api/cart/items/$productId/quantity/increment';
  static String cartDecrementQuantity(int productId) =>
      '/api/cart/items/$productId/quantity/decrement';
  static String cartRemove(int productId) => '/api/cart/items/$productId';

  ///////////////////////
  // CHECKOUT
  ///////////////////////
  static const String CHECKOUT_GET = '/api/checkout';
  static const String CHECKOUT_MAKE = '/api/checkout';
  static const String CHECKOUT_ADDRESS = '/api/checkout/address';

  ///////////////////////
  // PAYMENT
  ///////////////////////
  static const String PAYMENT_GET_INTENT = '/api/payment/show';
  static const String PAYMENT_INTENT = '/api/payment/intent';
  static const String PAYMENT_CONFIRM = '/api/payment/confirm';

  ///////////////////////
  // ORDER
  ///////////////////////
  static const String ORDERS_ALL = '/api/orders';
  static String orderGet(String id) => '/api/orders/$id';
}
