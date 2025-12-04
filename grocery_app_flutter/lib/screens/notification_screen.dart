import 'package:flutter/material.dart';
import '../models/product.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Commande confirmée',
      message: 'Votre commande #12345 a été confirmée',
      icon: Icons.check_circle,
      date: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    NotificationItem(
      id: '2',
      title: 'Promotion spéciale',
      message: 'Profitez de 20% de réduction sur tous les fruits',
      icon: Icons.local_offer,
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      id: '3',
      title: 'Livraison en cours',
      message: 'Votre colis sera livré aujourd\'hui entre 14h et 16h',
      icon: Icons.delivery_dining,
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    NotificationItem(
      id: '4',
      title: 'Nouveaux produits',
      message: 'Découvrez nos nouveaux produits bio',
      icon: Icons.new_releases,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  void _markAsRead(String id) {
    setState(() {
      final index = notifications.indexWhere((notif) => notif.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(isRead: true);
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var i = 0; i < notifications.length; i++) {
        notifications[i] = notifications[i].copyWith(isRead: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          if (notifications.any((notif) => !notif.isRead))
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                "Tout marquer comme lu",
                style: TextStyle(color: Colors.blue),
              ),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Aucune notification",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationItem(notifications[index]);
              },
            ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: notification.isRead ? Colors.white : Colors.blue.shade50,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(notification.icon, color: Colors.blue.shade700),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              _formatDate(notification.date),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? IconButton(
                icon: const Icon(Icons.circle, size: 12, color: Colors.blue),
                onPressed: () => _markAsRead(notification.id),
              )
            : null,
        onTap: () => _markAsRead(notification.id),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return "À l'instant";
    } else if (difference.inHours < 1) {
      return "Il y a ${difference.inMinutes} min";
    } else if (difference.inDays < 1) {
      return "Il y a ${difference.inHours} h";
    } else if (difference.inDays == 1) {
      return "Hier";
    } else {
      return "Il y a ${difference.inDays} jours";
    }
  }
}