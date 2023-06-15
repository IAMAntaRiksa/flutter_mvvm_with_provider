class Api {
  /// Base API Endpoint

  /// * -------------------
  ///  * Caffe Endpoint
  ///  * ------------------
  ///  * In this field will exists
  ///  * some route about Caffes
  /// */
  String getCaffes = "$_baseServer/list";
  String getCaffe = "$_baseServer/detail/:id";
  String searchCaffe = "$_baseServer/search";
  // String createReview = "$_baseServer/review";
}
