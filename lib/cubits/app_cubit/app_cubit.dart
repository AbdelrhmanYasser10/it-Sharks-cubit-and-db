import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled6/database/db_helper.dart';

import '../../models/stock.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  // important
static AppCubit get(context)=> BlocProvider.of(context);

// get all data in database

void getAllData() async{
  emit(GetDataLoading());
  try {
    List<Map<String, dynamic>> list = await DatabaseHelper.getAllQueries();
    List<Stock> listOfData = [];
    for (var element in list) {
      listOfData.add(Stock.fromMap(element));
    }
    emit(GetDataSuccessfully(data: listOfData));
  }catch(error){
    emit(GetDataSuccessError(message: "Try again later"));
  }
}

}
