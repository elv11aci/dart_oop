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

class TravelExpense extends Expense {
  String destination;
  int tripDuration;

  TravelExpense({
    required String description,
    required double amount,
    required this.destination,
    required this.tripDuration,
    DateTime? date,
  }) : super(
          description: description,
          amount: amount,
          category: 'Perjalanan',
          date: date ?? DateTime.now(),
        );

  double getDailyCost() {
    if (tripDuration == 0) return amount;
    return amount / tripDuration;
  }

  bool isInternational() {
  
    return destination.contains('Jepang') ||
           destination.contains('Singapura') ||
           destination.contains('Malaysia') ||
           destination.contains('Korea') ||
           destination.contains('Thailand') ||
           destination.contains('USA') ||
           destination.contains('Amerika');
  }

  @override
  void printDetails() {
    print('✈️ PENGELUARAN PERJALANAN');
    super.printDetails();
    print('   Destinasi: $destination');
    print('   Durasi: $tripDuration hari');
    print('   Biaya harian: Rp${getDailyCost().toStringAsFixed(2)}');
    print('   Internasional: ${isInternational() ? "Ya 🌍" : "Tidak 🏠"}');
  }
}

void main() {
  var trip = TravelExpense(
    description: 'Liburan Tokyo',
    amount: 25000000.0,
    destination: 'Tokyo, Jepang',
    tripDuration: 7,
  );

  trip.printDetails();
}