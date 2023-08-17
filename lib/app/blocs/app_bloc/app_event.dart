
import 'dart:io';

import 'package:equatable/equatable.dart';

 abstract class AppEvent extends Equatable{
}

class ChangeBasePage extends AppEvent {
  ChangeBasePage(this.index);

  final int index;

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
class DeleteTableEvent extends AppEvent {
  DeleteTableEvent(this.id);

  final String id;
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class EditTableEvent extends AppEvent {
  EditTableEvent(this.id,this.number);
  final String id;
  final String number;
  @override
  // TODO: implement props
  List<Object?> get props => [id,number];
}
class GetTablesEvent extends AppEvent {
  GetTablesEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AddTableEvent extends AppEvent {
  AddTableEvent(this.number );
  final String number;
  @override
  // TODO: implement props
  List<Object?> get props => [number];
}

class DeleteProductEvent extends AppEvent {
  DeleteProductEvent(this.id);

  final String id;
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class EditProductEvent extends AppEvent {
  EditProductEvent(this.id,this.number,this.name,this.type,this.image,this.price,this.photoPath);
  final String id;
  final String number,name,type,price;
  final File? image;
  final String? photoPath;

  @override
  // TODO: implement props
  List<Object?> get props => [id,number,name,type,image,price,photoPath];
}
class GetProductsEvent extends AppEvent {
  GetProductsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AddProductEvent extends AppEvent {
  AddProductEvent(this.number ,this.name,this.type,this.image,this.price);
  final String number,name,type,price;
  final File? image;
  @override
  // TODO: implement props
  List<Object?> get props => [number,name,type,image,price];
}

class AddOrderItemEvent extends AppEvent {
  AddOrderItemEvent(this.tableId ,this.productId,this.amount,this.notes);
  final int tableId,productId,amount;
  final String notes;
  @override
  // TODO: implement props
  List<Object?> get props => [tableId,productId,amount,notes];
}
class ChangeOrderItemQuantityEvent extends AppEvent {
  ChangeOrderItemQuantityEvent(this.tableId,this.productId,this.qty);
  final int tableId,productId,qty;
  @override
  // TODO: implement props
  List<Object?> get props => [tableId,qty,productId];
}
class RemoveOrderItemEvent extends AppEvent {
  RemoveOrderItemEvent(this.tableId,this.productId);
  final int tableId,productId;
  @override
  // TODO: implement props
  List<Object?> get props => [tableId , productId];
}

class CreateOrderEvent extends AppEvent {
  CreateOrderEvent(this.tableId);
  final int tableId;
  @override
  // TODO: implement props
  List<Object?> get props => [tableId];
}