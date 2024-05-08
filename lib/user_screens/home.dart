import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/components/edit_theme.dart';
import 'package:restaurante/widgets/dark_theme_provider.dart';
import 'package:restaurante/widgets/reused.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? selectedOurCategory;
  List<dynamic> selectedList = [];
  List<dynamic> ourpizza = [];
  List<dynamic> ourburger = [];
  List<dynamic> ouricecream = [];
  List<dynamic> oursalad = [];
  final Map<int, String> categoryImages = {
    4: 'images/pizza.png',
    2: 'images/burger.png',
    3: 'images/salad.png',
    1: 'images/ice-cream.png',
  };
  Crud crud = Crud();

  @override
  void initState() {
    super.initState();
    getItem();
  }

  void categorizeItems() {
    for (var element in selectedList) {
      switch (element['item_category']) {
        case 1:
          ouricecream.add(element);
          break;
        case 2:
          ourburger.add(element);
          break;
        case 3:
          oursalad.add(element);
          break;
        case 4:
          ourpizza.add(element);
          break;
      }
    }
  }

  Future<void> getItem() async {
    var response = await crud.getRequest(linkitemView);
    if (response['status'] == 'success') {
      setState(() {
        selectedList = response['data'];
      });
      categorizeItems();
    }
  }

  void updateSelectedList(int category) {
    switch (category) {
      case 1:
        setState(() {
          selectedList = ouricecream;
        });
        break;
      case 2:
        setState(() {
          selectedList = ourburger;
        });
        break;
      case 3:
        setState(() {
          selectedList = oursalad;
        });
        break;
      case 4:
        setState(() {
          selectedList = ourpizza;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restaurante',
                style: themeState.getDarkTheme
                    ? AppWidget.titleNameDark()
                    : AppWidget.titleNameLight(),
              ),
              const SizedBox(height: 20.0),
              Material(
                elevation: 10.0,
                shadowColor:
                    themeState.getDarkTheme ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color:
                        themeState.getDarkTheme ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SwitchListTile(
                    onChanged: (bool value) {
                      themeState.setDarkTheme = value;
                      editTheme(value);
                    },
                    value: themeState.getDarkTheme,
                    title: Text(
                      'Dark Mode',
                      style: themeState.getDarkTheme
                          ? AppWidget.platesDark()
                          : AppWidget.platesLight(),
                    ),
                    secondary: themeState.getDarkTheme
                        ? const Icon(Icons.light_mode_outlined,
                            color: Colors.white)
                        : const Icon(Icons.dark_mode_outlined,
                            color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Our Food',
                style: themeState.getDarkTheme
                    ? AppWidget.largeDark()
                    : AppWidget.largeLight(),
              ),
              Text(
                'Enjoy Our Delicious Food',
                style: themeState.getDarkTheme
                    ? AppWidget.infoDark()
                    : AppWidget.infoLight(),
              ),
              const SizedBox(height: 15.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: categoryImages.entries.map((entry) {
                    final category = entry.key;
                    final imagePath = entry.value;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOurCategory = category;
                        });
                        updateSelectedList(category);
                      },
                      child: Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedOurCategory == category
                                    ? Colors.black
                                    : Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                imagePath,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                color: selectedOurCategory == category
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                itemCount: selectedList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = selectedList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            image: "$linkImageItemRoot/${item["item_image"]}",
                            name: item['item_name'],
                            detail: item['item_detail'],
                            price: item['item_price'].toString(),
                            time: item['item_time'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Material(
                          elevation: 10.0,
                          shadowColor: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        "$linkImageItemRoot/${item["item_image"]}",
                                        height: 105.0,
                                        width: 105.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 15.0),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['item_name'],
                                            style: themeState.getDarkTheme
                                                ? AppWidget.platesDark()
                                                : AppWidget.platesLight(),
                                          ),
                                          Text(
                                            item['item_detail'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: themeState.getDarkTheme
                                                ? AppWidget.infoDark()
                                                : AppWidget.infoLight(),
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Text(
                                                "${item['item_time'].toString()} \$",
                                                style: themeState.getDarkTheme
                                                    ? AppWidget.platesDark()
                                                    : AppWidget.platesLight(),
                                              ),
                                              const SizedBox(width: 30),
                                              Text(
                                                "${item['item_price'].toString()} mins",
                                                style: themeState.getDarkTheme
                                                    ? AppWidget.platesDark()
                                                    : AppWidget.platesLight(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
