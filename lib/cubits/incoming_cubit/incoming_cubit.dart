import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled6/models/incoming.dart';

import '../../database/db_helper.dart';

part 'incoming_state.dart';

class IncomingCubit extends Cubit<IncomingState> {
  IncomingCubit() : super(IncomingInitial());

  static IncomingCubit get(context)=>BlocProvider.of(context);


  void getAllData() async{
    emit(IncomingDataLoading());
    try {
      List<Map<String, dynamic>> list = await DatabaseHelper.getAllQueries(
          tableName: "Incoming"
      );
      List<Incoming> listOfData = [];
      for (var element in list) {
        listOfData.add(Incoming.fromMap(element));
      }
      emit(IncomingDataSuccessfully(data: listOfData));
    }catch(error){
      emit(IncomingDataError(message: error.toString()));
    }
  }


}
