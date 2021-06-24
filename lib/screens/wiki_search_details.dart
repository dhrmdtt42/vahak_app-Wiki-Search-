import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WikiSearchDetails extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  WikiSearchDetails(
      {@required this.title, @required this.description, @required this.image});

  @override
  _WikiSearchDetailsState createState() => _WikiSearchDetailsState();
}

class _WikiSearchDetailsState extends State<WikiSearchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                child: Image.network(
                  widget.image,
                  height: 150,
                  width: 300,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "${widget.title}",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "${widget.description}",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
