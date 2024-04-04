import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import 'package:untitled6/cubits/app_cubit/app_cubit.dart';
import 'package:untitled6/cubits/incoming_cubit/incoming_cubit.dart';
import 'package:untitled6/screens/incoming_table_screen.dart';

import '../models/stock.dart';

class AddNewIncomingProduct extends StatefulWidget {
  const AddNewIncomingProduct({Key? key}) : super(key: key);

  @override
  State<AddNewIncomingProduct> createState() => _AddNewIncomingProductState();
}

class _AddNewIncomingProductState extends State<AddNewIncomingProduct> {
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Stock? stock;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getAllProductNames(query: "");
  }

  @override
  void deactivate() {
    super.deactivate();
    AppCubit.get(context).getAllData();
  }

  @override
  void dispose() {
    super.dispose();
    AppCubit.get(context).getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Add new product',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AppCubit.get(context).getAllData();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              IncomingCubit.get(context).getAllData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const IncomingTableScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.file_copy,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search_outlined,
                ),
                labelText: "Search Query",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              onChanged: (value) {
                AppCubit.get(context).getAllProductNames(query: value);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                print(state);
              },
              builder: (context, state) {
                var cubit = AppCubit.get(context);
                if (state is GetNamesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetNamesSuccessfully) {
                  print(state.data.length);
                  return Expanded(
                    child: TableView.builder(
                      cellBuilder:
                          (BuildContext context, TableVicinity vicinity) {
                        if (vicinity.row == 0) {
                          List<String> titles = [
                            "Code",
                            "Name",
                          ];
                          return TableViewCell(
                            child: Center(
                              child: Text(
                                titles[vicinity.column],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          );
                        } else {
                          if (vicinity.column == 0) {
                            return TableViewCell(
                              child: InkWell(
                                onTap: () {
                                  stock = state.data[vicinity.row - 1];
                                  setState(() {});
                                },
                                child: Center(
                                  child: Text(
                                      '${state.data[vicinity.row - 1].code}'),
                                ),
                              ),
                            );
                          } else {
                            return TableViewCell(
                              child: InkWell(
                                onTap: () {
                                  stock = state.data[vicinity.row - 1];
                                  setState(() {});
                                },
                                child: Center(
                                  child: Text(
                                      '${state.data[vicinity.row - 1].name}'),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      columnCount: 2,
                      columnBuilder: (int column) {
                        return const TableSpan(
                          extent: FixedTableSpanExtent(100),
                          foregroundDecoration: TableSpanDecoration(
                            border: TableSpanBorder(
                              trailing: BorderSide(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        );
                      },
                      rowCount: state.data.length + 1,
                      rowBuilder: (int row) {
                        return TableSpan(
                          extent: const FixedTableSpanExtent(50),
                          backgroundDecoration: TableSpanDecoration(
                            color: row.isEven
                                ? Colors.blueAccent[100]
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is GetNamesSuccessError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Scaffold(body: SizedBox.shrink());
                }
              },
            ),
            stock != null
                ? Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Name: ${stock!.name}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.numbers,
                            ),
                            labelText: "Quantity Value",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          controller: _quantityController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Quantity value cannot be empty";
                            } else if (int.parse(value) <= 0) {
                              return "Quantity cannot be 0 or negative value";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 20.0,
            ),
            BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state is InsertedSuccessfully) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Inserted successfully",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  AppCubit.get(context).getAllProductNames(query: "");
                  stock = null;
                  setState(() {});
                } else if (state is InsertedError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Error while inserting data , try again later",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  AppCubit.get(context).getAllProductNames(query: "");
                  setState(() {});
                }
              },
              builder: (context, state) {
                return state is InsertLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            print(_quantityController.text);
                            AppCubit.get(context).insertNewProductQuantity(
                              codeId: stock!.code,
                              quantity: int.parse(_quantityController.text),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
