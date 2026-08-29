import 'dart:async';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {
  final String contactName;
  final Color contactColor;

  const ChatDetailPage({
    super.key,
    required this.contactName,
    this.contactColor = const Color(0xFF4C53A5),
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Halo kak! Selamat datang di toko resmi kami. Ada yang bisa kami bantu seputar produk?',
      'isMe': false,
      'time': '12:00',
    },
    {
      'text': 'Halo min, saya tertarik dengan produk terbaru di etalase.',
      'isMe': true,
      'time': '12:05',
    },
    {
      'text': 'Semua produk yang ada di etalase ready stock dan original 100% ya kak! Kami juga menyediakan garansi resmi.',
      'isMe': false,
      'time': '12:06',
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<String> _quickReplies = [
    'Apakah stok ready?',
    'Bisa dikirim hari ini?',
    'Ada promo diskon?',
    'Bisa minta foto asli?',
  ];

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage([String? textToSend]) {
    final text = textToSend ?? _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': text,
          'isMe': true,
          'time': _formatCurrentTime(),
        });
        _isTyping = true;
      });
      _controller.clear();
      _scrollToBottom();

      Timer(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() {
            _isTyping = false;
            messages.add({
              'text': _generateBotResponse(text),
              'isMe': false,
              'time': _formatCurrentTime(),
            });
          });
          _scrollToBottom();
        }
      });
    }
  }

  String _generateBotResponse(String userMsg) {
    final lower = userMsg.toLowerCase();
    if (lower.contains('ready') || lower.contains('stok') || lower.contains('ada')) {
      return 'Stok untuk varian ini masih tersedia banyak kak! Silakan langsung checkout sebelum kehabisan ya. 📦';
    } else if (lower.contains('kirim') || lower.contains('hari ini') || lower.contains('kapan')) {
      return 'Pesanan yang masuk sebelum jam 16.00 WIB akan langsung dikirim di hari yang sama ya kak! 🚚';
    } else if (lower.contains('promo') || lower.contains('diskon') || lower.contains('kupon')) {
      return 'Gunakan kode kupon "PROMO50" di keranjang untuk mendapatkan diskon spesial hingga 50%! 🎁';
    } else if (lower.contains('foto') || lower.contains('gambar')) {
      return 'Tentu kak, silakan cek galeri produk di halaman detail. Semua foto adalah foto asli produk kami! 📸';
    } else {
      return 'Terima kasih atas pertanyaannya kak! Tim kami siap memproses pesanan Anda dengan pelayanan terbaik. 😊';
    }
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
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
      backgroundColor: const Color(0xFFF0F2FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.contactColor.withValues(alpha: 0.9),
                widget.contactColor,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.contactColor.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            titleSpacing: 0,
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: Text(
                      widget.contactName.isNotEmpty
                          ? widget.contactName[0].toUpperCase()
                          : 'T',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contactName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFF66BB6A),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Online · Membalas cepat',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.phone_rounded, color: Colors.white, size: 18),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Menghubungkan panggilan... 📞'),
                      backgroundColor: Color(0xFF4C53A5),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 18),
                ),
                onPressed: () => _showStoreInfo(context),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              itemCount: messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }

                final message = messages[index];
                final bool isMe = message['isMe'] as bool;
                final String text = message['text'] as String;
                final String time = message['time'] ?? '--:--';

                return _buildMessageBubble(isMe: isMe, text: text, time: time);
              },
            ),
          ),

          // Quick Replies
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    itemCount: _quickReplies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => _sendMessage(_quickReplies[index]),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF4C53A5).withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              _quickReplies[index],
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF4C53A5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Input Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Lampiran gambar dipilih 📎'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Color(0xFF4C53A5),
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F7FF),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFF4C53A5).withValues(alpha: 0.15),
                              ),
                            ),
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'Tulis pesan...',
                                hintStyle: TextStyle(fontSize: 14, color: Color(0xFFADB5D6)),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                isDense: true,
                                filled: false,
                              ),
                              onSubmitted: (value) => _sendMessage(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _sendMessage(),
                          child: Container(
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4C53A5).withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required bool isMe,
    required String text,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.78,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? const LinearGradient(
                          colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isMe ? null : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft:
                        isMe ? const Radius.circular(18) : const Radius.circular(4),
                    bottomRight:
                        isMe ? const Radius.circular(4) : const Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isMe
                          ? const Color(0xFF4C53A5).withValues(alpha: 0.25)
                          : Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: isMe ? Colors.white : const Color(0xFF1A1D2E),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                time,
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF4C53A5),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Mengetik...',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStoreInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [widget.contactColor, widget.contactColor.withValues(alpha: 0.7)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.contactColor.withValues(alpha: 0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.transparent,
                      child: Text(
                        widget.contactName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contactName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1D2E),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '✅ Power Merchant',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _infoTile(Icons.star_rounded, Colors.amber, 'Rating Toko: 4.9/5.0 (1.2rb ulasan)'),
              _infoTile(Icons.schedule_rounded, const Color(0xFF4C53A5), 'Jam Operasional: 08.00 – 21.00 WIB'),
              _infoTile(Icons.local_shipping_rounded, Colors.green, 'Pengiriman Hari Ini (sebelum 16.00 WIB)'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _infoTile(IconData icon, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 13, color: Color(0xFF1A1D2E)),
          ),
        ],
      ),
    );
  }
}
