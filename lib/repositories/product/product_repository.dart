import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/product/base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProduct() {
    return _firebaseFirestore.collection('products').snapshots().map((product) {
      return product.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
