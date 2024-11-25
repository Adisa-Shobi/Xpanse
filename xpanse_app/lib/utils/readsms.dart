import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readsms/readsms.dart';

class SMSParse {
  final SmsQuery _query = SmsQuery();
  final Readsms listner = Readsms();

  Future<void> requestSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      await Permission.sms.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<List<SmsMessage>> getAllSMS() async {
    if (await Permission.sms.isGranted) {
      return await _query.getAllSms;
    } else {
      requestSmsPermission();
      return [];
    }
  }

  Future<List<SmsMessage>> querySMS({
    List<SmsQueryKind> kind = const [SmsQueryKind.inbox],
    int start = 0,
    int? count,
    bool sort = true,
    required String address,
  }) async {
    if (await Permission.sms.isGranted) {
      return await _query.querySms(
        kinds: kind,
        address: address,
        start: start,
        count: count,
        sort: sort,
      );
    } else {
      return requestSmsPermission().then((val) {
        return querySMS(
          address: address,
          start: start,
          count: count,
          sort: sort,
          kind: kind,
        );
      });
    }
  }
}
