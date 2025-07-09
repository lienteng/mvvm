import 'package:flutter/material.dart';
import '../models/report_problem.dart';

class ReportProblemDetailScreen extends StatelessWidget {
  final ReportProblem? reportProblem;

  const ReportProblemDetailScreen({super.key, required this.reportProblem});

  @override
  Widget build(BuildContext context) {
    if (reportProblem == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Report Problem Detail')),
        body: const Center(child: Text('No data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Problem Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Problem Information', [
              _buildInfoRow('ID', reportProblem!.id.toString()),
              _buildInfoRow('Description', reportProblem!.description),
              _buildInfoRow('Date', reportProblem!.date),
              _buildInfoRow('Status', '${reportProblem!.status}'),
              _buildInfoRow('Created At', reportProblem!.createdAt),
            ]),
            const SizedBox(height: 16),
            _buildInfoCard('Employee Information', [
              _buildInfoRow(
                'Name',
                '${reportProblem!.scheduleDetail.employee.name} ${reportProblem!.scheduleDetail.employee.lastName}',
              ),
              _buildInfoRow(
                'Employee No',
                reportProblem!.scheduleDetail.employee.empNo,
              ),
              _buildInfoRow(
                'Email',
                reportProblem!.scheduleDetail.employee.email,
              ),
              _buildInfoRow(
                'Phone',
                reportProblem!.scheduleDetail.employee.mobilePhone,
              ),
              _buildInfoRow(
                'Duties',
                reportProblem!.scheduleDetail.employee.duties,
              ),
            ]),
            const SizedBox(height: 16),
            _buildInfoCard('Schedule Information', [
              _buildInfoRow(
                'Schedule Date',
                reportProblem!.scheduleDetail.date,
              ),
              _buildInfoRow('Start Time', reportProblem!.scheduleDetail.stTime),
              _buildInfoRow('From Time', reportProblem!.scheduleDetail.frTime),
              _buildInfoRow('To Time', reportProblem!.scheduleDetail.toTime),
            ]),
            const SizedBox(height: 16),
            _buildFilesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildFilesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attached Files',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (reportProblem!.reportProblemFiles.isEmpty)
              const Text('No files attached')
            else
              ...reportProblem!.reportProblemFiles.map(
                (file) => ListTile(
                  leading: Icon(_getFileIcon(file.fileType)),
                  title: Text(file.originalFileName),
                  subtitle: Text('${file.fileSize} bytes • ${file.fileType}'),
                  trailing: const Icon(Icons.download),
                  onTap: () {
                    // Handle file download
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
      case '.png':
        return Icons.image;
      case '.pdf':
        return Icons.picture_as_pdf;
      case '.doc':
      case '.docx':
        return Icons.description;
      default:
        return Icons.attach_file;
    }
  }
}
