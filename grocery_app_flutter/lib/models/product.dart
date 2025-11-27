import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String unit;
  final bool isFavorite;
  final double? discountPercent;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.unit,
    this.isFavorite = false,
    this.discountPercent,
  });

  Product copyWith({
    bool? isFavorite,
  }) {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      image: image,
      unit: unit,
      isFavorite: isFavorite ?? this.isFavorite,
      discountPercent: discountPercent,
    );
  }
}

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final IconData icon;
  final DateTime date;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.icon,
    required this.date,
    this.isRead = false,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    IconData? icon,
    DateTime? date,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      icon: icon ?? this.icon,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }
}