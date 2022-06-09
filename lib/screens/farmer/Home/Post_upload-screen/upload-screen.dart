import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'package:image_picker/image_picker.dart';

class UploadProductForm extends StatefulWidget {



  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}


class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _productTitle = '';
  var _productCategory = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  String? _categoryValue;
  bool isloading = false;
  String? url;
  var uuid = Uuid();

  File? _pickedImage;

  showAlertDialog(BuildContext context, String title, String body) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void _trySubmit() async {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == null) {
      _formKey.currentState!.save();
      print(_productTitle);
      print(_productCategory);
      print(_productDescription);
      print(_productQuantity);
      // Use those values to send our auth request ...
    }

    if (isValid!) {
      _formKey.currentState!.save();
      try {
        if (_pickedImage == null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Text('Please pick an Image'),
                );
              });
        } else {
          setState(() {
            isloading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('productImages')
              .child(_productTitle + '.jpg');
          await ref.putFile(_pickedImage!);
          url = await ref.getDownloadURL();

          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          final productId = uuid.v4();

          await FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .set({
            'productId': productId,
            'productTitle': _productTitle,
            'productQuantity': _productQuantity,
            'image': url,
            'productCategory': _productCategory,
            'productDescription': _productDescription,
            'isPopular': true,
            'joined': DateTime.now(),
            'created': Timestamp.now(),
          });
        }
      } catch (error) {
        showDialog(
            context: context,
            builder: (
                BuildContext context,
                ) {
              return AlertDialog(content: Text('error occured${error}'));
            });
      } finally {
        setState(() {
          isloading = false;
        });
      }
    }
  }




  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEAEED7),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: TextFormField(
                            key: const ValueKey('Title'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Name';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Product Name',
                            ),
                            onSaved: (value) {
                              _productTitle = value.toString();
                            } ),
                        ),
                        const SizedBox(height: 20),
                        /* Image picker here ***********************************/
                        Center(
                          child: Expanded(
                            //  flex: 2,
                            child: this._pickedImage == null
                                ? Container(
                                    margin: EdgeInsets.all(10),
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(4),
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.all(10),
                                    height: 250,
                                    width: 250,
                                    child: Container(
                                      height: 200,
                                      // width: 200,
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.only(
                                        //   topLeft: const Radius.circular(40.0),
                                        // ),
                                        color: Theme.of(context).backgroundColor,
                                      ),
                                      child: Image.file(
                                        this._pickedImage!,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FittedBox(
                              child: FlatButton.icon(
                                textColor: Colors.white,
                                onPressed: _pickImageCamera,
                                icon: Icon(Icons.camera, color: Colors.green),
                                label: Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).textSelectionColor,
                                  ),
                                ),
                              ),
                            ),
                            FittedBox(
                              child: FlatButton.icon(
                                textColor: Colors.white,
                                onPressed: _pickImageGallery,
                                icon: Icon(Icons.image, color: Colors.green),
                                label: Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).textSelectionColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: FittedBox(
                            child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: _removeImage,
                              icon: const Icon(
                                Icons.remove_circle_rounded,
                                color: Colors.red,
                              ),
                              label: const Text(
                                'Remove',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ),

                        //    SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    controller: _categoryController,

                                    key: ValueKey('Category'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Category';
                                      }
                                      return null;
                                    },
                                    //keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      labelText: 'Add a new Category',
                                    ),
                                    onSaved: (value) {
                                       _productCategory = value.toString();
                                     },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Vegetables',
                                  child: Text('Vegetables'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Rice',
                                  child: Text('Rice'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Coconut',
                                  child: Text('Coconut'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Spices',
                                  child: Text('Spices'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Aloe Vera',
                                  child: Text('Aloe Vera'),
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _categoryValue = value;
                                  _categoryController.text = value.toString();
                                  //_controller.text= _productCategory;
                                  print(_productCategory);
                                });
                              },
                              hint: Text('Select a Category'),
                              value: _categoryValue,
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        TextFormField(
                            key:  ValueKey('Description'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'product description is required';
                              }
                              return null;
                            },

                            //controller: this._controller,
                            maxLines: 8,
                            textCapitalization: TextCapitalization.sentences,
                            decoration:  const InputDecoration(
                              //  counterText: charLength.toString(),
                              labelText: 'Description',
                              hintText: 'Product description',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _productDescription = value.toString();
                            },
                            onChanged: (text) {
                              // setState(() => charLength -= text.length);
                            }),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:  const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  key: ValueKey('Quantity'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Quantity is missed';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                  ),
                                  onSaved: (value) {
                                    _productQuantity = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: _trySubmit,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Upload",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
