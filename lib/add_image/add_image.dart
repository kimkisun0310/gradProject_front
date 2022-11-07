import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {


  void _pickImage() async{
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 150,
      height: 280,
      child: Column(
        children: [
          SizedBox(height: 10,),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 15,),
          OutlinedButton.icon(
            onPressed: (){
              _pickImage();
            },
            icon: Icon(Icons.image),
            label: Text('Add image'),
          ),
          SizedBox(height: 30,),
          TextButton.icon(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('Close'),
          ),
        ],
      ),
    );
  }
}
