import 'package:flutter/material.dart';
import 'package:gluon_test/widgets/bubble_chat.dart';

class FormUsername extends StatefulWidget {
  @override
  State<FormUsername> createState() => _FormUsernameState();
}

class _FormUsernameState extends State<FormUsername> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? valid;
  bool userNameHasFocus = false;
  FocusNode userNameFocusNode = FocusNode();
  bool showError = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void onChanged(String value) {
    print(value);
    if (value.isEmpty) {
      setState(() {
        showError = true;
        valid = false;
      });
    } else {
      setState(() {
        showError = false;
        valid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            // color: Colors.green.withOpacity(0.5),
            child: Stack(
              children: [
                showError == true
                    ? Positioned(
                        top: 20,
                        right: 20,
                        child: Align(
                          alignment: Alignment
                              .topRight, //Change this to Alignment.topRight or Alignment.topLeft
                          child: CustomPaint(
                            painter: ChatBubble(
                                color: Colors.red[900],
                                alignment: Alignment.topRight),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Stack(
                                children: <Widget>[
                                  Text(
                                    "Username cannot be empty",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),

                Positioned(
                  // bottom: 90,
                  top: 50,
                  child: Container(
                      width: MediaQuery.of(context).size.width - 65,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          focusNode: userNameFocusNode,
                          controller: _nameController,
                          onChanged: (val) => onChanged(val),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            suffixIcon: showError == true && valid == false
                                ? Stack(children: [
                                    IconButton(
                                        onPressed: () {
                                          print(showError);
                                          setState(() {
                                            if (showError == true) {
                                              showError = false;
                                            } else {
                                              showError = true;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.info_rounded,
                                          color: Colors.red[900],
                                        )),
                                  ])
                                : showError == false && valid == false
                                    ? IconButton(
                                        onPressed: () {
                                          print(showError);
                                          setState(() {
                                            if (showError == true) {
                                              showError = false;
                                            } else {
                                              showError = true;
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.info_rounded,
                                            color: Colors.red[900]))
                                    : showError == false && valid == true
                                        ? Icon(Icons.check, color: Colors.green)
                                        : null,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            labelText: "User name",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide <
                                            600
                                        ? 12
                                        : 23),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).errorColor),
                                borderRadius: BorderRadius.circular(5)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).errorColor),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      )),
                ),
                // Positioned(
                //   bottom: 30,
                //   child: Container(
                //     height: 20,
                //     width: MediaQuery.of(context).size.width - 150,
                //     color: Colors.red,
                //   ),
                // )
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
              } else {
                setState(() {
                  showError = true;
                  valid = false;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(9, 119, 190, 1),
                    Color.fromRGBO(21, 159, 224, 1)
                  ], end: Alignment.topCenter),
                  borderRadius: BorderRadius.circular(5)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.shortestSide < 600 ? 50 : 80,
              child: Center(
                child: Text(
                  "Check",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
