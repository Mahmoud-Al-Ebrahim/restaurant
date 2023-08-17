import '../../../models/products_model.dart';
import '../../../models/tables_model.dart';

enum GetTablesStatus { init, loading, failure, success }
enum AddTableStatus { init, loading, failure, success }
enum EditTableStatus { init, loading, failure, success }
enum DeleteTableStatus { init, loading, failure, success }

enum GetProductsStatus { init, loading, failure, success }
enum AddProductStatus { init, loading, failure, success }
enum EditProductStatus { init, loading, failure, success }
enum DeleteProductStatus { init, loading, failure, success }

enum CreateOrderStatus { init, loading, failure, success }

class AppState {
  AppState(
      {required this.currentIndex,
      this.tables = const [],
      this.products = const [],
      this.tablesOrderItems = const {},
      this.getTablesStatus = GetTablesStatus.init,
      this.createOrderStatus = CreateOrderStatus.init,
      this.deleteTableStatus = DeleteTableStatus.init,
      this.editTableStatus = EditTableStatus.init,
      this.addTableStatus = AddTableStatus.init,
        this.getProductsStatus = GetProductsStatus.init,
        this.addProductStatus = AddProductStatus.init,
        this.editProductStatus = EditProductStatus.init,
        this.deleteProductStatus = DeleteProductStatus.init
      });

  final int currentIndex;
  final List<Table> tables;
  final List<Product> products;
  final GetTablesStatus getTablesStatus;
  final AddTableStatus addTableStatus;
  final EditTableStatus editTableStatus;
  final DeleteTableStatus deleteTableStatus;

  final Map<int , List<Map<String,dynamic>>> tablesOrderItems;
  final CreateOrderStatus createOrderStatus;

  final GetProductsStatus getProductsStatus;
  final AddProductStatus addProductStatus;
  final EditProductStatus editProductStatus;
  final DeleteProductStatus deleteProductStatus;

  AppState copyWith(
      {int? currentIndex,
      final List<Table>? tables,
        final List<Product>? products,
        final GetTablesStatus? getTablesStatus,
      final AddTableStatus? addTableStatus,
        final Map<int , List<Map<String,dynamic>>>? tablesOrderItems,
        final CreateOrderStatus? createOrderStatus,
      final EditTableStatus? editTableStatus,
      final DeleteTableStatus? deleteTableStatus,
        final GetProductsStatus? getProductsStatus,
        final AddProductStatus? addProductStatus,
        final EditProductStatus? editProductStatus,
        final DeleteProductStatus? deleteProductStatus,
      }) {
    return AppState(
      currentIndex: currentIndex ?? this.currentIndex,
      tables: tables ?? this.tables,
      products: products ?? this.products,
      getTablesStatus: getTablesStatus ?? this.getTablesStatus,
      editTableStatus: editTableStatus ?? this.editTableStatus,
      addTableStatus: addTableStatus ?? this.addTableStatus,
      deleteTableStatus: deleteTableStatus ?? this.deleteTableStatus,
      getProductsStatus: getProductsStatus ?? this.getProductsStatus,
      addProductStatus: addProductStatus ?? this.addProductStatus,
      editProductStatus: editProductStatus ?? this.editProductStatus,
      deleteProductStatus: deleteProductStatus ?? this.deleteProductStatus,
      tablesOrderItems: tablesOrderItems ?? this.tablesOrderItems,
      createOrderStatus: createOrderStatus ?? this.createOrderStatus,
    );
  }
}
