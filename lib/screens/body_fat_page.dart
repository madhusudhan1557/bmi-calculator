import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bf_model/bf_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import '../calculator/body_fat_calculator.dart';
import 'package:flutter/material.dart';

import 'body_fat_result.dart';

class BodyFatPage extends StatefulWidget {
  static const routeName = "body_fat-page";

  const BodyFatPage({Key? key}) : super(key: key);

  @override
  _BodyFatPageState createState() => _BodyFatPageState();
}

class _BodyFatPageState extends State<BodyFatPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController =
      TextEditingController(text: "10");
  final TextEditingController _bmiController =
      TextEditingController(text: "10");

  @override
  void dispose() {
    Hive.box('bfmodel').close();
    super.dispose();
  }

  double bmi = 10;
  int age = 10;

  addWeight() {
    setState(() {
      bmi = double.parse(_bmiController.text);
      bmi++;
      _bmiController.text = bmi.toString();
    });
  }

  minusWeight() {
    setState(() {
      if (bmi > 0) {
        bmi = double.parse(_bmiController.text);
        bmi--;
        _bmiController.text = bmi.toString();
      }
    });
  }

  addAge() {
    setState(() {
      age = int.parse(_ageController.text);
      age++;
      _ageController.text = age.toString();
    });
  }

  minusAge() {
    setState(() {
      if (age > 0) {
        age = int.parse(_ageController.text);
        age--;
        _ageController.text = age.toString();
      }
    });
  }

  Future addBf(String bf) async {
    final _bf = Bfmodel()
      ..bf = bf
      ..createdDate = DateTime.now();
    final box = Boxes.getBf();
    box.add(_bf);
  }

  bool male_tapped = false;
  bool female_tapped = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode cf = FocusScope.of(context);
        if (!cf.hasPrimaryFocus) {
          cf.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Body ",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff025949),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "Fat Percentage",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset("assets/images/dec.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35, bottom: 25),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.arrowRight,
                        color: Color(0xff025949),
                      ),
                      onPressed: () {
                        if (male_tapped == false && female_tapped == false) {
                          BotToast.showText(
                            text: "Please select a gender",
                            contentColor: Colors.red.shade500,
                          );
                        } else if (_formKey.currentState!.validate()) {
                          BodyFatCalculator calc = BodyFatCalculator(
                            age: int.parse(_ageController.text),
                            bmi: double.parse(_bmiController.text),
                          );
                          var bf = calc.bfcalulator();

                          if (bf.isNegative) {
                            BotToast.showText(
                              text:
                                  "It appears your result are not valid, Try again..",
                              contentColor: Colors.red.shade500,
                            );
                          } else if (bf <= 1.9) {
                            BotToast.showText(
                              text:
                                  "It appears your result are not valid, Try again..",
                              contentColor: Colors.red.shade500,
                            );
                          } else if (bf <= 0) {
                            BotToast.showText(
                              text:
                                  "It appears your result are not valid, Try again..",
                              contentColor: Colors.red.shade500,
                            );
                          } else if (bf >= 80) {
                            BotToast.showText(
                              text:
                                  "It appears your result are not valid, Try again..",
                              contentColor: Colors.red.shade500,
                            );
                          } else {
                            addBf(bf.toString());
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: const Duration(seconds: 1),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  animation = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOutCubicEmphasized,
                                  );
                                  return ScaleTransition(
                                    alignment: Alignment.center,
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder: (context,
                                    Animation<double> animation,
                                    Animation<double> secAnimation) {
                                  return BodyFatResultPage(
                                    score: calc.bfcalulator(),
                                    result: calc.result(),
                                    result2: calc.result2(),
                                  );
                                },
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 5),
                          child: Text(
                              "Body Fat Calculator helps you to find out your body fat percentage, your body type and the number of calories you have to burn, to lose 1% of your body fat. Use the tool below to compute yours"),
                        ),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  color: Color(0xff025949),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            Container(
                              height: size.height / 12,
                              width: size.width / 2.4,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 62.0, // soften the shadow
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Card(
                                color: male_tapped
                                    ? const Color(0xff025949)
                                    : Theme.of(context).primaryColor,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      male_tapped = !male_tapped;
                                      female_tapped = false;
                                    });
                                  },
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.male,
                                        size: 30,
                                        color: male_tapped
                                            ? Colors.white
                                            : const Color(0xff025949),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Male",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: male_tapped
                                              ? Colors.white
                                              : const Color(0xff025949),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height / 12,
                              width: size.width / 2.4,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 62.0, // soften the shadow
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Card(
                                color: female_tapped
                                    ? const Color(0xff025949)
                                    : Theme.of(context).primaryColor,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide.none,
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.female,
                                        size: 30,
                                        color: female_tapped
                                            ? Colors.white
                                            : const Color(0xff025949),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Female",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: female_tapped
                                              ? Colors.white
                                              : const Color(0xff025949),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      female_tapped = !female_tapped;
                                      male_tapped = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GridTile(
                          child: Container(
                            height: size.height / 4.5,
                            width: size.width / 2.3,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 62.0, // soften the shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: Theme.of(context).primaryColor,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Age (In Year)",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff025949)),
                                  ),
                                  Column(
                                    children: [
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          signed: false,
                                          decimal: false,
                                        ),
                                        style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff025949)),
                                        controller: _ageController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        validator: (val) {
                                          if (val == "" || val == null) {
                                            return BotToast.showText(
                                              text: "Age shall not be empty",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          } else if (val.length > 3) {
                                            return BotToast.showText(
                                              text:
                                                  "Please provide a vaild age",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          } else if (int.parse(val)
                                              .isNegative) {
                                            return BotToast.showText(
                                              text: "Age can't be negative",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          } else if (int.parse(val) == 0) {
                                            return BotToast.showText(
                                              text: "Age can't be 0",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          }
                                        },
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Color(0xff025949),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff025949),
                                        child: IconButton(
                                          onPressed: () {
                                            minusAge();
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.minus,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff025949),
                                        child: IconButton(
                                          onPressed: () {
                                            addAge();
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridTile(
                          child: Container(
                            height: size.height / 4.5,
                            width: size.width / 2.3,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 62.0, // soften the shadow
                                )
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Card(
                              color: Theme.of(context).primaryColor,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Body Mass Index",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff025949),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        keyboardType: const TextInputType
                                                .numberWithOptions(
                                            signed: false, decimal: true),
                                        style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff025949)),
                                        controller: _bmiController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          errorStyle:
                                              TextStyle(color: Colors.red),
                                        ),
                                        validator: (val) {
                                          if (val == "" || val == null) {
                                            return BotToast.showText(
                                              text: "Bmi shall not be empty",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          } else if (val.length > 4) {
                                            return BotToast.showText(
                                              text:
                                                  "Please provide a vaild Bmi",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          } else if (double.parse(val)
                                              .isNegative) {
                                            return BotToast.showText(
                                              text: "Bmi can't be negative",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          } else if (double.parse(val) == 0) {
                                            return BotToast.showText(
                                              text: "Bmi can't be 0",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          }
                                        },
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Color(0xff025949),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff025949),
                                        child: IconButton(
                                          onPressed: () {
                                            minusWeight();
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.minus,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff025949),
                                        child: IconButton(
                                          onPressed: () {
                                            addWeight();
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
