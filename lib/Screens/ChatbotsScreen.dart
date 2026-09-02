import 'package:careerguidance_app/Screens/ChatHistoryScreen.dart';
import 'package:careerguidance_app/Services/chat_history_service.dart';
import 'package:careerguidance_app/Services/chatbot_services.dart';
import 'package:flutter/material.dart';
import 'package:careerguidance_app/utils/AppColors.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {"message": "Hi! 👋 I'm Rahbar, your career assistant.", "isBot": true},
    {
      "message":
          "I can help you explore careers, subjects, skills, and study paths. What would you like to know?",
      "isBot": true,
    },
  ];

  final List<String> _suggestions = [
    "Which career is best for me?",
    "I like computers",
    "Tell me about engineering",
    "What subjects should I choose?",
  ];

  bool _isTyping = false;

  // Firestore session currently backing this conversation.
  // Null means either: still creating one, or no user is signed in
  // (in which case history simply won't be saved).
  String? _sessionId;

  @override
  void initState() {
    super.initState();
    _initSession();
  }

  Future<void> _initSession() async {
    final id = await ChatHistoryService.createSession();
    if (!mounted) return;
    setState(() {
      _sessionId = id;
    });
  }

  void _sendMessage([String? suggestion]) async {
    final text = suggestion ?? _messageController.text.trim();

    if (text.isEmpty || _isTyping) return;

    setState(() {
      _messages.add({"message": text, "isBot": false});
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    if (_sessionId != null) {
      ChatHistoryService.addMessage(
        sessionId: _sessionId!,
        message: text,
        isBot: false,
      );
    }

    try {
      final reply = await ChatbotService.sendMessage(_messages);

      if (!mounted) return;

      setState(() {
        _messages.add({"message": reply, "isBot": true});
        _isTyping = false;
      });

      if (_sessionId != null) {
        ChatHistoryService.addMessage(
          sessionId: _sessionId!,
          message: reply,
          isBot: true,
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print('ChatbotService.sendMessage failed: $e');

      if (!mounted) return;

      setState(() {
        _messages.add({
          "message":
              "Sorry, I'm having trouble connecting right now. Please try again.",
          "isBot": true,
        });
        _isTyping = false;
      });
    }

    _scrollToBottom();
  }

  /// Opens the history list; if the user picks a past conversation,
  /// loads its messages back into this screen and resumes it.
  Future<void> _openHistory() async {
    final selectedSessionId = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const ChatHistoryScreen()),
    );

    if (selectedSessionId == null || !mounted) return;

    final messages = await ChatHistoryService.getMessages(selectedSessionId);

    if (!mounted) return;

    setState(() {
      _sessionId = selectedSessionId;
      _messages
        ..clear()
        ..addAll(messages);
    });

    _scrollToBottom();
  }

  /// Starts a brand-new conversation with a fresh Firestore session.
  Future<void> _startNewChat() async {
    final id = await ChatHistoryService.createSession();
    if (!mounted) return;

    setState(() {
      _sessionId = id;
      _messages
        ..clear()
        ..addAll([
          {
            "message": "Hi! 👋 I'm Rahbar, your career assistant.",
            "isBot": true,
          },
          {
            "message":
                "Hi, How can i hepl you, I can help you explore careers, subjects, skills, and study paths. What would you like to know?",
            "isBot": true,
          },
        ]);
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Row(
          children: [
            // BOT ICON
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                gradient: AppColors.orangeGradient,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),

            const SizedBox(width: 12),

            // TITLE
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Career Assistant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Row(
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4ADE80),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "Online",
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_comment_outlined,
              color: Colors.white,
              size: 21,
            ),
            tooltip: "New chat",
            onPressed: _startNewChat,
          ),
          IconButton(
            icon: const Icon(
              Icons.history_rounded,
              color: Colors.white,
              size: 23,
            ),
            tooltip: "Chat history",
            onPressed: _openHistory,
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ================= BODY =================
      body: SafeArea(
        child: Column(
          children: [
            // ================= CHAT =================
            Expanded(
              child: ListView.builder(
                controller: _scrollController,

                padding: EdgeInsets.symmetric(
                  horizontal: size.width < 360 ? 12 : 16,
                  vertical: 12,
                ),

                // +1 slot for the "typing..." bubble when active
                itemCount: _messages.length + (_isTyping ? 1 : 0),

                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return _buildTypingBubble();
                  }

                  final message = _messages[index];

                  return _buildMessage(message["message"], message["isBot"]);
                },
              ),
            ),

            // ================= SUGGESTIONS =================
            if (_messages.length <= 2) _buildSuggestions(),

            // ================= INPUT =================
            _buildInputBox(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE BUBBLE
  // ============================================================

  Widget _buildMessage(String message, bool isBot) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isBot
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          // BOT AVATAR
          if (isBot) ...[
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                gradient: AppColors.orangeGradient,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 19,
              ),
            ),

            const SizedBox(width: 8),
          ],

          // MESSAGE
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 320),

              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

              decoration: BoxDecoration(
                color: isBot ? AppColors.field : null,

                gradient: isBot ? null : AppColors.orangeGradient,

                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),

                  bottomLeft: Radius.circular(isBot ? 4 : 18),

                  bottomRight: Radius.circular(isBot ? 18 : 4),
                ),

                border: isBot
                    ? Border.all(color: Colors.white.withOpacity(0.05))
                    : null,
              ),

              child: Text(
                message,
                style: TextStyle(
                  color: isBot ? Colors.white.withOpacity(0.9) : Colors.white,

                  fontSize: 14,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TYPING INDICATOR
  // ============================================================

  Widget _buildTypingBubble() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              gradient: AppColors.orangeGradient,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              color: Colors.white,
              size: 19,
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            decoration: BoxDecoration(
              color: AppColors.field,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),

            child: const SizedBox(
              width: 24,
              height: 12,
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUGGESTIONS
  // ============================================================

  Widget _buildSuggestions() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Try asking",
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 9),

          SizedBox(
            height: 38,

            child: ListView.separated(
              scrollDirection: Axis.horizontal,

              itemCount: _suggestions.length,

              separatorBuilder: (_, __) {
                return const SizedBox(width: 8);
              },

              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _sendMessage(_suggestions[index]);
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),

                    decoration: BoxDecoration(
                      color: AppColors.field,

                      borderRadius: BorderRadius.circular(20),

                      border: Border.all(
                        color: AppColors.orangeStart.withOpacity(0.35),
                      ),
                    ),

                    alignment: Alignment.center,

                    child: Text(
                      _suggestions[index],
                      style: const TextStyle(
                        color: AppColors.accentYellow,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INPUT BOX
  // ============================================================

  Widget _buildInputBox() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),

      decoration: BoxDecoration(
        color: AppColors.background,

        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // TEXT FIELD
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 48, maxHeight: 110),

              decoration: BoxDecoration(
                color: AppColors.field,

                borderRadius: BorderRadius.circular(25),

                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),

              child: TextField(
                controller: _messageController,

                maxLines: null,

                textInputAction: TextInputAction.newline,

                style: const TextStyle(color: Colors.white, fontSize: 14),

                decoration: const InputDecoration(
                  hintText: "Ask about your career...",

                  hintStyle: TextStyle(color: AppColors.hintText, fontSize: 13),

                  border: InputBorder.none,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),

                onSubmitted: (_) {
                  _sendMessage();
                },
              ),
            ),
          ),

          const SizedBox(width: 8),

          // SEND BUTTON
          GestureDetector(
            onTap: () {
              _sendMessage();
            },

            child: Container(
              height: 48,
              width: 48,

              decoration: BoxDecoration(
                gradient: AppColors.orangeGradient,

                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: AppColors.orangeStart.withOpacity(0.25),

                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
