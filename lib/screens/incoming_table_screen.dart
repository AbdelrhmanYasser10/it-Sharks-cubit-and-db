import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import 'package:untitled6/cubits/incoming_cubit/incoming_cubit.dart';

class IncomingTableScreen extends StatelessWidget {
  const IncomingTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomingCubit, IncomingState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is IncomingDataLoading){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else if(state is IncomingDataSuccessfully) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: const Text(
                'Incoming Table',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            body: TableView.builder(
              cellBuilder:
                  (BuildContext context, TableVicinity vicinity) {
                if (vicinity.row == 0) {
                  List<String> titles = [
                    "id",
                    "Code ID",
                    "Quantity",
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
                        child: Text(
                            '${state.data[vicinity.row - 1].id}'),
                      ),
                    );
                  } else if(vicinity.column == 1){
                    return TableViewCell(
                      child: Center(
                        child: Text(
                            '${state.data[vicinity.row - 1].codeId}'),
                      ),
                    );
                  }
                  else
                  {
                    return TableViewCell(
                      child: Center(
                        child: Text(
                            '${state.data[vicinity.row - 1].quantity}'),
                      ),
                    );
                  }
                }
              },
              columnCount: 3,
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
        }
        else if (state is IncomingDataError){
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
              ),
            ),
          );
        }
        else{
          return const SizedBox.shrink();
        }
      },
    );
  }
}
