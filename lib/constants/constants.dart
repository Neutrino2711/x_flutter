class BasicApiConstants {
  static const String baseUrl = 'https://0de9-47-9-121-4.ngrok-free.app/';
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


class UserApiConstants {
  static const String baseurl = '${BasicApiConstants.baseUrl}user/';
  static const String create = '${UserApiConstants.baseurl}create/';
  static const String me = '${baseurl}me/';
  static const String login = '${baseurl}token/';

}

