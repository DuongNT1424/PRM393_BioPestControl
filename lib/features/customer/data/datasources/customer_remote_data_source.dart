import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer_model.dart';

/// [CustomerRemoteDataSource] định nghĩa cách thức lấy dữ liệu từ Firebase.
abstract class CustomerRemoteDataSource {
  Future<List<CustomerModel>> getCustomers();
  Future<CustomerModel> getCustomerById(String id);
  Future<void> updateCustomer(CustomerModel customer);
  Future<void> setCustomerLockStatus(String id, bool isLocked);
  Future<List<CustomerModel>> searchCustomers(String query);
  Future<List<CustomerModel>> filterCustomers({bool? isLocked});
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final FirebaseFirestore firestore;

  CustomerRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<CustomerModel>> getCustomers() async {
    // Truy vấn tất cả khách hàng (role: customer) từ Firestore
    final snapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .get();
    
    final customers = snapshot.docs.map((doc) => CustomerModel.fromFirestore(doc)).toList();
    
    // Sắp xếp thủ công trong bộ nhớ để tránh phải tạo Index trên Firebase Console
    customers.sort((a, b) {
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });
    
    return customers;
  }

  @override
  Future<CustomerModel> getCustomerById(String id) async {
    final doc = await firestore.collection('users').doc(id).get();
    if (doc.exists) {
      return CustomerModel.fromFirestore(doc);
    } else {
      throw Exception('Customer not found');
    }
  }

  @override
  Future<void> updateCustomer(CustomerModel customer) async {
    await firestore.collection('users').doc(customer.id).update(customer.toFirestore());
  }

  @override
  Future<void> setCustomerLockStatus(String id, bool isLocked) async {
    await firestore.collection('users').doc(id).update({'isLocked': isLocked});
  }

  @override
  Future<List<CustomerModel>> searchCustomers(String query) async {
    final snapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .get();
    
    final lowerQuery = query.toLowerCase();
    final customers = snapshot.docs
        .map((doc) => CustomerModel.fromFirestore(doc))
        .where((customer) => 
            customer.name.toLowerCase().contains(lowerQuery) || 
            customer.email.toLowerCase().contains(lowerQuery) ||
            (customer.phone != null && customer.phone!.contains(lowerQuery)))
        .toList();

    // Sort in memory
    customers.sort((a, b) {
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });

    return customers;
  }

  @override
  Future<List<CustomerModel>> filterCustomers({bool? isLocked}) async {
    Query query = firestore.collection('users').where('role', isEqualTo: 'customer');
    
    if (isLocked != null) {
      query = query.where('isLocked', isEqualTo: isLocked);
    }
    
    final snapshot = await query.get();
    final customers = snapshot.docs.map((doc) => CustomerModel.fromFirestore(doc)).toList();

    // Sort in memory
    customers.sort((a, b) {
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });

    return customers;
  }
}
