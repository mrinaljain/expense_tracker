import 'package:expense_tracker/models/expense.dart';

 final expenseList = [
  Expense(
    title: 'Mall shopping',
    amount: 30,
    date: DateTime.now(),
    category: Category.food,
  ),
  Expense(
    title: 'Flutter Course',
    amount: 300,
    date: DateTime.now(),
    category: Category.work,
  ),
  Expense(
    title: 'Movie',
    amount: 600,
    date: DateTime.now(),
    category: Category.leisure,
  ),
];
