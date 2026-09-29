
abstract class Failure  {
  final String message;
  
  const Failure(this.message);


}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'حدث خطأ أثناء حفظ أو استرجاع البيانات محلياً']);
}