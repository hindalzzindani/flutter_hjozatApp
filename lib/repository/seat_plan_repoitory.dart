//
//
//
// import 'package:http/http.dart' as https;
//
// class SeatPlanRepository {
//
//   Future seatPlanDynamicRepo(String tripId,String journeydate) async {
//
//     Uri url = Uri.parse('https://hjozat.app/backend/modules/api/v1/tickets/seat/$tripId/$journeydate');
//     try {
//       final response = await https.get(url);
//       print('seatPlanDynamicRepo code :' + response.statusCode.toString());
//       return response;
//
//     }
//
//     on Exception catch (exception) {
//       throw (exception);
//     } catch (error) {
//       throw Exception(error);
//     }
//   }
//
// }
