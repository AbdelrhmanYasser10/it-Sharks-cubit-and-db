import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:untitled6/cubits/dismissed_cubit/dismissed_cubit.dart";

import "../cubits/app_cubit/app_cubit.dart";

class DismissedScreen extends StatefulWidget {
  const DismissedScreen({Key? key}) : super(key: key);

  @override
  State<DismissedScreen> createState() => _DismissedScreenState();
}

class _DismissedScreenState extends State<DismissedScreen> {
  final TextEditingController _qrController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _qrController.dispose();
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DismissedCubit, DismissedState>(
      listener: (context, state) {
        if(state is QRCodeNotFound){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Code not founded"),
              backgroundColor: Colors.red,
            ),
          );
        }
        if(state is OverQuantity){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Too much quantity"),
              backgroundColor: Colors.red,
            ),
          );
        }
        if(state is SellingSuccessfully){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Sold Successfully"),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = DismissedCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                AppCubit.get(context).getAllData();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: const Text(
              "Selling Screen",
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _qrController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.qr_code,
                        ),
                        labelText: "Qr-Code",
                      ),
                      validator: (value) {
                        try {
                          int.parse(value!);
                          return null;
                        } catch (error) {
                          return "Please Enter an integer number";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.production_quantity_limits,
                        ),
                        labelText: "Quantity",
                      ),
                      validator: (value) {
                        try {
                          int newVal = int.parse(value!);
                          if (newVal <= 0) {
                            return "Invalid Quantity";
                          }
                          return null;
                        } catch (error) {
                          return "Please Enter an integer number";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          cubit.dismissAProduct(
                              quantity: int.parse(_quantityController.text),
                              qrCode: int.parse(_qrController.text),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 55.0),
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text(
                        "Sell",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
