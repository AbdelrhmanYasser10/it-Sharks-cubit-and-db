import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled6/database/db_helper.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteInitial());

  //
  static DeleteCubit get(context)=>BlocProvider.of(context);


  void checkCodeExsistance({required int codeId})async{
    emit(GetCodeFromDatabaseLoading());

    try {
      final Map<String, dynamic> result = await DatabaseHelper.getOneQuery(
          codeId: codeId);
      if (result.isEmpty) {
        emit(ThereIsNoCode());
      }
      else {
        emit(ThereIsCode());
      }
    }catch(error){
      emit(GetCodeFromDatabaseError(message: "Error occurred try again later"));
    }


  }

  void deleteRecored({required int codeId})async{
    try {
      DatabaseHelper.deleteQuery(code: codeId);
      emit(DeletedSuccessfully());
    }catch(error){
      emit(DeletedError());
    }
  }

}
