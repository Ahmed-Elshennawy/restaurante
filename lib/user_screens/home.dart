import 'package:restaurante/ApiFiles/apiLink.dart';
import 'package:restaurante/widgets/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ApiFiles/crud.dart';
import '../widgets/dummy_data.dart';
import '../widgets/reused.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool burger = false, pizza = false, ice = false, salad = false;
  String? selectedCategory;
  List<dynamic> selectedList = [];
  List<dynamic> selectedList2 = [];
  Crud crud = Crud();

  @override
  void initState() {
    super.initState();
    getItem();
  }

  getItem() async {
    var response = await crud.getRequest(linkitemView);
    if (response['status'] == 'success') {
      setState(() {
        selectedList = response['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    switch (selectedCategory) {
      case 'burger':
        selectedList2 = DummyData.burgerList;
        break;
      case 'ice':
        selectedList2 = DummyData.iceList;
        break;
      case 'salad':
        selectedList2 = DummyData.saladList;
        break;
      default:
        selectedList2 = DummyData.pizzaList;
        break;
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Restaurante',
                  style: themeState.getDarkTheme
                      ? AppWidget.titleNameDark()
                      : AppWidget.titleNameLight()),
              const SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 5.0,
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
                          : const Icon(
                              Icons.dark_mode_outlined,
                              color: Colors.black,
                            )),
                ),
              ),
              const SizedBox(height: 20.0),
              Text('Our Food',
                  style: themeState.getDarkTheme
                      ? AppWidget.largeDark()
                      : AppWidget.largeLight()),
              Text('Enjoy and Get Delicious Food',
                  style: themeState.getDarkTheme
                      ? AppWidget.infoDark()
                      : AppWidget.infoLight()),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'burger';
                      });
                    },
                    child: Material(
                      elevation: 6.0,
                      shadowColor:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCategory == 'burger'
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'images/burger.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: selectedCategory == 'burger'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'pizza';
                      });
                    },
                    child: Material(
                      elevation: 6.0,
                      shadowColor:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCategory == 'pizza'
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'images/pizza.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: selectedCategory == 'pizza'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'ice';
                      });
                    },
                    child: Material(
                      elevation: 6.0,
                      shadowColor:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCategory == 'ice'
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'images/ice-cream.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: selectedCategory == 'ice'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'salad';
                      });
                    },
                    child: Material(
                      elevation: 6.0,
                      shadowColor:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCategory == 'salad'
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'images/salad.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: selectedCategory == 'salad'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: selectedList2.map(
                    (item) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                        image: item['image'],
                                        name: item['name'],
                                        detail: item['detail'],
                                        price: item['price'],
                                        time: item['time'],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            elevation: 6,
                            shadowColor: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(item['image'],
                                        height: 110.0,
                                        width: 150.0,
                                        fit: BoxFit.cover),
                                  ),
                                  Text(item['name'],
                                      style: themeState.getDarkTheme
                                          ? AppWidget.platesDark()
                                          : AppWidget.platesLight()),
                                  Text(item['detail'],
                                      style: themeState.getDarkTheme
                                          ? AppWidget.infoDark()
                                          : AppWidget.infoLight()),
                                  Text(item['price'],
                                      style: themeState.getDarkTheme
                                          ? AppWidget.platesDark()
                                          : AppWidget.platesLight()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(height: 15.0),
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
                    child: Material(
                      elevation: 6,
                      shadowColor:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
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
                                  width: MediaQuery.of(context).size.width / 2,
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
                                      Text(
                                        item['item_price'].toString(),
                                        style: themeState.getDarkTheme
                                            ? AppWidget.platesDark()
                                            : AppWidget.platesLight(),
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
