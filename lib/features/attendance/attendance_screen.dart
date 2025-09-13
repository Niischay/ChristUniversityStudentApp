import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// No longer needed: import 'package:go_router/go_router.dart';

import '../common/providers.dart';
import '../../data/models/attendance.dart';
import '../common/main_drawer.dart'; // 1. ADD THIS IMPORT

class AttendanceScreen extends ConsumerWidget {
	const AttendanceScreen({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(
			appBar: AppBar(title: const Text('Attendance')),
			drawer: const MainDrawer(), // 2. UPDATE THIS LINE
			body: _AttendanceContent(),
		);
	}
}

class _AttendanceContent extends ConsumerWidget {
	@override
	Widget build(BuildContext context, WidgetRef ref) {
		// Mock data for now - will be replaced with real Supabase queries
		final summary = AttendanceSummary(total: 408, attended: 386, percentage: 94.66);
		final subjects = [
			SubjectAttendance(code: 'CS501', name: 'Compiler Design', totalClasses: 45, attendedClasses: 42, percentage: 93.33),
			SubjectAttendance(code: 'CS502', name: 'Design Patterns', totalClasses: 42, attendedClasses: 41, percentage: 97.62),
			SubjectAttendance(code: 'CS503', name: 'Internet of Things', totalClasses: 38, attendedClasses: 36, percentage: 94.74),
			SubjectAttendance(code: 'CS504', name: 'UI/UX Design', totalClasses: 40, attendedClasses: 37, percentage: 92.50),
		];

		return ListView(
			padding: const EdgeInsets.all(16),
			children: [
				_AttendanceSummaryCard(summary: summary),
				const SizedBox(height: 24),
				...subjects.map((subject) => _SubjectAttendanceCard(subject: subject)),
			],
		);
	}
}

class _AttendanceSummaryCard extends StatelessWidget {
	final AttendanceSummary summary;

	const _AttendanceSummaryCard({required this.summary});

	@override
	Widget build(BuildContext context) {
		final color = Theme.of(context).colorScheme;
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(24),
				child: Column(
					children: [
						Text(
							'Overall Attendance',
							style: Theme.of(context).textTheme.titleLarge?.copyWith(
								fontWeight: FontWeight.w600,
							),
						),
						const SizedBox(height: 24),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: [
								_SummaryCircle(
									label: 'Total',
									value: summary.total.toString(),
									color: color.primary,
								),
								_SummaryCircle(
									label: 'Attended',
									value: summary.attended.toString(),
									color: color.secondary,
								),
								_SummaryCircle(
									label: 'Overall %',
									value: '${summary.percentage.toStringAsFixed(1)}%',
									color: _getAttendanceColor(summary.percentage),
									isPercentage: true,
									percentage: summary.percentage / 100,
								),
							],
						),
					],
				),
			),
		);
	}

	Color _getAttendanceColor(double percentage) {
		if (percentage >= 85) return const Color(0xFF2E7D32); // Green
		if (percentage >= 75) return const Color(0xFFF9A825); // Amber
		return const Color(0xFFD32F2F); // Red
	}
}

class _SummaryCircle extends StatelessWidget {
	final String label;
	final String value;
	final Color color;
	final bool isPercentage;
	final double? percentage;

	const _SummaryCircle({
		required this.label,
		required this.value,
		required this.color,
		this.isPercentage = false,
		this.percentage,
	});

	@override
	Widget build(BuildContext context) {
		return Column(
			children: [
				if (isPercentage && percentage != null)
					CircularPercentIndicator(
						radius: 40,
						lineWidth: 8,
						percent: percentage!,
						center: Text(
							value,
							style: Theme.of(context).textTheme.titleMedium?.copyWith(
								fontWeight: FontWeight.bold,
								color: color,
							),
						),
						progressColor: color,
						backgroundColor: color.withOpacity(0.2),
					)
				else
					CircleAvatar(
						radius: 40,
						backgroundColor: color.withOpacity(0.1),
						child: Text(
							value,
							style: Theme.of(context).textTheme.titleMedium?.copyWith(
								fontWeight: FontWeight.bold,
								color: color,
							),
						),
					),
				const SizedBox(height: 8),
				Text(
					label,
					style: Theme.of(context).textTheme.bodyMedium?.copyWith(
						color: Theme.of(context).colorScheme.onSurfaceVariant,
					),
				),
			],
		);
	}
}

class _SubjectAttendanceCard extends StatelessWidget {
	final SubjectAttendance subject;

	const _SubjectAttendanceCard({required this.subject});

	@override
	Widget build(BuildContext context) {
		final color = _getAttendanceColor(subject.percentage ?? 0);
		return Card(
			margin: const EdgeInsets.only(bottom: 12),
			child: ExpansionTile(
				title: Text(
					subject.name,
					style: Theme.of(context).textTheme.titleMedium?.copyWith(
						fontWeight: FontWeight.w500,
					),
				),
				subtitle: Text(subject.code),
				trailing: Container(
					padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
					decoration: BoxDecoration(
						color: color.withOpacity(0.1),
						borderRadius: BorderRadius.circular(12),
					),
					child: Text(
						'${subject.percentage?.toStringAsFixed(1)}%',
						style: TextStyle(
							color: color,
							fontWeight: FontWeight.w600,
						),
					),
				),
				children: [
					Padding(
						padding: const EdgeInsets.all(16),
						child: Column(
							children: [
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										const Text('Total Classes:'),
										Text('${subject.totalClasses}'),
									],
								),
								const SizedBox(height: 8),
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										const Text('Attended:'),
										Text('${subject.attendedClasses}'),
									],
								),
								const SizedBox(height: 8),
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										const Text('Absent:'),
										Text('${subject.totalClasses - subject.attendedClasses}'),
									],
								),
								const SizedBox(height: 16),
								Container(
									padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
									decoration: BoxDecoration(
										color: color.withOpacity(0.1),
										borderRadius: BorderRadius.circular(16),
									),
									child: Text(
										_getAttendanceStatus(subject.percentage ?? 0),
										style: TextStyle(
											color: color,
											fontWeight: FontWeight.w500,
										),
									),
								),
							],
						),
					),
				],
			),
		);
	}

	Color _getAttendanceColor(double percentage) {
		if (percentage >= 85) return const Color(0xFF2E7D32); // Green
		if (percentage >= 75) return const Color(0xFFF9A825); // Amber
		return const Color(0xFFD32F2F); // Red
	}

	String _getAttendanceStatus(double percentage) {
		if (percentage >= 85) return 'On Track';
		if (percentage >= 75) return 'Warning';
		return 'Low Attendance';
	}
}
