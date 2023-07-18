import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';

class PopBackDialouge {
  static Future<void> showDialogue(
      BuildContext context, GlobalKey key, String mesasge) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            //backgroundColor: Colors.white,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                      child: Text(
                        mesasge,
                        style: Palette.title,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: kStandardMargin,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //  Navigator.pop(context);
                        },
                        shape: Palette.btnShape,
                        color: kBlack,
                        child: Text('OK', style: Palette.wihtetext14),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
