import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/API/NewsAPI.dart';
import 'package:news/Models/NewsModel.dart';
import 'package:intl/intl.dart';
import 'package:news/Screens/AboutNews.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  getnews() async {
    return await getNews();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height/812;
    var w = MediaQuery.of(context).size.width/375;
    return Scaffold(
      backgroundColor: const Color(0xff464646),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff000000),
        title: Text(
            "HEADLINES",
          style: GoogleFonts.robotoSlab(
            fontSize: 29 ,
            fontWeight: FontWeight.w700,
            color: const Color(0xffffffff)
          ),
        ),
      ),
      body: FutureBuilder(
        future: getnews(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            News news = News.fromJson(snapshot.data);
            return RefreshIndicator(
              color: Colors.black,
              onRefresh: () async {
                return Future.delayed(
                  const Duration(seconds: 1),
                      () {
                    setState(() {});
                  },
                );
              },
              child: ListView.builder(
                itemCount: news.articles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => AboutNews(news: news.articles[index], index: index,))
                      );
                    },
                    child: SizedBox(
                      height: 280 * h,
                      child: Container(
                        margin: EdgeInsets.all(12 * w),
                        height: 280 * h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              news.articles[index].urlToImage == "" ? "https://media.istockphoto.com/photos/gray-abstract-minimal-motion-backgrounds-loopable-elements-4k-picture-id1174989482?k=20&m=1174989482&s=612x612&w=0&h=u8DlBa3XuF5J1vuCTASf6EY_gMxcRmt94OmUVq27A0M=" : news.articles[index].urlToImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                          borderRadius: BorderRadius.circular(15 * w),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15 * w),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black])
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16 * w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                news.articles[index].title,
                                style: GoogleFonts.robotoSlab(
                                    fontSize: 20,
                                    color: const Color(0xfff2f2f2),
                                  fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 18 * h,),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: news.articles[index].source.name + "  ",
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: 12 ,
                                        color: const Color(0xffbababa),
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    TextSpan(
                                      text: DateFormat('yyyy-MM-dd').format(news.articles[index].publishedAt).toString(),
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: 12 ,
                                        color: const Color(0xffbababa),
                                      ),
                                    )
                                  ]
                                )
                              ),
                              SizedBox(height: 12 * h,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.black,)
          );
        },
      )
    );
  }
}
