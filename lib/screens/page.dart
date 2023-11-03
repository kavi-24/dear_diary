import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageScreen extends StatefulWidget {
  final int day;
  final int month;
  final int year;
  const PageScreen(
      {super.key, required this.day, required this.month, required this.year});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  int lines = 10;

  @override
  void initState() {
    _textEditingController.text = "Dear diary, ";
    super.initState();
  }

  String getMonthName(int monthNumber) {
    return DateFormat.MMMM().format(DateTime(2023, monthNumber));
  }

  bool isAtLastLine(TextSelection selection) {
    final text = _textEditingController.text;
    final lastLinePosition = text.lastIndexOf('\n') + 1;
    return selection.baseOffset >= lastLinePosition &&
        selection.extentOffset >= lastLinePosition;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(175, 148, 111, 1),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      Text(
                        widget.day.toString(),
                        style: const TextStyle(
                          fontFamily: "BebasNeue",
                          fontSize: 22.5,
                        ),
                      ),
                      Text(
                        getMonthName(widget.month),
                        style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'GreatVibes',
                        ),
                      ),
                      Text(
                        widget.year.toString(),
                        style: const TextStyle(
                          fontFamily: "BebasNeue",
                          fontSize: 22.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Stack(
                  children: [
                    SizedBox(
                      height:
                          ((lines * 15) < MediaQuery.of(context).size.height)
                              ? MediaQuery.of(context).size.height
                              : (lines * 15),
                      child: ListView.builder(
                        itemBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Divider(
                            color: Colors.black,
                            height: 30,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(top: 5),
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 26,
                          fontStyle: FontStyle.italic,
                          height: 1.55,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.black,
                        controller: _textEditingController,
                        maxLines: lines,
                        onChanged: (value) {
                          final selection = _textEditingController.selection;
                          if (isAtLastLine(selection)) {
                            setState(() {
                              lines++;
                            });
                          }
                        },
                      ),
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
