import 'package:flutter/material.dart';
import '../models/transaction_item.dart';

class RecentTransactionsList extends StatelessWidget {
  final List<TransactionItem> transactions;

  const RecentTransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('No recent transactions')),
        ),
      );
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactions.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return _TransactionTile(transaction: transaction);
        },
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionItem transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getStatusColor(transaction.status).withOpacity(0.1),
        child: Icon(
          _getTransactionIcon(transaction.type),
          color: _getStatusColor(transaction.status),
        ),
      ),
      title: Text(
        transaction.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _formatDate(transaction.createdAt),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${transaction.amount >= 0 ? '+' : ''}${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction.amount >= 0 ? Colors.green : Colors.red,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _getStatusColor(transaction.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              transaction.status.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: _getStatusColor(transaction.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        // Handle transaction tap
        print('Transaction tapped: ${transaction.id}');
      },
    );
  }

  IconData _getTransactionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'income':
        return Icons.arrow_downward;
      case 'expense':
        return Icons.arrow_upward;
      case 'transfer':
        return Icons.swap_horiz;
      default:
        return Icons.attach_money;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
