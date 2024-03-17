import 'package:restaurante/widgets/reused.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/dark_theme_provider.dart';
import 'dart:io';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  List<String> items = ['Ice-cream', 'Burger', 'Salad', 'Pizza'];
  String? value;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        shadowColor: themeState.getDarkTheme ? Colors.white : Colors.black,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff373866),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add Item',
          style: themeState.getDarkTheme
              ? AppWidget.largeDark()
              : AppWidget.largeLight(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              left: 20.0, top: 20.0, right: 20.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload the Item Picture',
                style: themeState.getDarkTheme
                    ? AppWidget.platesDark()
                    : AppWidget.platesLight(),
              ),
              const SizedBox(height: 20.0),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Material(
                          elevation: 6.0,
                          shadowColor: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 30.0),
              Text('Item Name',
                  style: themeState.getDarkTheme
                      ? AppWidget.platesDark()
                      : AppWidget.platesLight()),
              const SizedBox(height: 10.0),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor:
                    themeState.getDarkTheme ? Colors.white : Colors.black,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:
                        themeState.getDarkTheme ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Item Name',
                      hintStyle: themeState.getDarkTheme
                          ? AppWidget.infoDark()
                          : AppWidget.infoLight(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Text('Item Price',
                  style: themeState.getDarkTheme
                      ? AppWidget.platesDark()
                      : AppWidget.platesLight()),
              const SizedBox(height: 10.0),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor:
                    themeState.getDarkTheme ? Colors.white : Colors.black,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:
                        themeState.getDarkTheme ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: pricecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Item Price',
                      hintStyle: themeState.getDarkTheme
                          ? AppWidget.infoDark()
                          : AppWidget.infoLight(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Text('Item Detail',
                  style: themeState.getDarkTheme
                      ? AppWidget.platesDark()
                      : AppWidget.platesLight()),
              const SizedBox(height: 10.0),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor:
                    themeState.getDarkTheme ? Colors.white : Colors.black,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:
                        themeState.getDarkTheme ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    maxLines: 6,
                    controller: detailcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Item Detail',
                      hintStyle: themeState.getDarkTheme
                          ? AppWidget.infoDark()
                          : AppWidget.infoLight(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Text('Select Category',
                  style: themeState.getDarkTheme
                      ? AppWidget.platesDark()
                      : AppWidget.platesLight()),
              const SizedBox(height: 10.0),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor:
                    themeState.getDarkTheme ? Colors.white : Colors.black,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  decoration: BoxDecoration(
                      color:
                          themeState.getDarkTheme ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      items: items
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        this.value = value;
                      }),
                      dropdownColor: Colors.white,
                      hint: const Text('Select Category'),
                      iconSize: 36,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      value: value,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: Material(
                  elevation: 150,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black,
                        )),
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
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
