import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .28,
          color: Colors.redAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 190,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: true,
                                  repeatForever: false,
                                  animatedTexts: [
                                    ScaleAnimatedText(
                                      "Hire Me !",
                                      duration: Duration(seconds: 15),
                                      textAlign: TextAlign.center,
                                      
                                    ),
                                    ScaleAnimatedText(
                                      "Let's start a new journey of",
                                      duration: Duration(seconds: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  ScaleAnimatedText(
                                      '- Workers , Electricians,\nand who earn respect...',
                                      duration: Duration(seconds: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    ScaleAnimatedText(
                                      'with their work and character...',
                                      duration: Duration(seconds: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    ScaleAnimatedText(
                                      '- Vishal Pandey',
                                      duration: Duration(seconds: 10),
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      Neumorphic(
                        style: NeumorphicStyle(
                            color: Colors.white,
                            oppositeShadowLightSource: true),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/hiringapp-b9f5d.appspot.com/o/banner%2Ficons8-worker-100.png?alt=media&token=36978e1a-4376-492f-86c8-89962010f0a3',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: NeumorphicButton(
                            onPressed: () {},
                            style: NeumorphicStyle(color: Colors.white),
                            child: Text(
                              'Hire by People',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    SizedBox(width: 20),
                    Expanded(
                        child: NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text(
                        'Hire Workers',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
