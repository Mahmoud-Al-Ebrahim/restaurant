import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mime_type/mime_type.dart';
import 'package:restaurant/common/constant/configuration/url_routes.dart';
import 'package:restaurant/models/products_model.dart';
import 'package:restaurant/models/tables_model.dart';
import 'app_event.dart';
import 'app_state.dart';
import 'package:http_parser/http_parser.dart';

@LazySingleton()
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(AppState(
          currentIndex: 0,
        )) {
    on<AppEvent>((event, emit) {});
    on<ChangeBasePage>(_onChangeBasePage);
    on<GetTablesEvent>(_onGetTablesEvent);
    on<AddTableEvent>(_onAddTableEvent);
    on<DeleteTableEvent>(_onDeleteTableEvent);
    on<EditTableEvent>(_onEditTableEvent);


    on<GetProductsEvent>(_onGetProductsEvent);
    on<AddProductEvent>(_onAddProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
    on<EditProductEvent>(_onEditProductEvent);


    on<AddOrderItemEvent>(_onAddOrderItemEvent);
    on<ChangeOrderItemQuantityEvent>(_onChangeOrderItemQuantityEvent);
    on<RemoveOrderItemEvent>(_onRemoveOrderItemEvent);
    on<CreateOrderEvent>(_onCreateOrderEvent);
  }

  Dio dio = GetIt.I<Dio>();

  _onChangeBasePage(
    ChangeBasePage event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));
  }

  FutureOr<void> _onGetTablesEvent(
      GetTablesEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(getTablesStatus: GetTablesStatus.loading));
    await dio.getUri(getRequestUri(EndPoints.getTables)).then((value) {
      TablesModel tablesModel = TablesModel.fromJson(value.data);
      emit(state.copyWith(
          getTablesStatus: GetTablesStatus.success,
          tables: tablesModel.tables));
      emit(state.copyWith(getTablesStatus: GetTablesStatus.init));
    }).catchError((error) {
      emit(state.copyWith(getTablesStatus: GetTablesStatus.failure));
    });
  }

  FutureOr<void> _onAddTableEvent(
      AddTableEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(addTableStatus: AddTableStatus.loading));
    await dio.postUri(getRequestUri(EndPoints.addTables), data: {
      "number": event.number,
      "name":'test',
      "location": 'testttt'
    }).then((value) {
      Table table = Table.fromJson(value.data['data']);
      List<Table> tables = List.of(state.tables);
      tables.add(table);
      emit(state.copyWith(addTableStatus: AddTableStatus.success, tables: tables));
      emit(state.copyWith(addTableStatus: AddTableStatus.init));
    }).catchError((error) {
      emit(state.copyWith(addTableStatus: AddTableStatus.failure));
    });
  }

  FutureOr<void> _onDeleteTableEvent(
      DeleteTableEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(deleteTableStatus: DeleteTableStatus.loading));
    await dio.deleteUri(getRequestUri(EndPoints.deleteTable(event.id.toString()))).then((value) {
      List<Table> tables = List.of(state.tables);
      tables.removeWhere((element) => element.id.toString() == event.id);
      emit(state.copyWith(deleteTableStatus: DeleteTableStatus.success, tables: tables));
      emit(state.copyWith(deleteTableStatus: DeleteTableStatus.init));
    }).catchError((error) {
      emit(state.copyWith(deleteTableStatus: DeleteTableStatus.failure));
    });
  }

  FutureOr<void> _onEditTableEvent(
      EditTableEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(editTableStatus: EditTableStatus.loading));
    await dio.putUri(getRequestUri(EndPoints.editTable(event.id.toString())), data: {
      "number": event.number,
    }).then((value) {
      Table table = Table.fromJson(value.data['data']);
      List<Table> tables = List.of(state.tables);
      int index = tables.indexWhere((element) => element.id.toString() == event.id);
      tables[index] = table;
      emit(state.copyWith(editTableStatus: EditTableStatus.success, tables: tables));
      emit(state.copyWith(editTableStatus: EditTableStatus.init));
    }).catchError((error) {
      emit(state.copyWith(editTableStatus: EditTableStatus.failure));
    });
  }

  FutureOr<void> _onGetProductsEvent(GetProductsEvent event, Emitter<AppState> emit)async {
    emit(state.copyWith(getProductsStatus: GetProductsStatus.loading));
    await dio.getUri(getRequestUri(EndPoints.getProducts)).then((value) {
      ProductsModel productsModel = ProductsModel.fromJson(value.data);
      emit(state.copyWith(getProductsStatus: GetProductsStatus.success, products: productsModel.products));
      emit(state.copyWith(getProductsStatus: GetProductsStatus.init));
    }).catchError((error) {
      emit(state.copyWith(getProductsStatus: GetProductsStatus.failure));
    });
  }

   _onAddProductEvent(AddProductEvent event, Emitter<AppState> emit) async{
    emit(state.copyWith(addProductStatus: AddProductStatus.loading));
    String? photoPath;
    if(event.image!=null) {
      String fileName = event.image!.path.split('/').last;
      String mimeType = mime(fileName) ?? '';
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];
      await dio.postUri(
          getRequestUri(EndPoints.uploadImage), data: FormData.fromMap(
          {
            "file": await MultipartFile.fromFile(
              event.image!.path,
              filename: fileName,
              contentType: MediaType(mimee, type),
            ),
            "file_path": "test/images"
          }
      ),options:Options(
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
        },
      )).then((value) => photoPath=value.data['data']).catchError((error){
        emit(state.copyWith(addProductStatus: AddProductStatus.failure));
        print('upload image failed');
      });
    }
    await dio.postUri(getRequestUri(EndPoints.addProducts), data: {
      "number": event.number,
      "name": event.name,
      "price": event.price,
      "photo_path":photoPath,
      "type" : event.type
    }).then((value) {
      Product product = Product.fromJson(value.data['data']);
      List<Product> products = List.of(state.products);
      products.add(product);
      emit(state.copyWith(addProductStatus: AddProductStatus.success, products: products));
      emit(state.copyWith(addProductStatus: AddProductStatus.init));
    }).catchError((error) {
      emit(state.copyWith(addProductStatus: AddProductStatus.failure));
    });
  }

  FutureOr<void> _onDeleteProductEvent(DeleteProductEvent event, Emitter<AppState> emit)async {
    emit(state.copyWith(deleteProductStatus: DeleteProductStatus.loading));
    await dio.deleteUri(getRequestUri(EndPoints.deleteProducts(event.id.toString()))).then((value) {
      List<Product> products = List.of(state.products);
      products.removeWhere((element) => element.id.toString() == event.id);
      emit(state.copyWith(deleteProductStatus: DeleteProductStatus.success, products: products));
      emit(state.copyWith(deleteProductStatus: DeleteProductStatus.init));
    }).catchError((error) {
      emit(state.copyWith(deleteProductStatus: DeleteProductStatus.failure));
    });
  }

  FutureOr<void> _onEditProductEvent(EditProductEvent event, Emitter<AppState> emit)async {
    emit(state.copyWith(editProductStatus: EditProductStatus.loading));
    String? photoPath;
    if(event.image!=null) {
      String fileName = event.image!.path.split('/').last;
      String mimeType = mime(fileName) ?? '';
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];
      await dio.postUri(
          getRequestUri(EndPoints.uploadImage), data: FormData.fromMap(
          {
            "file": await MultipartFile.fromFile(
              event.image!.path,
              filename: fileName,
              contentType: MediaType(mimee, type),
            ),
            "file_path": "test/images"
          }
      ),options:Options(
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
        },
      )).then((value) => photoPath=value.data['data']).catchError((error){
        emit(state.copyWith(addProductStatus: AddProductStatus.failure));
        print('upload image failed');
      });
    }
    await dio.putUri(getRequestUri(EndPoints.editProduct(event.id.toString())), data: {
      "number": event.number,
      "name": event.name,
      "price": event.price,
      "photo_path":event.photoPath ?? photoPath,
      "type" : event.type
    }).then((value) {
      Product product = Product.fromJson(value.data['data']);
      List<Product> products = List.of(state.products);
      int index = products.indexWhere((element) => element.id.toString() == event.id);
      products[index] = product;
      emit(state.copyWith(editProductStatus: EditProductStatus.success, products: products));
      emit(state.copyWith(editProductStatus: EditProductStatus.init));
    }).catchError((error) {
      emit(state.copyWith(editProductStatus: EditProductStatus.failure));
    });
  }
  Uri getRequestUri(String endPoint , {dynamic queryParameters} ) {
    final uri = Uri.parse(dio.options.baseUrl);
    return Uri(
      host: uri.host,
      scheme: uri.scheme,
      path: endPoint,
      queryParameters: queryParameters,
    );
  }

  _onAddOrderItemEvent(AddOrderItemEvent event, Emitter<AppState> emit) {
    Map<int,List<Map<String,dynamic>>> data=Map.of(state.tablesOrderItems);
    if(data[event.tableId]==null){
      data[event.tableId]=[];
    }
    data[event.tableId]!.add({
      "product_id":event.productId,
      "amount":event.amount,
      "notes":event.notes,
    });
     emit(state.copyWith(tablesOrderItems: data));
  }

   _onCreateOrderEvent(CreateOrderEvent event, Emitter<AppState> emit)async {
     if(state.tablesOrderItems[event.tableId]==null){
       return ;
     }

     emit(state.copyWith(createOrderStatus: CreateOrderStatus.loading));
     await dio.postUri(getRequestUri(EndPoints.createOrder), data: {
       "table_id": event.tableId,
       "carts": state.tablesOrderItems[event.tableId]
     }).then((value) {
       emit(state.copyWith(createOrderStatus: CreateOrderStatus.success,tables: state.tables.map((e) {
         if(e.id==event.tableId){
           return e.copyWith(
             activeOrder: ActiveOrder.fromJson(value.data['data'])
           );
         }
         return e;
       }).toList(), tablesOrderItems: {}));
       emit(state.copyWith(createOrderStatus: CreateOrderStatus.init));
     }).catchError((error) {
       emit(state.copyWith(createOrderStatus: CreateOrderStatus.failure));
     });
   }


  FutureOr<void> _onChangeOrderItemQuantityEvent(ChangeOrderItemQuantityEvent event, Emitter<AppState> emit) {
    Map<int,List<Map<String,dynamic>>> data=Map.of(state.tablesOrderItems);
    data[event.tableId]!.firstWhere((element) => element['product_id']==event.productId)['amount']=max(1,event.qty);
    emit(state.copyWith(tablesOrderItems: data));
  }

  FutureOr<void> _onRemoveOrderItemEvent(RemoveOrderItemEvent event, Emitter<AppState> emit) {
    Map<int,List<Map<String,dynamic>>> data=Map.of(state.tablesOrderItems);
    data[event.tableId]!.removeWhere((element) => element['product_id']==event.productId);
    emit(state.copyWith(tablesOrderItems: data));
  }
}
