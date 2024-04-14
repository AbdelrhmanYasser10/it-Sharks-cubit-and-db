import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled6/database/db_helper.dart';
import 'package:untitled6/models/stock.dart';

part 'dismissed_state.dart';

class DismissedCubit extends Cubit<DismissedState> {
  DismissedCubit() : super(DismissedInitial());

  static DismissedCubit get(context)=>BlocProvider.of(context);


  void dismissAProduct({required int quantity , required int qrCode}) async{
    Map<String,dynamic> query = await DatabaseHelper.getOneQuery(codeId: qrCode);
    if(query.isEmpty){
      emit(QRCodeNotFound());
    }
    else{
      Stock temp = Stock.fromMap(query);
      if(quantity <= temp.quantity!){
        await DatabaseHelper.updateAndInsertNewDismissedValue(stock: temp, dismissedQuantity: quantity);
        emit(SellingSuccessfully());
      }
      else{
        emit(OverQuantity());
      }
    }
  }

}
