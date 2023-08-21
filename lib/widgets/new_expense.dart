import 'package:expense_tracker/models/expense.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
   
  });
  final Function(Expense expense) onAddExpense;
 
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });

    // if (kDebugMode) {
    print(pickedDate);
    // }
  }

  void _submitExpenseData() {
    ///double.tryparse takes a string as input and then returns double if it is able to else returns null
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please Make sure a valid Title, Date , amount and category was entered'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    final newExpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$',
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
