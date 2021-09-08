import 'package:flutter/material.dart';

class LocationEnable extends StatefulWidget {
  @override
  _LocationEnableState createState() => _LocationEnableState();
}

class _LocationEnableState extends State<LocationEnable> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit:BoxFit.cover,
              image: NetworkImage('https://www.umhs-adolescenthealth.org/wp-content/uploads/2016/12/google-map-background.jpg',)
            ),
          ),
          child: Container(
            color: Colors.white.withOpacity(0.8),
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(990)
                      ),
                      child: Image.network('https://freesvg.org/img/1392496432.png',height: 250,)),
                  SizedBox(height: 120,),
                  Text("We are unable to Locate you",style: TextStyle(color: Colors.black,fontSize: 28),),
                  Container(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      margin: EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                      ),
                      child:
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined,color: Colors.white,),
                        SizedBox(width: 15,),
                        Text('Enable Location',style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    )
                    ),
                  Container(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      margin: EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                      ),
                      child:
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.white,),
                          SizedBox(width: 15,),
                          Text('Fetch Location',style: TextStyle(color: Colors.white,fontSize: 25),),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
