abstract class SubscriptionRepo {
  Future<void> registerTrial(String phone);
  Future<bool> checkTrialOrSubscription(String phone);
  Future<DateTime?> getTrialEndDate(String phone);
}