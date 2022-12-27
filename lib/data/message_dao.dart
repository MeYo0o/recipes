import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meyochat/data/message.dart';

class MessageDao {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('messages');

  void saveMessage(Message message) {
    collectionReference.add(message.toJson());
  }

  Stream<QuerySnapshot> getMessageStream() {
    return collectionReference.snapshots();
  }
}
