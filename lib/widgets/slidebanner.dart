import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class slide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: size.height * 0.20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(colors: [
              Colors.redAccent, 
              Colors.deepPurpleAccent,
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  EdgeInsets.all(10.0),
              child: Container(
                height: double.infinity,
                width: 140,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: Colors.deepPurpleAccent),
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            'COOK\nENJOY\nREPEAT',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: 10.0),
              child: Container(
                height: double.infinity,
                width: 170,
                child: ClipRRect(
                  child: Image.asset('assets/images/gridimage.png'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
