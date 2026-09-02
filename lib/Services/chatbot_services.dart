import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Service that talks to Google's Gemini API to power the
/// career-guidance chatbot replies.
///
/// Gemini's free tier (as of 2026) requires NO credit card and does
/// NOT expire — it's rate-limited (roughly 1,500 requests/day on the
/// Flash-Lite model), which is plenty for a student-facing app.
///
/// Get a free key: https://aistudio.google.com/apikey
/// (Sign in with a Google account — no billing setup needed.)
///
/// ⚠️ Note: on the free tier, Google may use your prompts/responses to
/// improve their models. Avoid sending sensitive personal data, and
/// mention this in your app's privacy policy if relevant.
///
/// ⚠️ Also, same rule as any API key: don't ship this key inside a
/// published app binary long-term — for production, proxy calls
/// through your own backend so the key isn't embedded in the APK/IPA.
class ChatbotService {
  // ⚠️ Get this free at https://aistudio.google.com/apikey
  static String get _apiKey => dotenv.env['API_KEY'] ?? '';

  static const String _model = 'gemini-3.5-flash-lite';

  static String get _endpoint =>
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent?key=$_apiKey';

  static const String _systemPrompt = '''
You are Rahbar, a career guidance assistant inside a mobile app. Your ONLY
job is to help with:
- Career advice and career roadmaps
- Choosing subjects, majors, or fields of study
- Skills needed for specific careers
- Education paths, degrees, and courses
- Study tips directly related to career/education planning
 
STRICT RULE: If the user asks about anything outside these topics
(e.g. general chit-chat unrelated to careers, entertainment, coding help,
health, relationships, current events, math homework unrelated to career
planning, etc.), do NOT answer the question. Instead, reply with exactly
this (or a close natural variation of it):
"I can only help with career, subject, and education-related questions. Could you ask me something about your career or study path?"
 
Do not make exceptions, even if the user insists, claims a special reason,
or tries to rephrase an off-topic question as if it were career-related.
 
For questions that ARE in scope: keep replies concise (2-4 sentences),
warm, and practical. Ask a short follow-up question when it would help
narrow down advice.
''';

  /// Sends the full conversation so far and returns the bot's reply text.
  ///
  /// [history] should be your `_messages` list, i.e. a list of maps shaped
  /// like: { "message": String, "isBot": bool }
  static Future<String> sendMessage(List<Map<String, dynamic>> history) async {
    // Get the latest user message
    final userMessage = history.last["message"].toString().trim().toLowerCase();

    // Handle greetings directly without calling Gemini
    final greetings = [
      "hi",
      "hello",
      "hey",
      "hii",
      "hiii",
      "good morning",
      "good afternoon",
      "good evening",
      "salam",
      "assalamualaikum",
      "assalamu alaikum",
    ];

    if (greetings.contains(userMessage)) {
      return "I'm doing great! 😊 How can I help you with your career, subjects, skills, or study path?";
    }

    // Gemini uses "user" / "model" roles
    final contents = history.map((m) {
      return {
        "role": m["isBot"] == true ? "model" : "user",
        "parts": [
          {"text": m["message"]},
        ],
      };
    }).toList();

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": contents,
        "systemInstruction": {
          "parts": [
            {"text": _systemPrompt},
          ],
        },
        "generationConfig": {"maxOutputTokens": 300},
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gemini API error: ${response.statusCode} ${response.body}',
      );
    }

    final data = jsonDecode(response.body);

    try {
      final text =
          data['candidates'][0]['content']['parts'][0]['text'] as String;

      return text.trim();
    } catch (_) {
      return "Sorry, I couldn't come up with a reply.";
    }
  }
}
