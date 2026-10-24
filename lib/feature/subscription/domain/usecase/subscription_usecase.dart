import 'package:tatbiqa/feature/subscription/domain/repo/subscription_repo.dart';

class CheckSubscriptionUseCase {
  final SubscriptionRepo repository;
  CheckSubscriptionUseCase(this.repository);

  Future<bool> checkTrial(String phone) =>
      repository.checkTrialOrSubscription(phone);

  Future<void> registerTrial(String phone) =>
      repository.registerTrial(phone);

      Future<DateTime?> getTrialEndDate(String phone) =>
    repository.getTrialEndDate(phone);
}