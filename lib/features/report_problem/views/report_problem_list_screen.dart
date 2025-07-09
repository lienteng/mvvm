import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/core/animation/loading_animation/minimal_dotsLoader.dart';
import 'package:mvvm/core/animation/loading_animation/modern_pagination_loader.dart';
import 'package:provider/provider.dart';
import '../../../core/router/app_router.dart';
import '../models/report_problem.dart';
import '../viewmodels/report_problem_viewmodel.dart';

// Don't forget to import math
import 'dart:math' as math;

class ReportProblemListScreen extends StatefulWidget {
  const ReportProblemListScreen({super.key});

  @override
  State<ReportProblemListScreen> createState() =>
      _ReportProblemListScreenState();
}

class _ReportProblemListScreenState extends State<ReportProblemListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportProblemViewModel>().loadReportProblems(refresh: true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ReportProblemViewModel>().loadReportProblems();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<ReportProblemViewModel>().loadReportProblems(
      refresh: true,
    );
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // AppBar
              AppBar(
                title: const Text('Report Problems'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                actions: [
                  // Your existing actions
                ],
              ),
              // Content
              Expanded(
                child: Consumer<ReportProblemViewModel>(
                  builder: (context, viewModel, child) {
                    // Only show loading indicator if no data exists yet AND not refreshing
                    if (viewModel.isLoading &&
                        viewModel.reportProblems.isEmpty &&
                        !viewModel.isRefreshing) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Only show error if no data exists
                    if (viewModel.errorMessage != null &&
                        viewModel.reportProblems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error: ${viewModel.errorMessage}',
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  viewModel.loadReportProblems(refresh: true),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        // Only show refresh control if there's data or we're refreshing
                        if (viewModel.reportProblems.isNotEmpty ||
                            viewModel.isRefreshing)
                          CupertinoSliverRefreshControl(
                            onRefresh: _onRefresh,
                            builder:
                                (
                                  context,
                                  refreshState,
                                  pulledExtent,
                                  refreshTriggerPullDistance,
                                  refreshIndicatorExtent,
                                ) {
                                  return Align(
                                    alignment: Alignment.topCenter,
                                    child: MinimalDotsLoader(
                                      color: Theme.of(context).primaryColor,
                                      dotSize: 8.0,
                                      spacing: 4.0,
                                    ),
                                  );
                                },
                          ),

                        // Show loading animation above the list when refreshing
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              // Modern pagination loading - only show when scrolling down to load more (not when refreshing)
                              if (index == viewModel.reportProblems.length) {
                                // Don't show pagination loader when refreshing
                                if (viewModel.isRefreshing) {
                                  return const SizedBox.shrink();
                                }
                                return ModernPaginationLoader(
                                  size: 45.0,
                                  color: Theme.of(context).primaryColor,
                                  loadingText: "Loading more reports...",
                                );
                              }

                              final reportProblem =
                                  viewModel.reportProblems[index];
                              return ReportProblemCard(
                                reportProblem: reportProblem,
                                onTap: () => context.push(
                                  AppRouter.reportProblemDetail,
                                  extra: reportProblem,
                                ),
                              );
                            },
                            childCount: viewModel.reportProblems.length + (viewModel.hasMoreData &&!viewModel.isRefreshing? 1: 0),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    // Your existing implementation
  }
}

// Extension to add cos and sin methods to double
extension MathExtension on double {
  double get cos => math.cos(this);
  double get sin => math.sin(this);
}

void _showCreateDialog(BuildContext context) {
  final descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Create Report Problem'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (descriptionController.text.isNotEmpty) {
              context.read<ReportProblemViewModel>().createReportProblem(
                scheduleDetailId: 1, // Replace with actual schedule detail ID
                description: descriptionController.text,
                date: DateTime.now().toIso8601String().split('T')[0],
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Create'),
        ),
      ],
    ),
  );
}

class ReportProblemCard extends StatelessWidget {
  final ReportProblem reportProblem;
  final VoidCallback onTap;

  const ReportProblemCard({
    super.key,
    required this.reportProblem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          '${reportProblem.description}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee: ${reportProblem.scheduleDetail!.employee!.name}'),
            Text('Date: ${reportProblem.date}'),
            Text('Status: ${reportProblem.status}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              reportProblem.status == 'SENDED' ? Icons.send : Icons.pending,
              color: reportProblem.status == 'SENDED'
                  ? Colors.green
                  : Colors.orange,
            ),
            Text('${reportProblem.reportProblemFiles.length} files'),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
