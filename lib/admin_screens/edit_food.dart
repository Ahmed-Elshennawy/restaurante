// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/widgets/reused.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/dark_theme_provider.dart';
import 'dart:io';

class EditFood extends StatefulWidget {
  const EditFood({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.time,
    required this.category,
    super.key,
  });

  final String image, name, detail, price, time, category;

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  List<String> items = ['Ice-cream', 'Burger', 'Salad', 'Pizza'];
  String? value;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  valueOfCategory() {
    switch (widget.category) {
      case '1':
        setState(() {
          value = 'Ice-cream';
        });
        break;
      case '2':
        setState(() {
          value = 'Burger';
        });
        break;
      case '3':
        setState(() {
          value = 'Salad';
        });
        break;
      case '4':
        setState(() {
          value = 'Pizza';
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.name;
    pricecontroller.text = widget.price;
    detailcontroller.text = widget.detail;
    timecontroller.text = widget.time;
    valueOfCategory();
    selectedImage = File(widget.image);
  }

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  var image;
  Crud crud = Crud();

  Future getImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  editItem() async {
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });

      var response = await crud.postRequestFile(
          linkitemEdit,
          {
            "item_name": namecontroller.text,
            "item_price": pricecontroller.text,
            "item_detail": detailcontroller.text,
            "item_category": (items.indexOf(value!) + 1).toString(),
            "item_time": timecontroller.text,
          },
          selectedImage!);

      if (response["status"] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("navigation", (route) => false);
      } else {
        // ignore: avoid_print
        print("failed to add item");
      }
    }
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
              GestureDetector(
                onTap: getImage,
                child: selectedImage == null
                    ? Center(
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
                      )
                    : Center(
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
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
                    style: TextStyle(
                      color:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                    ),
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
                    style: TextStyle(
                      color:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                    ),
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
              Text('Item Time',
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
                    controller: timecontroller,
                    style: TextStyle(
                      color:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Item Time',
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
                    style: TextStyle(
                      color:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                    ),
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
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: themeState.getDarkTheme
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        this.value = value;
                      }),
                      dropdownColor:
                          themeState.getDarkTheme ? Colors.black : Colors.white,
                      hint: const Text('Select Category'),
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      value: value,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await editItem();
                  },
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
                          'Edit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
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
