abstract class PaymentMethod {
  String get name;
  String get icon;
  
  bool validate();
  void processPayment(double amount);
  
  void showReceipt(double amount) {
    print('🧾 STRUK PEMBAYARAN');
    print('   Metode: $name');
    print('   Jumlah: \$${amount.toStringAsFixed(2)}');
    print('   Status: Berhasil ✅');
    print('   Waktu: ${DateTime.now().toLocal().toString().split(' ')[1]}');
  }
}

class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime? date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    this.date,
  });

  void payWith(PaymentMethod paymentMethod) {
    print('💳 MEMPROSES PEMBAYARAN');
    print('   Deskripsi: $description');
    print('   Jumlah: \$${amount.toStringAsFixed(2)}');
    print('   Kategori: $category');
    print('');
    
    paymentMethod.processPayment(amount);
  }
}

class Cryptocurrency extends PaymentMethod {
  final String walletAddress;
  final String coinType;

  Cryptocurrency({
    required this.walletAddress,
    required this.coinType,
  });

  @override
  String get name => 'Dompet $coinType';

  @override
  String get icon => '₿';

  @override
  bool validate() {
    return walletAddress.isNotEmpty && walletAddress.length >= 20;
  }

  @override
  void processPayment(double amount) {
    if (!validate()) {
      print('❌ Alamat wallet tidak valid');
      return;
    }

    print('$icon Memproses pembayaran $coinType...');
    print('   Wallet: ${walletAddress.substring(0, 6)}...${walletAddress.substring(walletAddress.length - 4)}');
    print('   ⏳ Menunggu konfirmasi blockchain...');
    

    print('   🔗 Transaksi ditambahkan ke block...');
    print('   ⛏️  Menunggu konfirmasi miner...');
    print('   ✅ Transaksi dikonfirmasi!');
    
    showReceipt(amount);
  }

  @override
  void showReceipt(double amount) {
    print('🧾 STRUK KRIPTO');
    print('   Metode: $name');
    print('   Coin: $coinType');
    print('   Jumlah: \$${amount.toStringAsFixed(2)}');
    print('   Wallet: ${walletAddress.substring(0, 8)}...${walletAddress.substring(walletAddress.length - 6)}');
    print('   Hash: ${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}');
    print('   Status: Dikonfirmasi ✅');
    print('   Waktu: ${DateTime.now().toLocal().toString().split(' ')[1]}');
  }
}

void main() {
  var btc = Cryptocurrency(
    walletAddress: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
    coinType: 'Bitcoin',
  );

  var expense = Expense(
    description: 'Pembelian online',
    amount: 250.0,
    category: 'Belanja',
  );

  expense.payWith(btc);
}