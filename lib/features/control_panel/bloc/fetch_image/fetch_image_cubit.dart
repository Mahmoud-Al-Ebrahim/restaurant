import 'dart:io';
import 'package:bloc/bloc.dart';
import '../fetch_image/fetch_image_state.dart';
import 'package:image_picker/image_picker.dart';
XFile? _image;

class FetchImageCubit extends Cubit<FetchImageState> {
  FetchImageCubit() : super(FetchImageInitial());
  fetchImage()async
  {
    try{
      _image= await ImagePicker().pickImage(source: ImageSource.gallery);
      if(_image !=null)
        {
          emit(FetchImageDone(_image!));
        }
      else {
        emit(FetchImageInitial());
      }
    }
    catch(error)
    {
      emit(FetchImageInitial());
    }
  }
  removeImage(){
    _image=null;
    emit(FetchImageInitial());
  }
  XFile? get getFile=>_image;
}
