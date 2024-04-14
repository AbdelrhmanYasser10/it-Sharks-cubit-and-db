import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cubits/delete_cubit/delete_cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../cubits/app_cubit/app_cubit.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCubit, DeleteState>(
      listener: (context, state) {
        if (state is ThereIsNoCode) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This code doesn't exsist"),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is GetCodeFromDatabaseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is ThereIsCode) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Delete Recored',
            desc:
                'You are going to delete all records that contain this code Id',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              //Delete Logic
              DeleteCubit.get(context)
                  .deleteRecored(codeId: int.parse(_controller.text));
            },
          ).show();
        }
        if (state is DeletedSuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Deleted Successfully"),
              backgroundColor: Colors.green,
            ),
          );
        }
        if (state is DeletedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Some Error Occurred Try again later"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = DeleteCubit.get(context);
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
                  Form(
                    key: _formKey,
                    child: TextFormField(
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
                      validator: (value) {
                        try {
                          int.parse(value!);
                          return null;
                        } catch (error) {
                          return "Please Enter an integer number";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.checkCodeExsistance(
                            codeId: int.parse(_controller.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 55),
                        textStyle: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        )),
                    child: const Text(
                      "Delete",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
