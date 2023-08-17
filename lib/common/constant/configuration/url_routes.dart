extension ScopeApi on String {
  String get _api => '/api';
  String get _version => '/v1';

  String get _getPrefix => '/orderingSystem/public$_api$_version';
  String get scope => '$_getPrefix/$this';
  String get filesScope => '$_getPrefix/files/$this';
  String get ordersScope => '$_getPrefix/orders/$this';
}


abstract class EndPoints {

  static final getTables = 'tables'.scope;
  static final addTables = 'tables'.scope;
  static String editTable(String id) => '${'tables'.scope}/$id';
  static String deleteTable(String id) => '${'tables'.scope}/$id';
  ////////
  static final getProducts = 'products'.scope;
  static final addProducts  = 'products'.scope;
  static final uploadImage  = 'upload'.filesScope;
  static String editProduct(String id) => '${'products'.scope}/$id';
  static String deleteProducts(String id) => '${'products'.scope}/$id';

  ///////
  static final createOrder  = 'add_to_order'.ordersScope;
}

abstract class Urls {
  static String get baseUrl => _baseUrlDev;

  static Uri get baseUri => Uri.parse(_baseUrlDev);

  static const String _baseUrlDev = 'http://44.202.51.221';
}
