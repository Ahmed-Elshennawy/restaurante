// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/admin_screens/edit_food.dart';
import 'package:restaurante/main.dart';
import 'package:restaurante/widgets/dark_theme_provider.dart';
import 'package:restaurante/widgets/reused.dart';

class AdminItemPage extends StatefulWidget {
  const AdminItemPage({super.key});

  @override
  State<AdminItemPage> createState() => _AdminItemPageState();
}

class _AdminItemPageState extends State<AdminItemPage> {
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

  deleteItem(String index) async {
    var response = await crud.postRequest(linkitemDelete, {
      "id": index,
    });

    if (response['status'] == 'success') {
      print("success");
    } else {
      print("fail");
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
              Row(
                children: [
                  Text(
                    'Restaurante',
                    style: themeState.getDarkTheme
                        ? AppWidget.titleNameDark()
                        : AppWidget.titleNameLight(),
                  ),
                  const Spacer(),
                  sharedPref.getString("email") == "admin@gmail.com"
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "home_admin", (route) => false);
                          },
                          child: Icon(
                            Icons.admin_panel_settings,
                            size: 40,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        )
                      : const Text(''),
                ],
              ),
              const SizedBox(height: 30.0),
              Text(
                'Edit Food',
                style: themeState.getDarkTheme
                    ? AppWidget.largeDark()
                    : AppWidget.largeLight(),
              ),
              Text(
                'Make Alters on Food.',
                style: themeState.getDarkTheme
                    ? AppWidget.infoDark()
                    : AppWidget.infoLight(),
              ),
              const SizedBox(height: 30.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryImages.entries.map((icon) {
                    final category = icon.key;
                    final imagePath = icon.value;
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
              ListView.builder(
                itemCount: selectedList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = selectedList[index];
                  return Dismissible(
                    key: Key(item['item_name']),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        deleteItem(item['id'].toString());
                        selectedList.removeAt(index);
                      });
                    },
                    direction: DismissDirection.endToStart,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditFood(
                              id: item['id'].toString(),
                              image: "$linkImageItemRoot/${item["item_image"]}",
                              name: item['item_name'],
                              detail: item['item_detail'],
                              price: item['item_price'].toString(),
                              time: item['item_time'].toString(),
                              category: item['item_category'].toString(),
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Column(
                            children: [
                              Material(
                                elevation: 5.0,
                                shadowColor: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            MediaQuery.of(context).size.width /
                                                2,
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
                                                  "${item['item_price'].toString()} \$",
                                                  style: themeState.getDarkTheme
                                                      ? AppWidget.platesDark()
                                                      : AppWidget.platesLight(),
                                                ),
                                                const SizedBox(width: 30),
                                                Text(
                                                  "${item['item_time'].toString()} mins",
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
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
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
