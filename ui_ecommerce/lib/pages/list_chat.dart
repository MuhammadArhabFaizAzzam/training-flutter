import 'package:flutter/material.dart';
import 'package:ui_ecommerce/pages/detail_chat.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final List<Map<String, dynamic>> chats = [
    {
      'id': '1',
      'name': 'EcoGlobal Official Store',
      'message': 'Halo! Ada promo menarik untuk produk kue & fashion hari ini.',
      'time': '12:30',
      'unreadCount': 2,
      'isRead': false,
      'color': const Color(0xFF4C53A5),
      'emoji': '🏪',
    },
    {
      'id': '2',
      'name': 'Nike Official Store',
      'message': 'Pesanan Outfit Casual Anda sedang kami kemas.',
      'time': '11:45',
      'unreadCount': 1,
      'isRead': false,
      'color': const Color(0xFFE65100),
      'emoji': '👟',
    },
    {
      'id': '3',
      'name': 'Dapur Kue Manis',
      'message': 'Kue bolu dan brownies fudgy baru saja matang & siap kirim.',
      'time': '10:20',
      'unreadCount': 0,
      'isRead': true,
      'color': const Color(0xFF2E7D32),
      'emoji': '🍰',
    },
    {
      'id': '4',
      'name': 'Glow Skincare Official',
      'message': 'Terima kasih telah berkonsultasi mengenai tipe kulit Anda.',
      'time': '09:15',
      'unreadCount': 0,
      'isRead': true,
      'color': const Color(0xFFC2185B),
      'emoji': '✨',
    },
    {
      'id': '5',
      'name': 'Gadget Universe',
      'message': 'Garansi resmi 1 tahun berlaku sejak produk diterima.',
      'time': 'Kemarin',
      'unreadCount': 0,
      'isRead': true,
      'color': const Color(0xFF1565C0),
      'emoji': '📱',
    },
  ];

  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredChats = chats;
    if (_selectedFilter == 'Belum Dibaca') {
      filteredChats = chats.where((chat) => chat['isRead'] == false).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3A4196), Color(0xFF4C53A5)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x334C53A5),
                blurRadius: 10,
                offset: Offset(0, 3),
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
            title: const Text(
              'Pesan & Diskusi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.search_rounded, color: Colors.white, size: 20),
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ChatSearchDelegate(chats, (chatId) {
                      setState(() {
                        final index = chats.indexWhere((c) => c['id'] == chatId);
                        if (index != -1) {
                          chats[index]['isRead'] = true;
                          chats[index]['unreadCount'] = 0;
                        }
                      });
                    }),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _buildFilterChip('Semua'),
                const SizedBox(width: 8),
                _buildFilterChip('Belum Dibaca'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${filteredChats.length} percakapan',
                    style: const TextStyle(
                      color: Color(0xFF4C53A5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          // List
          Expanded(
            child: filteredChats.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];
                      return _buildChatTile(context, chat);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, Map<String, dynamic> chat) {
    final bool isRead = chat['isRead'] as bool;
    final Color avatarColor = chat['color'] as Color? ?? const Color(0xFF4C53A5);

    return InkWell(
      onTap: () {
        setState(() {
          chat['isRead'] = true;
          chat['unreadCount'] = 0;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              contactName: chat['name']!,
              contactColor: avatarColor,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: isRead ? Colors.white : const Color(0xFFF3F4FD),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [avatarColor, avatarColor.withValues(alpha: 0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: avatarColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.transparent,
                  child: Text(
                    chat['emoji'] ?? _getInitials(chat['name']!),
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            chat['name']!,
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                              fontSize: 14.5,
                              color: const Color(0xFF1A1D2E),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          chat['time']!,
                          style: TextStyle(
                            fontSize: 11,
                            color: isRead ? Colors.grey[400] : const Color(0xFF4C53A5),
                            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat['message']!,
                            style: TextStyle(
                              fontSize: 13,
                              color: isRead ? Colors.grey[500] : const Color(0xFF1A1D2E),
                              fontWeight: isRead ? FontWeight.normal : FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        if (!isRead && (chat['unreadCount'] ?? 0) > 0)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${chat['unreadCount']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 60,
              color: Color(0xFF4C53A5),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Tidak ada pesan',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1A1D2E),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Semua pesan akan muncul di sini',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                )
              : null,
          color: isSelected ? null : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF4C53A5).withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (name.isNotEmpty) {
      return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'EG';
  }
}

class ChatSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> chats;
  final Function(String id) onOpenChat;

  ChatSearchDelegate(this.chats, this.onOpenChat);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildChatList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildChatList(context);

  Widget _buildChatList(BuildContext context) {
    final results = chats.where((chat) {
      return chat['name']!.toLowerCase().contains(query.toLowerCase()) ||
          chat['message']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'Tidak ditemukan untuk "$query"',
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final chat = results[index];
        final Color avatarColor =
            chat['color'] as Color? ?? const Color(0xFF4C53A5);

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: avatarColor,
            child: Text(
              chat['emoji'] ?? chat['name']![0].toUpperCase(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          title: Text(
            chat['name']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            chat['message']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            chat['time']!,
            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
          ),
          onTap: () {
            onOpenChat(chat['id']!);
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailPage(
                  contactName: chat['name']!,
                  contactColor: avatarColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
