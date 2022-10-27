import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ImagePicker imagePicker = ImagePicker();

  String imagepath = "";  //  for the path of my image
  String base64String = "";    //  data in the form of String

  //  a function for image encoding and decoding

  openImage() async{
    try{
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        imagepath = pickedFile.path;
        print(imagepath); // /data/user/0/com.example.imagedecoding/cache/image_picker4858479242096916017.png

        // now convert it into a file and then numbers or bytes
        File imagefile = File(imagepath);
        // now converting into numbers

        Uint8List imagebytes = await imagefile.readAsBytes();
        print(imagebytes);  // 38439849384

        // now convert it into string
        base64String = base64.encode(imagebytes);  // asdfjaklsdfjl//asdfasd348309
        print(base64String);

        // now we can save it into database
      }else{
        print('No image is selected');
      }
    }catch(e){
      print('No image is selected');
    }
  }

  Widget showImage(BuildContext context){
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(image: MemoryImage(base64Decode(base64String)))
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image enconding or decoding'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imagepath != "" ? Image.file(File(imagepath)) : Container(child: Text('No image selected'),),
            ElevatedButton(onPressed: (){
              openImage();
              },
                child: Text('Select Image')),
            Text('Decoded image'),
            imagepath != "" ? showImage(context):  Container(child: Text('No image selected'),),
          ],
        ),
      ),
    );
  }
}
