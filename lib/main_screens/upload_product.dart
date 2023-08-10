import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_apps/utilities/categ_list.dart';
import 'package:multi_store_apps/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  _UploadProductScreenState createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  late String proId;
  bool processing = false;
  String mainCategoryValue = 'select category';
  String subCategValue = 'subcategory';

  List<String> subCategList = [];

  final ImagePicker _picker = ImagePicker();

  List<XFile>? imagesFileList = [];
  List<String> imageUrlList = [];
  dynamic _pickedImageError;

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesFileList = pickedImages!;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imagesFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imagesFileList![index].path));
          });
    } else {
      return Center(
        child: Text(
          'you have not \n \n picked images yet !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      );
    }
  }

  void selectedMainCateg(String? value) {
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'men') {
      subCategList = men;
    } else if (value == 'women') {
      subCategList = women;
    } else if (value == 'electronics') {
      subCategList = electronics;
    } else if (value == 'accessories') {
      subCategList = accessories;
    } else if (value == 'shoes') {
      subCategList = shoes;
    } else if (value == 'home & garden') {
      subCategList = homeandgarden;
    } else if (value == 'beauty') {
      subCategList = beauty;
    } else if (value == 'kids') {
      subCategList = kids;
    } else if (value == 'bags') {
      subCategList = bags;
    }
    print(value);

    setState(() {
      mainCategoryValue = value!;
      subCategValue = 'subcategory';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategoryValue != 'select category' &&
        subCategValue != 'subcategory') {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        if (imagesFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });

          try {
            for (var image in imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imageUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'please pick images first');
        }
      } else {
        MyMessageHandler.showSnackBar(
            _scaffoldkey, 'plrase fill alla the fields');
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldkey, 'please select categories');
    }
  }

  void uploadData() async {
    if (imageUrlList!.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');
      proId = Uuid().v4();

      await productRef.doc(proId).set({
        'proid': proId,
        'maincateg': mainCategoryValue,
        'subcateg': subCategValue,
        'price': price,
        'instock': quantity,
        'proname': proName,
        'prodesc': proDesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imageUrlList,
        'discount': 0,
      }).whenComplete(() {
        setState(() {
          processing = false;
          imagesFileList = [];
          mainCategoryValue = 'select category';
          subCategList = [];
          imageUrlList = [];
          _formkey.currentState!.reset();
        });
      });
    } else {
      print('no images');
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() => uploadData());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldkey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: Colors.blueGrey.shade100,
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: imagesFileList != null
                                  ? previewImages()
                                  : Center(
                                      child: Text(
                                        'you have not \n \n picked images yet !',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                            ),
                            imagesFileList!.isEmpty
                                ? SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        imagesFileList = [];
                                      });
                                    },
                                    icon: Icon(Icons.delete_forever)),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '* select main category',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  DropdownButton(
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      dropdownColor: Colors.yellow.shade400,
                                      value: mainCategoryValue,
                                      items: maincateg
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        selectedMainCateg(value);
                                      }),
                                ],
                              ),
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '* select subcategory',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      DropdownButton(
                                          iconSize: 40,
                                          iconEnabledColor: Colors.red,
                                          dropdownColor: Colors.yellow.shade400,
                                          iconDisabledColor: Colors.black,
                                          menuMaxHeight: 500,
                                          disabledHint:
                                              Text('select subcategory'),
                                          value: subCategValue,
                                          items: subCategList
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem(
                                              child: Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            print(value);
                                            setState(() {
                                              subCategValue = value!;
                                            });
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.yellow,
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter Price';
                              } else if (value.isValidPrice() != true) {
                                return 'invalid price';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              price = double.parse(value!);
                            },
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: textFormDecoration.copyWith(
                              labelText: 'price',
                              hintText: 'price .. \$',
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter Quantity';
                              } else if (value.isValidQuantity() != true) {
                                return 'not valid quantity';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              quantity = int.parse(value!);
                            },
                            keyboardType: TextInputType.number,
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Quantity',
                              hintText: 'Add Quantity',
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter product name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              proName = value!;
                            },
                            maxLength: 100,
                            maxLines: 3,
                            decoration: textFormDecoration.copyWith(
                              labelText: 'product name',
                              hintText: 'Enter product name',
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter product description';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              proDesc = value!;
                            },
                            maxLength: 800,
                            maxLines: 5,
                            decoration: textFormDecoration.copyWith(
                              labelText: 'product description',
                              hintText: 'Enter product description',
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // imagesFileList!.isEmpty
              //     ? SizedBox()
              //     : Padding(
              //         padding: const EdgeInsets.only(right: 10),
              //         child: FloatingActionButton(
              //           onPressed: () {
              //             setState(() {
              //               imagesFileList = [];
              //             });
              //           },
              //           backgroundColor: Colors.yellow,
              //           child: Icon(
              //             Icons.delete_forever,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                  onPressed: imagesFileList!.isEmpty
                      ? () {
                          pickProductImages();
                        }
                      : () {
                          setState(() {
                            imagesFileList = [];
                          });
                        },
                  backgroundColor: Colors.yellow,
                  child: imagesFileList!.isEmpty
                      ? Icon(
                          Icons.photo_library,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  uploadProduct();
                },
                backgroundColor: Colors.yellow,
                child: processing == true
                    ? CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.upload,
                        color: Colors.black,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price .. \$',
  labelStyle: TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellow, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellow, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.])||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
