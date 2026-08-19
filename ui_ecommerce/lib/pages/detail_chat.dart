import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {
  final String contactName;
  final String contactAvatar;

  const ChatDetailPage({
    super.key,
    required this.contactName,
    this.contactAvatar = 'assets/images/default_avatar.jpg',
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<Map<String, dynamic>> messages = [
    {'text': 'Hallo', 'isMe': true, 'time': '12:55'},
    {'text': 'Ada yang bisa dibantu?', 'isMe': false, 'time': '13:00'},
    {'text': 'Saya tertarik dengan produk terbaru', 'isMe': true, 'time': '13:02'},
    {'text': 'Baik, produk apa yang ingin Anda ketahui?', 'isMe': false, 'time': '13:05'},
    {'text': 'Sepatu Nike Air Max', 'isMe': true, 'time': '13:10'},
    {'text': 'Untuk ukuran dan warna tersedia lengkap', 'isMe': false, 'time': '13:15'},
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text,
          'isMe': true,
          'time': _formatCurrentTime(),
        });
      });
      _controller.clear();
      _scrollToBottom();
    }
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                widget.contactAvatar,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4C53A5),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contactName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
            color: const Color(0xFF4C53A5),
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
            color: const Color(0xFF4C53A5),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            color: const Color(0xFF4C53A5),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message['isMe'] as bool;
                final text = message['text'] as String;
                final time = message['time'] ?? '--:--';

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isMe
                                ? const Color(0xFF4C53A5)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: isMe
                                  ? const Radius.circular(16)
                                  : const Radius.circular(4),
                              topRight: isMe
                                  ? const Radius.circular(4)
                                  : const Radius.circular(16),
                              bottomLeft: const Radius.circular(16),
                              bottomRight: const Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 16,
                              color: isMe ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {},
                  color: const Color(0xFF4C53A5),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                    ),
                    onSubmitted: (value) {
                      _sendMessage();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF4C53A5),
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
