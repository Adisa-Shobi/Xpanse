enum TransactionType { RECEIVED, SENT }

Map<String, dynamic> parseMobileMoneyMessage(String message) {
  try {
    // Check message type first
    bool isReceived = message.toLowerCase().contains('you have received');

    // Common regex patterns
    final amountRegex = RegExp(r'(\d+)\s*RWF');
    final dateRegex = RegExp(r'at\s+(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})');
    final balanceRegex = RegExp(r'balance:\s*(\d+)|balance\s*:\s*(\d+)');

    // Extract common information
    final amount = amountRegex.firstMatch(message)?.group(1);
    final dateTime = dateRegex.firstMatch(message)?.group(1);
    final balanceMatch = balanceRegex.firstMatch(message);
    final balance = balanceMatch?.group(1) ?? balanceMatch?.group(2);

    if (isReceived) {
      // Credit message specific patterns
      final senderRegex = RegExp(r'from\s+([^(]+)');
      final phoneRegex = RegExp(r'\(([^)]+)\)');
      final transactionIdRegex = RegExp(r'Transaction Id:\s*(\d+)');
      final recipientRegex = RegExp(r'to\s+(\d+)');

      // Extract credit specific info
      final sender = senderRegex.firstMatch(message)?.group(1)?.trim();
      final senderPhone = phoneRegex.firstMatch(message)?.group(1);
      final transactionId = transactionIdRegex.firstMatch(message)?.group(1);
      final recipient = recipientRegex.firstMatch(message)?.group(1);

      return {
        'type': 'RECEIVED',
        'amount': int.tryParse(amount ?? '0'),
        'sender': {'name': sender, 'phone': senderPhone},
        'recipient': recipient,
        'timestamp': DateTime.tryParse(dateTime ?? ''),
        'balance': int.tryParse(balance ?? '0'),
        'transactionId': transactionId,
        'currency': 'RWF',
        'isValid': true
      };
    } else {
      // Debit message specific patterns
      final recipientNameRegex = RegExp(r'transferred to\s+([^(]+)');
      final recipientPhoneRegex = RegExp(r'\((\d+)\)');
      final feeRegex = RegExp(r'Fee was:\s*(\d+)');
      final senderIdRegex = RegExp(r'from\s+(\d+)');

      // Extract debit specific info
      final recipientName =
          recipientNameRegex.firstMatch(message)?.group(1)?.trim();
      final recipientPhone = recipientPhoneRegex.firstMatch(message)?.group(1);
      final fee = feeRegex.firstMatch(message)?.group(1);
      final senderId = senderIdRegex.firstMatch(message)?.group(1);

      return {
        'type': 'SENT',
        'amount': int.tryParse(amount ?? '0'),
        'recipient': {'name': recipientName, 'phone': recipientPhone},
        'senderId': senderId,
        'timestamp': DateTime.tryParse(dateTime ?? ''),
        'balance': int.tryParse(balance ?? '0'),
        'fee': int.tryParse(fee ?? '0'),
        'currency': 'RWF',
        'isValid': true
      };
    }
  } catch (e) {
    return {'isValid': false, 'error': e.toString()};
  }
}
