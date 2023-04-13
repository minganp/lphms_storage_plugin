
  import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/models/LHMS.dart';

Future<void> saveHotelForReg<T>(Model T,) async {
    try {
      final request = ModelMutations.create(T);
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      final created = response.data;
      if (created == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${T.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }
}

Future<void> updateHotelForReg<T>(Model T) async{
  request  = ModelMutations.update(T);
}

Future<void> listHotelForRegByDis(LHMS lhms, String dis ) async{
  LHMS.qfProv.eq(value);

  QueryPredicate c =
  final request = ModelQueries.list<LHMS>(
      LHMS.classType,
      where: criteria
  );
}

