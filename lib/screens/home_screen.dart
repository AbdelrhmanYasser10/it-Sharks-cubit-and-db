import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import 'package:untitled6/cubits/app_cubit/app_cubit.dart';
import 'package:untitled6/screens/add_new_incoming_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetDataLoading) {
          // Loading shape
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is GetDataSuccessfully) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: const Text(
                'Database viewer',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: TableView.builder(
                    cellBuilder:
                        (BuildContext context, TableVicinity vicinity) {
                      if (vicinity.row == 0) {
                        List<String> titles = [
                          "Code",
                          "Name",
                          "Type",
                          "Quantity",
                          "Unit",
                          "QR-cde"
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
                        //0
                        //1
                        //2
                        //3
                        if (vicinity.column == 0) {
                          return TableViewCell(
                            child: Center(
                              child:
                                  Text('${state.data[vicinity.row - 1].code}'),
                            ),
                          );
                        } else if (vicinity.column == 1) {
                          return TableViewCell(
                            child: Center(
                              child:
                                  Text('${state.data[vicinity.row - 1].name}'),
                            ),
                          );
                        } else if (vicinity.column == 2) {
                          return TableViewCell(
                            child: Center(
                              child:
                                  Text('${state.data[vicinity.row - 1].type}'),
                            ),
                          );
                        } else if (vicinity.column == 3) {
                          return TableViewCell(
                            child: Center(
                              child: Text(
                                  '${state.data[vicinity.row - 1].quantity}'),
                            ),
                          );
                        } else if (vicinity.column == 4) {
                          return TableViewCell(
                            child: Center(
                              child:
                                  Text('${state.data[vicinity.row - 1].unit}'),
                            ),
                          );
                        } else {
                          return TableViewCell(
                            child: Center(
                              child: Text('${state.data[vicinity.row - 1].qr}'),
                            ),
                          );
                        }
                      }
                    },
                    columnCount: 6,
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
                        extent: FixedTableSpanExtent(50),
                        backgroundDecoration: TableSpanDecoration(
                          color: row.isEven
                              ? Colors.blueAccent[100]
                              : Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddNewIncomingProduct(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Incoming',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text(
                        'Dismissed',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Delete',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is GetDataSuccessError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        }
        // Impossible condition
        else {
          return const Scaffold(body:  SizedBox.shrink());
        }
      },
    );
  }
}
