import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsLetter extends StatefulWidget {
  @override
  _NewsLetterState createState() => _NewsLetterState();
}

class _NewsLetterState extends State<NewsLetter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News Articles",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 20)),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [

                Color(0xff14B4A5),
                Color(0xff3883EF),
              ],
            ),
          ),
        ),
      ),

      body:
      SingleChildScrollView(
        child: Column(children: [
          Container(
            child:Image.network('https://images.unsplash.com/photo-1471864190281-a93a3070b6de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.all(15),
            width:MediaQuery.of(context).size.width ,

            child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey,fontSize: 18)),),


          ),

          Container(margin: EdgeInsets.all(5),
            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  
                  Container(margin:EdgeInsets.all(2),

                    width: 150,height: 150,
                    child: Card(elevation: 5,
                        child: Column(
                          children: [
                            Container(padding: EdgeInsets.all(2),
                                child: Image.network('https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191__340.jpg')),
                            Container(color: Colors.blue,
                                padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
                                child: Text('News',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                          ],
                        )),
                  ),
                  Container(margin:EdgeInsets.all(2),

                    width: 150,height: 150,
                    child: Card(elevation: 5,
                        child: Column(
                          children: [
                            Container(padding: EdgeInsets.all(2),
                                child: Image.network('https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191__340.jpg')),
                            Container(color: Colors.blue,
                                padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
                                child: Text('News',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                          ],
                        )),
                  ),
                  Container(margin:EdgeInsets.all(2),

                    width: 150,height: 150,
                    child: Card(elevation: 5,
                        child: Column(
                          children: [
                            Container(padding: EdgeInsets.all(2),
                                child: Image.network('https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191__340.jpg')),
                            Container(color: Colors.blue,
                                padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
                                child: Text('News',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                          ],
                        )),
                  ),
                  Container(margin:EdgeInsets.all(2),

                    width: 150,height: 150,
                    child: Card(elevation: 5,
                        child: Column(
                          children: [
                            Container(padding: EdgeInsets.all(2),
                                child: Image.network('https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191__340.jpg')),
                            Container(color: Colors.blue,
                                padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
                                child: Text('News',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                          ],
                        )),
                  ),
                  Container(margin:EdgeInsets.all(2),

                    width: 150,height: 150,
                    child: Card(elevation: 5,
                        child: Column(
                          children: [
                            Container(padding: EdgeInsets.all(2),
                                child: Image.network('https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191__340.jpg')),
                            Container(color: Colors.blue,
                                padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
                                child: Text('News',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                          ],
                        )),
                  ),
                  


                ],),
            ),
          ),





        ],),
      ),
    );
  }
}
