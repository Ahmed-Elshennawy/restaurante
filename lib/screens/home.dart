import 'package:restaurante/widgets/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> selectedList = [];
    final themeState = Provider.of<DarkThemeProvider>(context);

    switch (selectedCategory) {
      case 'burger':
        selectedList = DummyData.burgerList;
        break;
      case 'ice':
        selectedList = DummyData.iceList;
        break;
      case 'salad':
        selectedList = DummyData.saladList;
        break;
      default:
        selectedList = DummyData.pizzaList;
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
                  children: selectedList.map(
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                image: DummyData.saladList[0]['image'],
                                name: DummyData.saladList[0]['name'],
                                detail: DummyData.saladList[0]['detail'],
                                price: DummyData.saladList[0]['price'],
                                time: DummyData.saladList[0]['time'],
                              )));
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
                                  DummyData.saladList[0]['image'],
                                  height: 105.0,
                                  width: 105.0,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 15.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DummyData.saladList[0]['name'],
                                    style: themeState.getDarkTheme
                                        ? AppWidget.platesDark()
                                        : AppWidget.platesLight(),
                                  ),
                                  Text(
                                    DummyData.saladList[0]['detail'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: themeState.getDarkTheme
                                        ? AppWidget.infoDark()
                                        : AppWidget.infoLight(),
                                  ),
                                  Text(
                                    DummyData.saladList[0]['price'],
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
              ),
              const SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                image: DummyData
                                        .pizzaList[DummyData.iceList.length - 1]
                                    ['image'],
                                name: DummyData
                                        .pizzaList[DummyData.iceList.length - 1]
                                    ['name'],
                                detail: DummyData
                                        .pizzaList[DummyData.iceList.length - 1]
                                    ['detail'],
                                price: DummyData
                                        .pizzaList[DummyData.iceList.length - 1]
                                    ['price'],
                                time: DummyData
                                        .pizzaList[DummyData.iceList.length - 1]
                                    ['time'],
                              )));
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
                                  DummyData.pizzaList[
                                      DummyData.iceList.length - 1]['image'],
                                  height: 105.0,
                                  width: 105.0,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 15.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DummyData.pizzaList[
                                        DummyData.iceList.length - 1]['name'],
                                    style: themeState.getDarkTheme
                                        ? AppWidget.platesDark()
                                        : AppWidget.platesLight(),
                                  ),
                                  Text(
                                    DummyData.pizzaList[
                                        DummyData.iceList.length - 1]['detail'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: themeState.getDarkTheme
                                        ? AppWidget.platesDark()
                                        : AppWidget.platesLight(),
                                  ),
                                  Text(
                                    DummyData.pizzaList[
                                        DummyData.iceList.length - 1]['price'],
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
              ),
              const SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                image: DummyData.burgerList[
                                    DummyData.burgerList.length - 1]['image'],
                                name: DummyData.burgerList[
                                    DummyData.burgerList.length - 1]['name'],
                                detail: DummyData.burgerList[
                                    DummyData.burgerList.length - 1]['detail'],
                                price: DummyData.burgerList[
                                    DummyData.burgerList.length - 1]['price'],
                                time: DummyData.burgerList[
                                    DummyData.burgerList.length - 1]['time'],
                              )));
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
                                  DummyData.burgerList[
                                      DummyData.burgerList.length - 1]['image'],
                                  height: 105.0,
                                  width: 105.0,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 15.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DummyData.burgerList[
                                            DummyData.burgerList.length - 1]
                                        ['name'],
                                    style: themeState.getDarkTheme
                                        ? AppWidget.platesDark()
                                        : AppWidget.platesLight(),
                                  ),
                                  Text(
                                    DummyData.burgerList[
                                            DummyData.burgerList.length - 1]
                                        ['detail'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: themeState.getDarkTheme
                                        ? AppWidget.infoDark()
                                        : AppWidget.infoLight(),
                                  ),
                                  Text(
                                    DummyData.burgerList[
                                            DummyData.burgerList.length - 1]
                                        ['price'],
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
              ),
              const SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                image: DummyData
                                        .iceList[DummyData.iceList.length - 1]
                                    ['image'],
                                name: DummyData
                                        .iceList[DummyData.iceList.length - 1]
                                    ['name'],
                                detail: DummyData
                                        .iceList[DummyData.iceList.length - 1]
                                    ['detail'],
                                price: DummyData
                                        .iceList[DummyData.iceList.length - 1]
                                    ['price'],
                                time: DummyData
                                        .iceList[DummyData.iceList.length - 1]
                                    ['time'],
                              )));
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
                                  DummyData
                                          .iceList[DummyData.iceList.length - 1]
                                      ['image'],
                                  height: 105.0,
                                  width: 105.0,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 15.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DummyData.iceList[
                                        DummyData.iceList.length - 1]['name'],
                                    style: themeState.getDarkTheme
                                        ? AppWidget.platesDark()
                                        : AppWidget.platesLight(),
                                  ),
                                  Text(
                                    DummyData.iceList[
                                        DummyData.iceList.length - 1]['detail'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: themeState.getDarkTheme
                                        ? AppWidget.infoDark()
                                        : AppWidget.infoLight(),
                                  ),
                                  Text(
                                    DummyData.iceList[
                                        DummyData.iceList.length - 1]['price'],
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
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
