import 'package:firebase_database/firebase_database.dart';
import 'package:identifyapp/Models/Utils.dart';

class RequestsController {
  late DatabaseReference _databaseRef;

  RequestsController() {
    _databaseRef = FirebaseDatabase.instance.reference();
  }

  Future<void> getMyDocuments() async {
    _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('documents')
        .reference()
        .once()
        .then((value) {
      if (value.value != null) {
        Map<dynamic, dynamic> records = value.value;
        records.forEach((key1, value1) {
          // Utils.cartItems.add(value1);
        });
      }
    });
  }

  Future<bool> doRequest(email, List docs) async {
    bool check = false;
    await _databaseRef
        .child('users')
        .reference()
        .orderByChild('email')
        .equalTo(email)
        .once()
        .then((snapshot) async {
      if (snapshot.value != null) {
        Map<dynamic, dynamic> obj = snapshot.value;
        for (var element in docs) {
          await _databaseRef
              .child('users')
              .child(obj.keys.first)
              .child('requests')
              .push()
              .set({
            'type': element,
            'email': Utils.profileUser.email,
            'by': Utils.profileUser.uid,
          });
        }
        check = true;
      } else {
        Utils.showToast('Account Not Found');
      }
    });

    return check;
  }
}
