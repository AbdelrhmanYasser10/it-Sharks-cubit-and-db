import 'package:flutter/material.dart';


class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Delete Product",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 64.0,
                  ),
                  Text(
                    "Make sure to enter an exsistant Code",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "the product will be deleted from all recores",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
                  ),
                  labelText: "Code Id",
                ),
                validator: (value){
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(
                     double.infinity ,
                    55
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )
                ),
                  child: const Text(
                    "Delete",
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
