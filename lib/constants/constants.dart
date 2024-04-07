class BasicApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8000/';
}

class PostConstants {
  static const String postlistUrl = '${BasicApiConstants.baseUrl}post/user_posts/';
  static const String bookmarklistUrl  = '${BasicApiConstants.baseUrl}post/user_bookmarks/';
  static  String postDetail(int id) {
    return   '${BasicApiConstants.baseUrl}post/$id/';
  } 
  static const String postCreateUrl = '${BasicApiConstants.baseUrl}post/';
  static String bookmarkUrl(int id )
  {
      return '${BasicApiConstants.baseUrl}post/$id/bookmark/';
  }
  static String voteUrl(int id )
  {
      return '${BasicApiConstants.baseUrl}post/$id/vote/';
  }
  static const String trendingUrl = '${BasicApiConstants.baseUrl}post/trending/';

  


}