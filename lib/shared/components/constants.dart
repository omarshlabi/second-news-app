
//  POST
//  UPDATE
//  DELETE
//  GET
//  base url:  https://newsapi.org/

//  method (URL):  v2/top-headlines?

//  queries : country=eg&apiKey=d505e1ca8327496abef9ad9555b02c90


//  queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca


import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';


// This Method UseFul For Print All Data From Json File!
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is The Size Of Each chunk
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
