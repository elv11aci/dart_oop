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

  // Method printDetails yang akan di-override oleh subclass
  void printDetails() {
    print('📋 DETAIL PENGELUARAN');
    print('   Deskripsi: $description');
    print('   Jumlah: Rp${amount.toStringAsFixed(2)}');
    print('   Kategori: $category');
    if (date != null) {
      print('   Tanggal: ${date!.toLocal().toString().split(' ')[0]}');
    }
  }
}

class BusinessExpense extends Expense {
  String client;
  bool isReimbursable;

  BusinessExpense({
    required String description,
    required double amount,
    required String category,
    required this.client,
    this.isReimbursable = true,
  }) : super(
          description: description,
          amount: amount,
          category: category,
          date: DateTime.now(),
        );

  @override
  void printDetails() {
    print('💼 PENGELUARAN BISNIS');
    super.printDetails();
    print('   Klien: $client');
    print('   Bisa di-reimburse: ${isReimbursable ? "Ya ✅" : "Tidak ❌"}');
  }
}

void main() {
  var expense = BusinessExpense(
    description: 'Makan siang klien',
    amount: 85.0,
    category: 'Makan',
    client: 'PT Acme',
    isReimbursable: true,
  );

  expense.printDetails();
}