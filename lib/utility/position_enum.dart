enum Role{
  hotelOwner,
  hotelAdmin,
  hotelReception,
  hotelStaffPadding,
  customer,
  unknown,
}
Role? roleFromString(roleStr) {
  if(roleStr == null) return Role.unknown;
  return Role.values.firstWhere((e) => e.toString() == "$roleStr"); // Color.green
}
enum RecType{
  register,
  hotel,
  hotelName,
  hotelStaff,
  changeLog,
  customer,
  nation,
  region,
  checkInRecord,
  hotelActivated
}
