// 2. Add import yo material dart
import 'package:expense_tracker/data/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

// 1. class Expense extends the Statefull widget
class ExpensesScreen extends StatefulWidget {
  //6. Create a constructor
  const ExpensesScreen({super.key});
//3. Add create state method for statefull widget, which will return State of type StatefullWidget

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

//4. Statefull widgets are made by the help of 2 classes  1.) widget class 2.) Stateclass
// so we create the stateclass with below name

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = expenseList;
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) => const NewExpense(),
    );
  }

//5. Add build method inside the Stateclass
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
            ),
          )
        ],
      ),
    );
  }
}
