import 'package:firebase_database/firebase_database.dart';
import 'package:identifyapp/Models/Utils.dart';

class DocumentsController {
  late DatabaseReference _databaseRef;

  DocumentsController() {
    _databaseRef = FirebaseDatabase.instance.reference();
  }

  Future<List<dynamic>> getDocuments() async {
    List<dynamic> _data = [];
    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('documents')
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

  Future<bool> saveNewDocument(
      String nickname, String data, var image1, var image2, int type) async {
    var obj = {
      'image1': image1,
      'image2': image2,
      'type': type,
      'nickname': nickname,
    };

    if (data.isNotEmpty) {
      obj['data'] = data;
    }

    bool check = true;

    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('documents')
        .once()
        .then((value) {
      if (value.exists) {
        if (value.value != null) {
          Map<dynamic, dynamic> records = value.value;
          records.forEach((key1, value1) {
            if (value1['type'] == type) {
              check = false;
            }
          });
        }
      }
    });

    if (check == true) {
      await _databaseRef
          .child('users')
          .child(Utils.profileUser.uid)
          .child('documents')
          .reference()
          .push()
          .set(obj);

      Utils.showToast('Document Saved');
    } else {
      Utils.showToast('Document Exists');
    }

    return check;
  }

  Future<void> deleteDocument(String uid) async {
    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('documents')
        .child(uid)
        .remove();
  }
}
