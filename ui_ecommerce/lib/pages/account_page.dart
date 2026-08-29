import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/models/favorite_model.dart';
import 'package:ui_ecommerce/pages/item_detail_page.dart';
import 'package:ui_ecommerce/widgets/app_product_image.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _userName = 'Arhab Faiz';
  String _userEmail = 'arhabfaiz@siuuu.com';
  String _userPhone = '+62 812-3456-7890';
  String _userAddress = 'Jl. Merdeka No. 45, Jakarta Pusat';

  bool _notifPromo = true;
  bool _notifOrder = true;
  bool _notifChat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        title: const Text(
          'Akun Saya',
          style: TextStyle(
            color: Color(0xFF4C53A5),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 16),
            _buildQuickStats(),
            const SizedBox(height: 20),
            _buildMenuSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C53A5).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/arhab-faiz.jpg',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: Colors.white24,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _userEmail,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '⭐ Member Gold',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_note, color: Colors.white, size: 28),
            onPressed: _showEditProfileSheet,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return ListenableBuilder(
      listenable: FavoriteModel(),
      builder: (context, _) {
        final favCount = FavoriteModel().count;
        return Row(
          children: [
            Expanded(
              child: _buildStatItem(
                icon: Icons.favorite,
                color: Colors.redAccent,
                label: 'Favorit Saya',
                value: '$favCount Item',
                onTap: _showWishlistSheet,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatItem(
                icon: Icons.receipt_long,
                color: Colors.teal,
                label: 'Pesanan Saya',
                value: '3 Selesai',
                onTap: _showOrderHistorySheet,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            'Pengaturan & Layanan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C53A5),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildListTile(
                icon: Icons.person_outline,
                title: 'Informasi Profil',
                subtitle: 'Nama, email, telepon, dan alamat',
                onTap: _showEditProfileSheet,
              ),
              const Divider(height: 1, indent: 60),
              _buildListTile(
                icon: Icons.lock_outline,
                title: 'Ganti Kata Sandi',
                subtitle: 'Perbarui kata sandi akun secara berkala',
                onTap: _showChangePasswordDialog,
              ),
              const Divider(height: 1, indent: 60),
              _buildListTile(
                icon: Icons.notifications_none_outlined,
                title: 'Pengaturan Notifikasi',
                subtitle: 'Promo, transaksi, dan pesan',
                onTap: _showNotificationSettingsSheet,
              ),
              const Divider(height: 1, indent: 60),
              _buildListTile(
                icon: Icons.help_outline,
                title: 'Bantuan & FAQ',
                subtitle: 'Pertanyaan umum dan pusat layanan',
                onTap: _showHelpSheet,
              ),
              const Divider(height: 1, indent: 60),
              _buildListTile(
                icon: Icons.logout,
                title: 'Keluar Akun',
                subtitle: 'Keluar dari sesi saat ini',
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF4C53A5),
    Color textColor = const Color(0xFF333333),
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          : null,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 14,
      ),
      onTap: onTap,
    );
  }

  void _showEditProfileSheet() {
    final nameCtrl = TextEditingController(text: _userName);
    final emailCtrl = TextEditingController(text: _userEmail);
    final phoneCtrl = TextEditingController(text: _userPhone);
    final addrCtrl = TextEditingController(text: _userAddress);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Profil Pengguna',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nomor Telepon',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: addrCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Alamat Utama',
                    prefixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C53A5),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _userName = nameCtrl.text;
                        _userEmail = emailCtrl.text;
                        _userPhone = phoneCtrl.text;
                        _userAddress = addrCtrl.text;
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profil berhasil diperbarui!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: const Text('Simpan Perubahan'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showWishlistSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return ListenableBuilder(
          listenable: FavoriteModel(),
          builder: (context, _) {
            final favList = FavoriteModel().favoriteProducts;
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Wishlist Favorit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: favList.isEmpty
                        ? const Center(
                            child: Text(
                              'Belum ada produk favorit.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: favList.length,
                            itemBuilder: (context, index) {
                              final item = favList[index];
                              return ListTile(
                                leading: AppProductImage(
                                  imageUrl: item.image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  borderRadius: 8,
                                ),
                                title: Text(item.name),
                                subtitle: Text(
                                  item.price,
                                  style: const TextStyle(
                                    color: Color(0xFF4C53A5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_shopping_cart,
                                        color: Color(0xFF4C53A5),
                                      ),
                                      onPressed: () {
                                        CartModel().addItem(
                                          name: item.name,
                                          price: item.price,
                                          image: item.image,
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${item.name} masuk ke keranjang',
                                            ),
                                            backgroundColor: const Color(
                                              0xFF4C53A5,
                                            ),
                                            duration: const Duration(
                                              seconds: 1,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        FavoriteModel().toggle(item.name);
                                      },
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pop(ctx);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ItemDetailPage(product: item),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showOrderHistorySheet() {
    final List<Map<String, String>> orders = [
      {
        'id': '#ORD-98432',
        'date': '24 Agu 2026',
        'items': 'Outfit Casual Premium (x1)',
        'total': 'Rp 150.000',
        'status': 'Selesai',
      },
      {
        'id': '#ORD-98411',
        'date': '20 Agu 2026',
        'items': 'Brownies Fudgy Cokelat (x2)',
        'total': 'Rp 120.000',
        'status': 'Selesai',
      },
      {
        'id': '#ORD-98390',
        'date': '15 Agu 2026',
        'items': 'Skincare Glow Alami Herbal (x1)',
        'total': 'Rp 200.000',
        'status': 'Selesai',
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Riwayat Pembelian',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final ord = orders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ord['id']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    ord['status']!,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              ord['items']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ord['date']!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  ord['total']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4C53A5),
                                  ),
                                ),
                              ],
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
      },
    );
  }

  void _showChangePasswordDialog() {
    final oldPass = TextEditingController();
    final newPass = TextEditingController();
    final confirmPass = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Ganti Kata Sandi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Kata Sandi Saat Ini',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Kata Sandi Baru',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Kata Sandi Baru',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C53A5),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (newPass.text.isNotEmpty &&
                    newPass.text == confirmPass.text) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kata sandi berhasil diperbarui!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kata sandi baru tidak cocok!'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationSettingsSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pengaturan Notifikasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Promo & Diskon'),
                    subtitle: const Text('Dapatkan voucher dan promo mingguan'),
                    value: _notifPromo,
                    activeThumbColor: const Color(0xFF4C53A5),
                    onChanged: (val) {
                      setSheetState(() => _notifPromo = val);
                      setState(() => _notifPromo = val);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Status Pesanan'),
                    subtitle: const Text('Update pengiriman dan pembayaran'),
                    value: _notifOrder,
                    activeThumbColor: const Color(0xFF4C53A5),
                    onChanged: (val) {
                      setSheetState(() => _notifOrder = val);
                      setState(() => _notifOrder = val);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Pesan Penjual'),
                    subtitle: const Text('Notifikasi chat toko saat online'),
                    value: _notifChat,
                    activeThumbColor: const Color(0xFF4C53A5),
                    onChanged: (val) {
                      setSheetState(() => _notifChat = val);
                      setState(() => _notifChat = val);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showHelpSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pusat Bantuan & FAQ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: const [
                    ExpansionTile(
                      title: Text('Bagaimana cara menggunakan kupon diskon?'),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Buka keranjang belanja Anda, klik tombol "Pakai" pada bagian Kupon Promo, lalu masukkan kode seperti PROMO50 atau DISKON10.',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Berapa lama estimasi pengiriman barang?'),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Pengiriman reguler memakan waktu 1-3 hari kerja tergantung wilayah tujuan Anda.',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Bagaimana cara menghubungi penjual?'),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Klik icon pesan di bagian atas beranda atau langsung masuk ke menu Pesan & Diskusi untuk chat interaktif.',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Keluar dari Akun?'),
          content: const Text(
            'Apakah Anda yakin ingin keluar? Anda perlu login kembali untuk mengakses data Anda.',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Ya, Logout'),
            ),
          ],
        );
      },
    );
  }
}
