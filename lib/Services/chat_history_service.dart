import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Handles saving and retrieving chat sessions/messages in Firestore,
/// scoped to the currently signed-in user.
///
/// Firestore structure:
/// users/{uid}/chat_sessions/{sessionId}
///   - title, lastMessage, createdAt, updatedAt
///   users/{uid}/chat_sessions/{sessionId}/messages/{messageId}
///     - message, isBot, timestamp
class ChatHistoryService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  static CollectionReference<Map<String, dynamic>>? get _sessionsRef {
    final uid = _uid;
    if (uid == null) return null;
    return _firestore.collection('users').doc(uid).collection('chat_sessions');
  }

  /// Creates a new chat session and returns its id.
  /// Returns null if no user is signed in.
  static Future<String?> createSession() async {
    final ref = _sessionsRef;
    if (ref == null) return null;

    final doc = await ref.add({
      'title': 'New chat',
      'lastMessage': '',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  /// Adds a message to a session and updates the session's preview/title.
  static Future<void> addMessage({
    required String sessionId,
    required String message,
    required bool isBot,
  }) async {
    final ref = _sessionsRef;
    if (ref == null) return;

    final sessionDoc = ref.doc(sessionId);

    await sessionDoc.collection('messages').add({
      'message': message,
      'isBot': isBot,
      'timestamp': FieldValue.serverTimestamp(),
    });

    final updateData = <String, dynamic>{
      'lastMessage': message,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    // Use the first user message as the session title
    if (!isBot) {
      final snapshot = await sessionDoc.get();
      final data = snapshot.data();
      final currentTitle = data?['title'];

      if (currentTitle == null || currentTitle == 'New chat') {
        updateData['title'] = message.length > 40
            ? '${message.substring(0, 40)}...'
            : message;
      }
    }

    await sessionDoc.update(updateData);
  }

  /// Stream of the signed-in user's chat sessions, most recent first.
  /// Returns null if no user is signed in.
  static Stream<QuerySnapshot<Map<String, dynamic>>>? getSessions() {
    final ref = _sessionsRef;
    if (ref == null) return null;
    return ref.orderBy('updatedAt', descending: true).snapshots();
  }

  /// Fetches all messages for a session, oldest first, in the same
  /// shape used by ChatbotScreen's `_messages` list.
  static Future<List<Map<String, dynamic>>> getMessages(
    String sessionId,
  ) async {
    final ref = _sessionsRef;
    if (ref == null) return [];

    final snapshot = await ref
        .doc(sessionId)
        .collection('messages')
        .orderBy('timestamp')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "message": data['message'] ?? '',
        "isBot": data['isBot'] ?? false,
      };
    }).toList();
  }

  /// Deletes a chat session and all of its messages.
  static Future<void> deleteSession(String sessionId) async {
    final ref = _sessionsRef;
    if (ref == null) return;

    final sessionDoc = ref.doc(sessionId);
    final messages = await sessionDoc.collection('messages').get();

    for (final doc in messages.docs) {
      await doc.reference.delete();
    }

    await sessionDoc.delete();
  }
}
