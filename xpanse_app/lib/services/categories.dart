import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xpanse_app/models/m_money.dart';

class CategoryService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('categories');

// Create a new category
  Future<void> createCategory(Category category) async {
    try {
      // Normalize the category name (trim whitespace and convert to lowercase)
      final normalizedName = category.name.trim().toLowerCase();

      // Check if category with same name exists for this user
      final querySnapshot = await _collection
          .where('name', isEqualTo: normalizedName)
          .where('userId', isEqualTo: category.userId)
          .get();

      // If category already exists, throw exception
      if (querySnapshot.docs.isNotEmpty) {
        throw Exception('A category with this name already exists');
      }

      // If category doesn't exist, create it
      await _collection.add({
        ...category.toJson(),
        'name': category.name.trim(), // Store trimmed name but preserve case
        'createdAt': DateTime.now().toIso8601String(),
      });
      return;
    } catch (e) {
      if (e is Exception && e.toString().contains('already exists')) {
        rethrow; // Rethrow the existing category error
      }
      throw Exception('Failed to create category: $e');
    }
  }

  // Delete a category
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _collection.doc(categoryId).delete();
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }

  // Get all categories for a user
  Future<List<Category>> getAllCategories(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _collection
          .where('userId', isEqualTo: userId)
          .orderBy('name')
          .get();

      return querySnapshot.docs.map((doc) {
        return Category.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  // Stream all categories for a user (useful for real-time updates in UI)
  Stream<List<Category>> streamCategories(String userId) {
    return _collection
        .where('userId', isEqualTo: userId)
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Category.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }).toList();
    });
  }
}

class Category {
  final String? id;
  final String name;
  final String userId;
  final String? icon;
  final DateTime createdAt;

  Category({
    this.id,
    required this.name,
    required this.userId,
    this.icon,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userId': userId,
      'icon': icon,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      icon: json['icon'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  List<MoMoTransaction> categoryTransactions(
      List<MoMoTransaction> transactions) {
    return transactions.where((t) => t.category == name).toList();
  }

  int totalAmount(List<MoMoTransaction> transactions) {
    return categoryTransactions(transactions)
        .map((t) => t.amount)
        .fold(0, (a, b) => a + b);
  }

  double getFraction(List<MoMoTransaction> transactions, int? total) {
    final totalAmount = this.totalAmount(transactions);
    final int lTotal =
        total ?? transactions.map((t) => t.amount).fold(0, (a, b) => a + b);
    return totalAmount / lTotal;
  }
}

// Usage Example:
/*
void main() async {
  final categoryService = CategoryService();
  
  // Create a category
  final newCategory = Category(
    id: '', // ID will be assigned by Firestore
    name: 'Groceries',
    userId: 'user123',
    icon: '🛒',
    createdAt: DateTime.now(),
  );
  await categoryService.createCategory(newCategory);

  // Get all categories
  final categories = await categoryService.getAllCategories('user123');
  for (var category in categories) {
    print('${category.name} (${category.icon})');
  }

  // Delete a category
  await categoryService.deleteCategory('categoryId');

  // Use in Flutter StreamBuilder
  StreamBuilder<List<Category>>(
    stream: categoryService.streamCategories('user123'),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      final categories = snapshot.data!;
      return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Text(category.icon ?? '📁'),
            title: Text(category.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => categoryService.deleteCategory(category.id),
            ),
          );
        },
      );
    },
  );
}
*/