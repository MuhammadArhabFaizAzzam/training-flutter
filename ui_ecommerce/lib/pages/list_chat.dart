import 'package:flutter/material.dart';
import 'package:ui_ecommerce/pages/detail_chat.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  // Data daftar chat
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Nike Official',
      'message': 'Segera Memesan Sebelum Kehabisan.',
      'time': '12:30',
      'avatar': 'assets/images/7.jpg',
      'isRead': false, // Belum dibaca
    },
    {
      'name': 'Expander',
      'message': 'Hallo, Selamat Datang Di Nike Official.',
      'time': '12:05',
      'avatar': 'assets/images/5.jpg',
      'isRead': true, // Sudah dibaca
    },
    {
      'name': 'Adidas Store',
      'message': 'Promo spesial untuk member!',
      'time': '11:45',
      'avatar': 'assets/images/8.jpg',
      'isRead': false,
    },
    {
      'name': 'Puma Official',
      'message': 'Pengiriman barang sedang diproses.',
      'time': '10:20',
      'avatar': 'assets/images/9.jpg',
      'isRead': true,
    },
    {
      'name': 'Zara Fashion',
      'message': 'Koleksi terbaru sudah tersedia!',
      'time': '09:15',
      'avatar': 'assets/images/10.jpg',
      'isRead': false,
    },
    {
      'name': 'Uniqlo Indonesia',
      'message': 'Terima kasih telah berbelanja.',
      'time': '08:30',
      'avatar': 'assets/images/11.jpg',
      'isRead': true,
    },
  ];

  // Filter status
  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan pilihan
    List<Map<String, dynamic>> filteredChats = chats;
    if (_selectedFilter == 'Belum Dibaca') {
      filteredChats = chats.where((chat) => chat['isRead'] == false).toList();
    }

    return Scaffold(
      // ============ APP BAR ============
      appBar: AppBar(
        title: const Text(
          'List Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF4C53A5),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Fungsi search
              showSearch(
                context: context,
                delegate: ChatSearchDelegate(chats),
              );
            },
          ),
        ],
      ),
      
      body: Column(
        children: [
          // ============ TOMBOL FILTER ============
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                // Filter Semua
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedFilter = 'Semua';
                    });
                  },
                  child: Text(
                    'Semua',
                    style: TextStyle(
                      color: _selectedFilter == 'Semua' 
                          ? const Color(0xFF4C53A5) 
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                
                // Filter Belum Dibaca
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedFilter = 'Belum Dibaca';
                    });
                  },
                  child: Text(
                    'Belum Dibaca',
                    style: TextStyle(
                      color: _selectedFilter == 'Belum Dibaca' 
                          ? const Color(0xFF4C53A5) 
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                
                // Jumlah chat
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C53A5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${filteredChats.length} Chat',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1, thickness: 1),
          
          // ============ LIST VIEW CHAT ============
          // Flutter equivalent dari ListView dengan OnItemClickListener
          Expanded(
            child: filteredChats.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Tidak ada chat',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Semua chat sudah dibaca',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];
                      final isRead = chat['isRead'] as bool;
                      
                      // Flutter equivalent dari OnItemClickListener
                      return InkWell(
                        onTap: () {
                          // Navigasi ke ChatDetail (Toast di Flutter = SnackBar)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Chat clicked: ${chat['name']}'),
                              duration: const Duration(seconds: 2),
                              backgroundColor: const Color(0xFF4C53A5),
                            ),
                          );
                          
                          // Navigasi ke halaman detail chat
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailPage(
                                contactName: chat['name']!,
                                contactAvatar: chat['avatar']!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16, 
                            vertical: 12
                          ),
                          decoration: BoxDecoration(
                            color: isRead ? Colors.white : const Color(0xFFF5F5FF),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // ============ AVATAR ============
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    chat['avatar']!,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              
                              // ============ NAMA DAN PESAN ============
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          chat['name']!,
                                          style: TextStyle(
                                            fontWeight: isRead 
                                                ? FontWeight.normal 
                                                : FontWeight.bold,
                                            fontSize: 16,
                                            color: const Color(0xFF4C53A5),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          chat['time']!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isRead 
                                                ? Colors.grey 
                                                : const Color(0xFF4C53A5),
                                            fontWeight: isRead 
                                                ? FontWeight.normal 
                                                : FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            chat['message']!,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isRead 
                                                  ? Colors.grey[600] 
                                                  : Colors.black87,
                                              fontWeight: isRead 
                                                  ? FontWeight.normal 
                                                  : FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        // Ikon merah untuk chat belum dibaca
                                        if (!isRead)
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ============ SEARCH DELEGATE ============
class ChatSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> chats;

  ChatSearchDelegate(this.chats);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = chats.where((chat) {
      return chat['name']!.toLowerCase().contains(query.toLowerCase()) ||
          chat['message']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final chat = results[index];
        return ListTile(
          leading: ClipOval(
            child: Image.asset(
              chat['avatar']!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person);
              },
            ),
          ),
          title: Text(chat['name']!),
          subtitle: Text(chat['message']!),
          trailing: Text(chat['time']!),
          onTap: () {
            close(context, null);
            // Navigasi ke detail chat
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailPage(
                  contactName: chat['name']!,
                  contactAvatar: chat['avatar']!,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = chats.where((chat) {
      return chat['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final chat = suggestions[index];
        return ListTile(
          leading: ClipOval(
            child: Image.asset(
              chat['avatar']!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person);
              },
            ),
          ),
          title: Text(chat['name']!),
          subtitle: Text(chat['message']!),
          trailing: Text(chat['time']!),
          onTap: () {
            query = chat['name']!;
            showResults(context);
          },
        );
      },
    );
  }
}
