
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';


abstract class FetchImageState extends Equatable {}

class FetchImageInitial extends FetchImageState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class FetchImageDone extends FetchImageState {
  final XFile imageUrl;
  FetchImageDone(this.imageUrl);
  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl];
}
