import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'cart_item_dao.g.dart';

@DriftAccessor(tables: [CartItemTbl])
class CartItemDao extends DatabaseAccessor<AppDatabase>
    with _$CartItemDaoMixin {
  CartItemDao(super.db);

  // * select QUERIES
  // Get ALL cart item data
  Future<List<CartItemTblData>> get selectAllCartItems =>
      select(cartItemTbl).get();

  // * insert QUERIES
  // Insert new cart item
  Future<int> insertCartItem(CartItemTblData entry) {
    return into(cartItemTbl).insert(entry);
  }

  // * delete QUERIES
  Future<void> deleteOneProductItem({required int productId}) async {
    await cartItemTbl.deleteWhere((tbl) => tbl.id.equals(productId));
  }
}
