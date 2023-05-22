const sQueryLHMSByPK = r'''
    query QueryLHMSByPK($pk: String!) {
      queryLHMSByPK(PK: $pk) {
        items {
        id
        PK
        SK
        GSI1
        addr
        avl
        cac
        cid
        clg
        cod
        ctc
        dis
        dob
        doe
        gna
        hna
        hsa
        hsi
        hso
        hsp
        iUr
        ihs
        isr
        lat
        lon
        mph
        nna
        nor
        prov
        rno
        sex
        sna
        tst
      }
    }
    }
    ''';

const sQueryHotelIdBySecretKey = r'''
      query GetHotelIdBySecretKey($regCode: String!, $secretKey: String!) {
        lHMSByGSI1(SK: $regCode, GSI1: $secretKey, limit: 1) {
          items {
            PK
            SK
            GSI1
          }
        }
      }
    ''';

//to activate or deactivate hotel,
//cognitoAcc is the cognito account of the hotel admin
//aOrd is the action to activate or deactivate hotel
//hotelID is the hotel id
//staffId is the staff id of the hotel admin
const sActivateHotel = r'''
  mutation ActivateHotel($aOrd: Boolean!, $cognitoAcc: String!, $hotelID: String!, $staffId: String!) {
    activateHotel(input: {aOrd: $aOrd, cognitoAcc: $cognitoAcc, hotelID: $hotelID, staffId: $staffId}) {
      keys {
        PK
        SK
      }
    }
  }
  ''';