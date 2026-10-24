import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/core/firebase/firebase_fields.dart';
import 'package:tatbiqa/feature/subscription/data/datasource/subscription_datasource.dart';



class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  static const int _trialDays = 7;
  static const _server = GetOptions(source: Source.server);

  Future<DocumentReference<Map<String, dynamic>>> _ref(String phone) async {
    if (FirebaseAuth.instance.currentUser == null) {
      await getIt.get<FirebaseAuth>().signInAnonymously();
    }
    return getIt
        .get<FirebaseFirestore>()
        .collection(FirebaseFields.subscriptions)
        .doc(phone);
  }

  @override
  Future<void> registerTrial(String phone) async {
    final ref = await _ref(phone);
    final snap = await ref.get(_server);
    if (snap.exists) return;

    await ref.set({
      FirebaseFields.isSubscribed: false,
      FirebaseFields.trialStartDate: FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<bool> checkTrialExpiredOrSubscribed(String phone) async {
    final ref = await _ref(phone);

    if (!(await ref.get(_server)).exists) {
      await registerTrial(phone);
      return false;
    }

    await ref.update({FirebaseFields.lastSeen: FieldValue.serverTimestamp()});
    final data = (await ref.get(_server)).data();
    if (data == null) throw Exception('no data');

    if (data[FirebaseFields.isSubscribed] == true) return false;

    final start =
        (data[FirebaseFields.trialStartDate] as Timestamp?)?.toDate();
    final now = (data[FirebaseFields.lastSeen] as Timestamp?)?.toDate();
    if (start == null || now == null) throw Exception('missing dates');

    return now.difference(start).inDays >= _trialDays;
  }

  @override
  Future<DateTime?> getTrialEndDate(String phone) async {
    final ref = await _ref(phone);
    final data = (await ref.get(_server)).data();
    final start =
        (data?[FirebaseFields.trialStartDate] as Timestamp?)?.toDate();
    return start?.add(const Duration(days: _trialDays));
  }
}