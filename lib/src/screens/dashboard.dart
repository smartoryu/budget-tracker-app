import 'package:flutter/material.dart';

import '../models/budget_item.dart';
import '../repository/budget.dart';
import '../utils/utils.dart';
import 'spending_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<BudgetItem>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = BudgetRepository().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _futureData = BudgetRepository().getItems();
          setState(() {});
        },
        child: FutureBuilder<List<BudgetItem>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final items = snapshot.data!;

              return ListView.builder(
                itemCount: items.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) return SpendingChart(items: items);

                  final item = items[index - 1];
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 2.0,
                        color: getCategoryColor(item.category),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                        '${item.category} • ${Format.date(
                          item.date,
                          "dd/MM/yyyy",
                        )}',
                      ),
                      trailing: Text(Format.currency(item.price)),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }
            return const Center(child: Text("Data not found"));
          },
        ),
      ),
    );
  }
}
