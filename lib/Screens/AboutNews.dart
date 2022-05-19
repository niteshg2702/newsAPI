import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/Models/NewsModel.dart';

class AboutNews extends StatefulWidget {
  var news;
  int index;
  AboutNews({Key? key, required this.news, required this.index}) : super(key: key);

  @override
  State<AboutNews> createState() => _AboutNewsState();
}

class _AboutNewsState extends State<AboutNews> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height/812;
    var w = MediaQuery.of(context).size.width/375;
    Article news = widget.news;
    return Scaffold(
      backgroundColor: const Color(0xff464646),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                news.urlToImage == "" ? "https://media.istockphoto.com/photos/gray-abstract-minimal-motion-backgrounds-loopable-elements-4k-picture-id1174989482?k=20&m=1174989482&s=612x612&w=0&h=u8DlBa3XuF5J1vuCTASf6EY_gMxcRmt94OmUVq27A0M=" : news.urlToImage,
              ),
              fit: BoxFit.cover,
            )
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black])
          ),
          child: Column(
            children: [
              SizedBox(height: 12 * h,),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0 * h, horizontal: 10 * w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(42 * w)
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        iconSize: 42 * h,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24 * w),
                child: Text(
                  news.title,
                  style: GoogleFonts.robotoSlab(
                      fontSize: 29,
                      color: const Color(0xfff2f2f2),
                      fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 64 * h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24 * w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.source.name,
                      style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                          color: const Color(0xfff2f2f2),
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(news.publishedAt).toString(),
                      style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                          color: const Color(0xfff2f2f2),
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16 * h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24 * w),
                child: Text(
                  news.content,
                  style: GoogleFonts.robotoSlab(
                      fontSize: 14,
                      color: const Color(0xffbababa),
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
