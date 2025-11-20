import 'package:flutter/material.dart';

import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_typography.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.subtitle,
    this.actions,
    this.padding = const EdgeInsets.all(20),
    this.margin = const EdgeInsets.only(bottom: 16),
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget child;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.textTheme.titleLarge),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: AppTypography.textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                if (actions != null)
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: actions!,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}

class KpiTile extends StatelessWidget {
  const KpiTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.caption,
    this.color = AppColors.primary,
  });

  final String label;
  final String value;
  final String? caption;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: AppTypography.textTheme.bodySmall),
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style:
                  AppTypography.textTheme.headlineSmall?.copyWith(color: color),
            ),
            if (caption != null) ...[
              const SizedBox(height: 4),
              Text(caption!, style: AppTypography.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor = AppColors.backgroundMuted,
    this.foregroundColor = AppColors.onBackground,
  });

  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: foregroundColor),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTypography.textTheme.labelMedium
                ?.copyWith(color: foregroundColor),
          ),
        ],
      ),
    );
  }
}

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
  });

  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.textTheme.bodySmall,
            ),
          ),
          Text(
            value,
            style: AppTypography.textTheme.titleSmall,
          ),
          if (trailing != null) ...[
            const SizedBox(width: 12),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class ProcessTimeline extends StatelessWidget {
  const ProcessTimeline({
    super.key,
    required this.steps,
    required this.currentIndex,
  });

  final List<String> steps;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final label = entry.value;
            final bool isCompleted = index < currentIndex;
            final bool isActive = index == currentIndex;
            final Color dotColor = isCompleted || isActive
                ? AppColors.primary
                : AppColors.outlineSoft;

            return Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      if (index != 0)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isCompleted
                                ? AppColors.primary
                                : AppColors.outlineSoft,
                          ),
                        ),
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color:
                              isActive ? AppColors.primary : AppColors.surface,
                          border: Border.all(color: dotColor, width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: isCompleted
                            ? const Icon(Icons.check,
                                size: 12, color: Colors.white)
                            : null,
                      ),
                      if (index != steps.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isActive
                                ? AppColors.primary
                                : AppColors.outlineSoft,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppTypography.textTheme.labelSmall?.copyWith(
                      color: isActive || isCompleted
                          ? AppColors.primary
                          : AppColors.onSurface.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
