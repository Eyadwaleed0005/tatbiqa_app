class SubscriptionEntity {
  final bool isSubscribed;
  final DateTime? trialStartDate;

  SubscriptionEntity({
    required this.isSubscribed,
    this.trialStartDate,
  });
}