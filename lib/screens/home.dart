import 'package:dear_diary/screens/page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FixedExtentScrollController _dayController =
      FixedExtentScrollController();
  final FixedExtentScrollController _monthController =
      FixedExtentScrollController();
  final FixedExtentScrollController _yearController =
      FixedExtentScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _dayController.jumpToItem(DateTime.now().day - 1);
      _monthController.jumpToItem(DateTime.now().month - 1);
      _yearController.jumpToItem(DateTime.now().year - 1950);
    });
    super.initState();
  }

  int getDays(int month) {
    if (month == 2) {
      return 28;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    } else {
      return 31;
    }
  }

  int getDaysCount(int month, int year) {
    if (month == DateTime.now().month && year == DateTime.now().year) {
      if (_dayController.selectedItem + 1 > DateTime.now().day) {
        _dayController.jumpToItem(DateTime.now().day - 1);
      }
      return DateTime.now().day;
    } else {
      return getDays(month);
    }
  }

  int getMonthsCount(int year) {
    if (year == DateTime.now().year) {
      return DateTime.now().month;
    } else {
      return 12;
    }
  }

  String getMonthName(int monthNumber) {
    return DateFormat.MMMM()
        .format(DateTime(2023, monthNumber))
        .substring(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(175, 148, 111, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 70,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) => setState(() {}),
                          controller: _dayController,
                          diameterRatio: 1.5,
                          perspective: 0.005,
                          itemExtent: 75,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: _monthController.hasClients
                                ? getDaysCount(
                                    _monthController.selectedItem + 1,
                                    _yearController.selectedItem + 1950 + 1,
                                  )
                                : 31,
                            builder: (context, index) {
                              return Item(
                                item: index + 1,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 70,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) => setState(() {}),
                          controller: _monthController,
                          diameterRatio: 1.5,
                          perspective: 0.005,
                          itemExtent: 80,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: _yearController.hasClients
                                ? getMonthsCount(
                                    _yearController.selectedItem + 1950 + 1,
                                  )
                                : 12,
                            builder: (context, index) {
                              return Item(
                                item: getMonthName(index + 1),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 120,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) => setState(() {}),
                          controller: _yearController,
                          diameterRatio: 1.5,
                          perspective: 0.005,
                          itemExtent: 75,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: DateTime.now().year - 1950,
                            builder: (context, index) {
                              return Item(
                                item: index + 1950 + 1,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageScreen(
                        day: _dayController.selectedItem + 1,
                        month: _monthController.selectedItem + 1,
                        year: _yearController.selectedItem + 1950 + 1,
                      ),
                    ),
                  );
                },
                child: Text(
                  _dayController.hasClients &&
                          _monthController.hasClients &&
                          _yearController.hasClients
                      ? "Go to ${_dayController.selectedItem + 1}/${_monthController.selectedItem + 1}/${_yearController.selectedItem + 1950 + 1}"
                      : "...",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final dynamic item; // int or str

  const Item({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: item is int ? 5.0 : 7.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white),
          ),
        ),
        child: Center(
          child: Text(
            item.toString(),
            style: TextStyle(
              fontSize: item is int ? 40 : 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
