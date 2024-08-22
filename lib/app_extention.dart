
extension NotNull on String?{
  String? orEmpty(){return this ?? ""; }
} 