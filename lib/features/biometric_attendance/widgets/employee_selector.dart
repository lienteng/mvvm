import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeeSelector extends StatelessWidget {
  final List<Employee> employees;
  final Employee? selectedEmployee;
  final Function(Employee) onEmployeeSelected;

  const EmployeeSelector({
    super.key,
    required this.employees,
    required this.selectedEmployee,
    required this.onEmployeeSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text(
                'No employees available',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                'Please check your connection and try again',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_search,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Select Your Name',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Dropdown for employee selection
            DropdownButtonFormField<Employee>(
              value: selectedEmployee,
              decoration: const InputDecoration(
                labelText: 'Choose your name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              items: employees.map((employee) {
                return DropdownMenuItem<Employee>(
                  value: employee,
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Text(
                  //       employee.name,
                  //       style: const TextStyle(fontWeight: FontWeight.w500),
                  //     ),
                  //     Text(
                  //       '${employee.empNo} • ${employee.department}',
                  //       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  //     ),
                  //   ],
                  // ),
                  child: Text(
                    '${employee.empNo} • ${employee.name}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (Employee? employee) {
                if (employee != null) {
                  onEmployeeSelected(employee);
                }
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select your name';
                }
                return null;
              },
            ),

            // Selected employee info
            if (selectedEmployee != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Text(
                        selectedEmployee!.name.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedEmployee!.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'ID: ${selectedEmployee!.empNo}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Department: ${selectedEmployee!.department}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.check_circle, color: Colors.green.shade700),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
