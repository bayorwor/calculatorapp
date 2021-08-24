import 'package:flutter/material.dart';
import 'package:simpleapp/parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CustomColor _customColor = CustomColor();

  String values = "";
  String answer = "";

  // ignore: non_constant_identifier_names
  calulcate_results() {
    final parser = buildParser();
    final result = parser.parse(values);
    if (result.isSuccess) {
      setState(() {
        answer = result.value.toString();
      });
    } else {
      print("OOPs!! eror");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _customColor.backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${answer = answer.length > 0 ? answer : "0"}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "$values",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '7',
                          action: () {
                            setState(() {
                              values = values + "7";
                            });
                          },
                        ),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '8',
                            action: () {
                              setState(() {
                                values = values + '8';
                              });
                            }),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '9',
                            action: () {
                              setState(() {
                                values = values + "9";
                              });
                            }),
                        OperatorWidget(
                          operator: "+",
                          action: () {
                            values = values + "+";
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '4',
                            action: () {
                              setState(() {
                                values = values + '4';
                              });
                            }),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '5',
                            action: () {
                              setState(() {
                                values = values + '5';
                              });
                            }),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '6',
                            action: () {
                              setState(() {
                                values = values + '6';
                              });
                            }),
                        OperatorWidget(
                          operator: "-",
                          action: () {
                            values = values + "-";
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '1',
                            action: () {
                              setState(() {
                                values = values + '1';
                              });
                            }),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '2',
                            action: () {
                              setState(() {
                                values = values + '2';
                              });
                            }),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '3',
                            action: () {
                              setState(() {
                                values = values + '3';
                              });
                            }),
                        OperatorWidget(
                          operator: "x",
                          action: () {
                            values = values + "x";
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '0',
                            action: () {
                              if (values.isNotEmpty) {
                                setState(() {
                                  values = values + "0";
                                });
                              }
                            }),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '.',
                            action: () {
                              setState(() {
                                values = values + '.';
                              });
                            }),
                        KeyPadWidget(
                            customColor: _customColor,
                            label: '=',
                            action: () {
                              calulcate_results();
                            }),
                        OperatorWidget(
                          operator: "/",
                          action: () {
                            values = values + "-";
                          },
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OperatorWidget extends StatelessWidget {
  const OperatorWidget(
      {Key? key, required String operator, required Function action})
      : this.operator = operator,
        this.action = action,
        super(key: key);

  final String operator;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: CircleBorder(),
            padding: const EdgeInsets.all(15)),
        onPressed: () => action(),
        child: Text(
          operator,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ));
  }
}

class KeyPadWidget extends StatelessWidget {
  const KeyPadWidget(
      {Key? key,
      required CustomColor customColor,
      required String label,
      required Function action})
      : _customColor = customColor,
        this.label = label,
        this.action = action,
        super(key: key);

  final CustomColor _customColor;
  final String label;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor:
                label == "=" ? Colors.cyan : _customColor.keypadColor,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        onPressed: () => action(),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ));
  }
}

class CustomColor {
  final backgroundColor = Color.fromRGBO(30, 30, 53, 1);
  final keypadColor = Color.fromRGBO(40, 50, 73, 1);
}
