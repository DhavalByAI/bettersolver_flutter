import 'package:bettersolver/utils/apiprovider.dart';

import '../models/social_media_model.dart';

class SocialMediaRepository {

  ApiProvider _provider = ApiProvider();

  Future<SocialMediaModel> social_login () async {
    
    final requestBody = {};
    
    final response = await _provider.httpMethodWithoutToken(
        'post',
        'http://bettersolver.com/demo2/app_api.php?application=phone&type=social_login',
        requestBody);
    
      
    return SocialMediaModel.fromJson(response);
  }

}