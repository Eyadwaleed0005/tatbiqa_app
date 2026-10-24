import 'package:tatbiqa/feature/subscription/data/datasource/subscription_datasource.dart';
import 'package:tatbiqa/feature/subscription/domain/repo/subscription_repo.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepo {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> registerTrial(String phone) =>
      remoteDataSource.registerTrial(phone);

  @override
  Future<bool> checkTrialOrSubscription(String phone) =>
      remoteDataSource.checkTrialExpiredOrSubscribed(phone);
      @override
Future<DateTime?> getTrialEndDate(String phone) =>
    remoteDataSource.getTrialEndDate(phone);
}