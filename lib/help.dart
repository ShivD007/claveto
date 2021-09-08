import 'package:claveto/models/faq/faq_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String foos = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Help - F.A.Q",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, fontSize: 20)),
          ),
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
        body: FutureBuilder<FAQResponseModel>(
          future: getFaq(),
          builder: (_, snapshot) =>
          !snapshot.hasData ? Center(
            child: Text('Loading..'),
          ): snapshot.hasError ? Center(
            child: Text(snapshot.error.toString()),
          ) : ListView.builder(
              itemCount: snapshot.data.faqs.length,
              itemBuilder: (_, index) {
                Faqs model = snapshot.data.faqs[index];
                return CustomExpansionTile(model: model,);
              
              }),
        )

    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final Faqs model;

  const CustomExpansionTile({Key key, this.model}) : super(key: key);

  @override
  State createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          padding: EdgeInsets.all(15),
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "${widget.model.que}",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.lightBlueAccent.withOpacity(0.7),
                          fontSize: 20)),
                ),
              ),
              Icon(
                Icons.help_outline,
                color: Colors.lightBlueAccent.withOpacity(0.5),
              )
            ],
          ),
        ),
        //leading: Text('1'),
        trailing: isExpanded ? Icon(Icons.keyboard_arrow_up_outlined) : Icon(
            Icons.keyboard_arrow_down_outlined),
        children: <Widget>[
          Text("${widget.model.ans}"),

        ],
        onExpansionChanged: (bool expanding) =>
            setState(() => this.isExpanded = expanding),
        childrenPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),

      ),
    );
  }
}
