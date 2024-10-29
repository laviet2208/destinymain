import 'package:firebase_database/firebase_database.dart';

class enterReferralController {
  static Future<bool> checkReferralCode(String referral) async {
    bool check = false;
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("Account").orderByChild('referralCode').equalTo(referral).once();
    final dynamic data = snapshot.snapshot.value;
    if (data != null) {
      check = true;
    }
    return check;
  }
}