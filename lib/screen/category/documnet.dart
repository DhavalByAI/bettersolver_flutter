import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';

class Documnet extends StatefulWidget {
  @override
  State<Documnet> createState() => _DocumnetState();
}

class _DocumnetState extends State<Documnet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 10,
            shrinkWrap: false,
            primary: false,
            itemBuilder: (Context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        margin: EdgeInsets.only(left: 15, top: 15),
                        decoration: Palette.RoundGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/photo.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Darrell Steward',
                              style: Palette.greytext15,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Hello! How are you?',
                              style: Palette.blackText12,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '23 mins',
                              style: Palette.greytext12,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: Palette.buttonGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.9),
                                  child: Center(
                                      child: Text(
                                    '2',
                                    style: Palette.blackTextDark12,
                                  )),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              );
            }));
  }
}
