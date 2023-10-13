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
    hotelActivated,
    selfCheckInRec,
}
Map<RecType, String> rPref = {
    RecType.hotel: "HO",
    RecType.hotelName: "HN",
    RecType.hotelStaff: "HS",
    RecType.changeLog: "CL",
    RecType.customer: "CU",
    RecType.nation: "NT",
    RecType.region: "RG",
    RecType.checkInRecord: "CR",
    RecType.register: "RI",
    RecType.hotelActivated: "HA",
    RecType.selfCheckInRec: "SC",
};
// separator for composite key
String sp = "_";