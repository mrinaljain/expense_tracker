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
      isScrollControlled: true,
      builder: (BuildContext ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense Deleted'),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              /// insert and add are same , just that insert takes specific index
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

//5. Add build method inside the Stateclass
  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(
      child: Text('No expenses found, start adding some..'),
    );
    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
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
            child: maincontent,
          )
        ],
      ),
    );
  }
}
