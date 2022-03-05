import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../calculator/calculator.dart';
import '../screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class BmiPage extends StatefulWidget {
  static const routeName = "bmi-page";

  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  double height = 150.0;
  double weight = 10;
  int age = 10;

  addWeight() {
    setState(() {
      weight = double.parse(_weightController.text);
      weight++;
      _weightController.text = weight.toString();
    });
  }

  minusWeight() {
    setState(() {
      if (weight > 0) {
        weight = double.parse(_weightController.text);
        weight--;
        _weightController.text = weight.toString();
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

  @override
  void dispose() {
    Hive.box('bmimodel').close();
    super.dispose();
  }

  Future addBmi(String bmi) async {
    final _bmi = Bmimodel()
      ..bmi = bmi
      ..createdDate = DateTime.now();

    final box = Boxes.getBmi();
    box.add(_bmi);
    print(_bmi.bmi);
  }

  final _ageController = TextEditingController(text: "10");
  final _weightController = TextEditingController(text: "10");
  final _heightController = TextEditingController(text: "150");

  bool male_tapped = false;
  bool female_tapped = false;
  final _formKey = GlobalKey<FormState>();
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
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "BMI ",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff025949),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "Calculator",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/dec.png",
                ),
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
                            text: "Please Select a Gender",
                            contentColor: Colors.red.shade500,
                          );
                        } else if (_formKey.currentState!.validate()) {
                          weight = double.parse(_weightController.text);
                          age = int.parse(_ageController.text);
                          Calculate_bmi calc = Calculate_bmi(
                            height: double.parse(_heightController.text),
                            weight: weight,
                            age: age,
                          );
                          var bmi = calc.bmi_calculator();
                          if (double.parse(bmi).isNegative) {
                            BotToast.showText(
                              text:
                                  "It appears your result is not valid, Try Again...",
                              contentColor: Colors.red.shade500,
                            );
                          } else if (double.parse(bmi) > 65) {
                            BotToast.showText(
                              text:
                                  "It appears your result is not valid, Try Again...",
                              contentColor: Colors.red.shade500,
                            );
                          } else if (double.parse(bmi) < 8) {
                            BotToast.showText(
                              text:
                                  "It appears your result is not valid, Try Again...",
                              contentColor: Colors.red.shade500,
                            );
                          } else if (double.parse(bmi) == 0.0) {
                            BotToast.showText(
                              text:
                                  "It appears your result is not valid, Try Again...",
                              contentColor: Colors.red.shade500,
                            );
                          } else if (double.parse(bmi) == 0.9 ||
                              double.parse(bmi) < 0.9) {
                            BotToast.showText(
                              text:
                                  "It appears your result is not valid, Try Again...",
                              contentColor: Colors.red.shade500,
                            );
                          } else {
                            addBmi(bmi);
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
                                  return ResultPage(
                                    score: calc.bmi_calculator(),
                                    result: calc.result1(),
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
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                            "Body mass index (BMI) is a measure of body fat based on height and weight that applies to adult men and women. Use the tool below to compute yours"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 5),
                        child: const Align(
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
                      Wrap(
                        children: [
                          Container(
                            height: size.height / 12,
                            width: size.width / 2.5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 62.0, // soften the shadow
                                )
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 3),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            width: size.width / 2.5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 62.0, // soften the shadow
                                )
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 3),
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
                        height: 15,
                      ),
                      Wrap(
                        children: [
                          Container(
                            height: size.height / 2.1,
                            width: size.width / 3.6,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 52.0, // soften the shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              color: Theme.of(context).primaryColor,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Height(cm)",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff025949),
                                    ),
                                  ),
                                  Flexible(
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        thumbColor: const Color(0xff025949),
                                        overlayShape:
                                            const RoundSliderOverlayShape(
                                                overlayRadius: 30.0),
                                        activeTrackColor:
                                            const Color(0xff025949),
                                        overlayColor: const Color(0xff025949),
                                      ),
                                      child: SfSlider.vertical(
                                        activeColor: const Color(0xff025949),
                                        value: height,
                                        min: 120.0,
                                        max: 220.0,
                                        inactiveColor: Colors.grey,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              height = value;
                                              _heightController.text =
                                                  height.toStringAsFixed(2);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.5),
                                          blurRadius: 52.0, // soften the shadow
                                        )
                                      ],
                                    ),
                                    width: size.width / 4.8,
                                    height: size.height / 24,
                                    child: Card(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.99),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 4,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Color(0xff025949),
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          signed: false,
                                          decimal: false,
                                        ),
                                        controller: _heightController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          errorStyle:
                                              TextStyle(color: Colors.red),
                                        ),
                                        validator: (val) {
                                          if (val == "" || val == null) {
                                            return BotToast.showText(
                                              text: "Height shall not be empty",
                                              contentColor: Colors.red.shade500,
                                            ) as String;
                                          } else if (double.parse(val)
                                              .isNegative) {
                                            return BotToast.showText(
                                                text:
                                                    "Height can't be Negative",
                                                contentColor: Colors
                                                    .red.shade500) as String;
                                          } else if (double.parse(val) == 0) {
                                            return BotToast.showText(
                                                text: "Height can't be 0",
                                                contentColor: Colors
                                                    .red.shade500) as String;
                                          } else if (double.parse(val) > 300) {
                                            return BotToast.showText(
                                                text:
                                                    "Please provide a valid height",
                                                contentColor: Colors
                                                    .red.shade500) as String;
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              GridTile(
                                child: Container(
                                  height: size.height / 4.6,
                                  width: size.width / 2.6,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 52.0, // soften the shadow
                                      )
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 2),
                                  child: Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Age (In Year)",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff025949),
                                            fontWeight: FontWeight.w500,
                                          ),
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
                                                fontSize: 28,
                                                color: Color(0xff025949),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              controller: _ageController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              validator: (val) {
                                                if (val == "" || val == null) {
                                                  return BotToast.showText(
                                                    text:
                                                        "Age shall not be empty",
                                                    contentColor:
                                                        Colors.red.shade500,
                                                  ) as String;
                                                } else if (int.parse(val) >
                                                    200) {
                                                  return BotToast.showText(
                                                    text:
                                                        "Please provide a vaild age",
                                                    contentColor:
                                                        Colors.red.shade500,
                                                  ) as String;
                                                } else if (val.length > 3) {
                                                  return BotToast.showText(
                                                    text:
                                                        "Please provide a vaild age",
                                                    contentColor:
                                                        Colors.red.shade500,
                                                  ) as String;
                                                } else if (int.parse(val)
                                                    .isNegative) {
                                                  return BotToast.showText(
                                                    text:
                                                        "Age can't be negative",
                                                    contentColor:
                                                        Colors.red.shade500,
                                                  ) as String;
                                                } else if (int.parse(val) ==
                                                    0) {
                                                  return BotToast.showText(
                                                    text: "Age can't be 0",
                                                    contentColor:
                                                        Colors.red.shade500,
                                                  ) as String;
                                                }
                                              },
                                            ),
                                            const Divider(
                                              thickness: 1.5,
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
                              const SizedBox(
                                height: 10,
                              ),
                              GridTile(
                                child: Container(
                                  height: size.height / 4.6,
                                  width: size.width / 2.6,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 62.0, // soften the shadow
                                        //extend the shadow
                                      )
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Card(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Weight (In Kg)",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff025949),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            TextFormField(
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                fontSize: 28,
                                                color: Color(0xff025949),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              controller: _weightController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              validator: (val) {
                                                // if (val == "" || val == null) {
                                                //   return BotToast.showText(
                                                //     text:
                                                //         "Weight shall not be empty",
                                                //     contentColor:
                                                //         Colors.red.shade500,
                                                //   ) as String;
                                                // } else if (double.parse(val) >=
                                                //     199) {
                                                //   return BotToast.showText(
                                                //     text:
                                                //         "Please provide a vaild weight",
                                                //     contentColor:
                                                //         Colors.red.shade500,
                                                //   ) as String;
                                                // } else if (double.parse(val)
                                                //     .isNegative) {
                                                //   return BotToast.showText(
                                                //     text:
                                                //         "Weight can't be negative",
                                                //     contentColor:
                                                //         Colors.red.shade500,
                                                //   ) as String;
                                                // } else if (double.parse(val) ==
                                                //     0) {
                                                //   return BotToast.showText(
                                                //     text: "Weight can't be 0",
                                                //     contentColor:
                                                //         Colors.red.shade500,
                                                //   ) as String;
                                                // }
                                              },
                                            ),
                                            const Divider(
                                              thickness: 1.5,
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
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
