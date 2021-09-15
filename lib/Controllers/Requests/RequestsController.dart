import 'package:firebase_database/firebase_database.dart';
import 'package:identifyapp/Models/Utils.dart';

class RequestsController {
  late DatabaseReference _databaseRef;

  RequestsController() {
    _databaseRef = FirebaseDatabase.instance.reference();
  }

  Future<List<dynamic>> getNewRequestsFormMe() async {
    List<dynamic> _data = [];
    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('sent')
        .reference()
        .once()
        .then((value) {
      if (value.value != null) {
        Map<dynamic, dynamic> records = value.value;
        records.forEach((key1, value1) {
          value1['id'] = key1;
          _data.add(value1);
        });
      }
    });

    return _data;
  }

  Future<Map<dynamic, dynamic>> getDocument(user, docid, doc) async {
    Map<dynamic, dynamic> records = {};

    print(user);
    print(docid);

    await _databaseRef
        .child('users')
        .child(user)
        .child('documents')
        .orderByChild('type')
        .equalTo(doc)
        .reference()
        .once()
        .then((value) {
      if (value.value != null) {
        records = value.value;
      }
    });

    return records;
  }

  Future<void> removeRequest(String uid, String rid) async {
    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('sent')
        .child(rid)
        .remove();

    await _databaseRef
        .child('users')
        .child(uid)
        .child('requests')
        .child(rid)
        .remove();
  }

  Future<void> rejectRequest(String uid, String from) async {
    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('requests')
        .child(uid)
        .update({'status': 3});

    await _databaseRef
        .child('users')
        .child(from)
        .child('sent')
        .child(uid)
        .update({'status': 3});
  }

  Future<void> approveRequest(String uid, String from) async {
    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('requests')
        .child(uid)
        .update({'status': 2});

    await _databaseRef
        .child('users')
        .child(from)
        .child('sent')
        .child(uid)
        .update({'status': 2});
  }

  Future<bool> checkForDocumentExist(id, docType) async {
    bool check = false;
    await _databaseRef
        .child('users')
        .child(id)
        .child('documents')
        .reference()
        .orderByChild('type')
        .equalTo(docType)
        .once()
        .then((snapshot) async {
      if (snapshot.value != null) {
        check = true;
      }
    });

    return check;
  }

  Future<Map<dynamic, List<dynamic>>> getAllRequestsForMe() async {
    Map<dynamic, List<dynamic>> _data = {};
    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('requests')
        .reference()
        .once()
        .then((value) {
      if (value.value != null) {
        Map<dynamic, dynamic> records = value.value;

        List<dynamic> _new = [];
        List<dynamic> _old = [];
        List<dynamic> _blocked = [];

        records.forEach((key1, value1) {
          var temp = value1;
          temp['id'] = key1;
          if (value1['status'] == 1) {
            _new.add(temp);
          } else if (value1['status'] == 2) {
            _old.add(temp);
          } else {
            _blocked.add(temp);
          }
        });

        _data['new'] = _new;
        _data['old'] = _old;
        _data['blocked'] = _blocked;
      }
    });

    return _data;
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
          var queryMain = _databaseRef
              .child('users')
              .child(obj.keys.first)
              .child('requests');

          var dataRec = {
            'type': element,
            'name': Utils.profileUser.name,
            'status': 1,
            'email': Utils.profileUser.email,
            'by': Utils.profileUser.uid,
          };

          String newKey = queryMain.push().key;
          await queryMain.child(newKey).set(dataRec);

          dataRec.remove('by');
          dataRec.remove('name');
          dataRec['email'] = obj.values.first['email'];
          dataRec['to'] = obj.keys.first;

          await _databaseRef
              .child('users')
              .child(Utils.profileUser.uid)
              .child('sent')
              .child(newKey)
              .set(dataRec);
        }
        check = true;
      } else {
        Utils.showToast('Account Not Found');
      }
    });

    return check;
  }
}
