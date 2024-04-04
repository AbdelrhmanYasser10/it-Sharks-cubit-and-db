import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import 'package:untitled6/cubits/app_cubit/app_cubit.dart';

class AddNewIncomingProduct extends StatefulWidget {
  const AddNewIncomingProduct({Key? key}) : super(key: key);

  @override
  State<AddNewIncomingProduct> createState() => _AddNewIncomingProductState();
}

class _AddNewIncomingProductState extends State<AddNewIncomingProduct> {

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getAllProductNames(query: "");
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
                if(state is GetNamesLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is GetNamesSuccessfully) {
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
                              child: Center(
                                child:
                                Text('${state.data[vicinity.row - 1].code}'),
                              ),
                            );
                          } else{
                            return TableViewCell(
                              child: Center(
                                child:
                                Text('${state.data[vicinity.row - 1].name}'),
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
                          extent:const FixedTableSpanExtent(50),
                          backgroundDecoration: TableSpanDecoration(
                            color: row.isEven
                                ? Colors.blueAccent[100]
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  );
                }
                else if(state is GetNamesSuccessError){
                  return Center(
                    child: Text(state.message),
                  );
                }
                else{
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
