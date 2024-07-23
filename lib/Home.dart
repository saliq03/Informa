import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:informa/NewsModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 NewsModel mynews=NewsModel();
 FetchNews()async{
   final Url="https://newsapi.org/v2/everything?q=tesla&from=2024-06-23&sortBy=publishedAt&apiKey=f83fce02237041b5a398ac454f57d936";
   var response=await http.get(Uri.parse(Url));
   if(response.statusCode==200){
    var result =jsonDecode(response.body);
    mynews=NewsModel.fromJson(result);
    return NewsModel.fromJson(result);


   }
   else{
     print(response.statusCode);
     return NewsModel();
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("News") ,
      ),
    body: FutureBuilder(future: FetchNews(), builder: (context,snapshot) {
      return ListView.builder(itemCount: mynews.articles!.length,
          itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:NetworkImage("${mynews.articles![index].urlToImage}") ,),
          title: Text(mynews.articles![index].title!),
          subtitle: Text(mynews.articles![index].description!),

        );
      });
    },),
    );
  }
}
