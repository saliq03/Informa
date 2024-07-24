import 'dart:convert';
import 'package:flutter/foundation.dart';
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

 @override
  void initState() {
    FetchNews();
    super.initState();
  }

 FetchNews()async{
   print("method called");
   final Url="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f83fce02237041b5a398ac454f57d936";
   var response=await http.get(Uri.parse(Url));
   if(response.statusCode==200){
     print("i am here");
    var result =jsonDecode(response.body);
    mynews=NewsModel.fromJson(result);
    return NewsModel.fromJson(result);

   }
   else{
     print("here");
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
    body: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Category("Buisness"),
            Category("Buisness"),
            Category("Buisness"),
          ],
        ),
        SizedBox(height: 10,),
        Divider(),

        Container(
          height: MediaQuery.of(context).size.height*0.5,
          child: FutureBuilder(future: FetchNews(), builder: (context,snapshot) {
                return ListView.builder(itemCount: mynews.articles!.length,
                    itemBuilder: (context,index){
                  return Container(
                    decoration: BoxDecoration(
                      border:Border.all(width: 2,color: Colors.black)
                    ),
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   backgroundImage:NetworkImage("${mynews.articles![index].urlToImage}",) ,),
                      title: Text(mynews.articles![index].title!),
                      // subtitle: Text(mynews.articles![index].description!),

                    ),
                  );
                });
              },),
        ),
      ],
    ),
    );
  }
  Category(String name){
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: Colors.black),
        borderRadius: BorderRadius.circular(11)
      ),
     child: Text(" $name "),
   );
  }
}
