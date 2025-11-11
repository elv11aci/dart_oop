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

class RecurringExpense extends Expense {
  final String frequency;

  RecurringExpense({
    required String description,
    required double amount,
    required String category,
    required this.frequency,
    DateTime? date,
  }) : super(
          description: description,
          amount: amount,
          category: category,
          date: date,
        );

  // Method untuk menghitung total tahunan
  double yearlyTotal() {
    switch (frequency.toLowerCase()) {
      case 'harian':
        return amount * 365;
      case 'mingguan':
        return amount * 52;
      case 'bulanan':
        return amount * 12;
      case 'tahunan':
        return amount;
      default:
        return amount * 12; 
    }
  }

  @override
  void printDetails() {
    super.printDetails();
    print('   Frekuensi: $frequency');
    print('   Total tahunan: Rp${yearlyTotal().toStringAsFixed(2)}');
  }
}

class SubscriptionExpense extends RecurringExpense {
  String provider;
  String plan;
  DateTime startDate;
  DateTime? endDate;

  SubscriptionExpense({
    required String description,
    required double amount,
    required this.provider,
    required this.plan,
    required this.startDate,
    this.endDate,
  }) : super(
          description: description,
          amount: amount,
          category: 'Langganan',
          frequency: 'bulanan',
        );

  bool isActive() {
    DateTime now = DateTime.now();
    if (endDate == null) return true; 
    return now.isBefore(endDate!) || now.isAtSameMomentAs(endDate!);
  }

  int getRemainingMonths() {
    if (endDate == null) return -1; // Unlimited
    DateTime now = DateTime.now();
    if (now.isAfter(endDate!)) return 0;

    int months = (endDate!.year - now.year) * 12 + (endDate!.month - now.month);
    // Adjust jika endDate day is before current day
    if (endDate!.day < now.day) {
      months--;
    }
    return months.clamp(0, months); 
  }

  double getTotalCost() {
    if (endDate == null) {
     
      return yearlyTotal();
    }

    int totalMonths = (endDate!.year - startDate.year) * 12 +
        (endDate!.month - startDate.month) +
        1; // +1 untuk inklusif
    return amount * totalMonths;
  }

  @override
  void printDetails() {
    print('📱 LANGGANAN');
    print('   $description ($provider - $plan)');
    print('   Biaya: Rp${amount.toStringAsFixed(2)}/bulan');
    print('   Mulai: ${startDate.toString().split(' ')[0]}');

    if (endDate != null) {
      print('   Berakhir: ${endDate.toString().split(' ')[0]}');
      print('   Sisa: ${getRemainingMonths()} bulan');
    } else {
      print('   Berakhir: Tidak pernah (berkelanjutan)');
    }

    print('   Status: ${isActive() ? "Aktif ✅" : "Expired ❌"}');
    print('   Total biaya: Rp${getTotalCost().toStringAsFixed(2)}');
  }
}

void main() {
  var netflix = SubscriptionExpense(
    description: 'Netflix Premium',
    amount: 186000,
    provider: 'Netflix',
    plan: 'Premium 4K',
    startDate: DateTime(2024, 1, 1),
    endDate: null, 
  );

  var trial = SubscriptionExpense(
    description: 'Adobe Creative Cloud',
    amount: 800000,
    provider: 'Adobe',
    plan: 'Semua Apps',
    startDate: DateTime(2025, 9, 1),
    endDate: DateTime(2025, 12, 31),
  );

  netflix.printDetails();
  print('');
  trial.printDetails();
}