import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class BodyFatResultPage extends StatefulWidget {
  final double score;
  final String result;
  final String result2;

  const BodyFatResultPage({
    Key? key,
    required this.score,
    required this.result,
    required this.result2,
  }) : super(key: key);

  @override
  State<BodyFatResultPage> createState() => _BodyFatResultPageState();
}

class _BodyFatResultPageState extends State<BodyFatResultPage> {
  @override
  void initState() {
    if (widget.score > 80) {
      BotToast.showText(
        text: "It appears your result is not valid",
        contentColor: Colors.red.shade500,
      );
    } else if (widget.score < 2) {
      BotToast.showText(
        text: "It appears your result is not valid",
        contentColor: Colors.red.shade500,
      );
    } else if (widget.score <= 0) {
      BotToast.showText(
        text: "It appears your result is not valid",
        contentColor: Colors.red.shade500,
      );
    } else if (widget.score.isNegative) {
      BotToast.showText(
        text: "It appears your result is not valid",
        contentColor: Colors.red.shade500,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/dec.png"),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset("assets/images/left.png"),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset("assets/images/right.png"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset("assets/images/dec1.png"),
            ),
            Column(
              children: [
                Container(
                  height: size.height / 2.7,
                  width: size.width / 1.2,
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.only(top: 110),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      title: const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Your Body Fat Percentage :  ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff025949),
                              radius: 70,
                              child: Text(
                                widget.score.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.result,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  height: size.height / 9,
                  width: size.width / 1.2,
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          widget.result2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    primary: const Color(0xff025949),
                    fixedSize: const Size(221, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Done",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
