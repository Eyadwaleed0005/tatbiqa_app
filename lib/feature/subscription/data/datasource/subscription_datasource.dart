abstract class SubscriptionRemoteDataSource {
  Future<void> registerTrial(String phone);

  Future<bool> checkTrialExpiredOrSubscribed(String phone);
  Future<DateTime?> getTrialEndDate(String phone);
}