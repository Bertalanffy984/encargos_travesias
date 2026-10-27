import 'package:entrecomunidad/core/constants/app_constants.dart';
import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/shared/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

/// Composer tipo Social-Mate / Paloma — “¿Qué quieres compartir?”.
class PostComposer extends StatelessWidget {
  const PostComposer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.blanco,
      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileAvatar(initials: 'LU', radius: 20),
                const SizedBox(width: AppConstants.spacing12),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacing16,
                        vertical: AppConstants.spacing12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.fondo,
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusExtraLarge),
                      ),
                      child: Text(
                        '¿Qué quieres compartir con tu comunidad?',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textoSecundario,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacing12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ComposerAction(
                  icon: Icons.image_outlined,
                  label: 'Foto',
                  color: AppColors.azulSistemas,
                ),
                _ComposerAction(
                  icon: Icons.event_outlined,
                  label: 'Evento',
                  color: AppColors.verdeAmazonia,
                ),
                _ComposerAction(
                  icon: Icons.article_outlined,
                  label: 'Artículo',
                  color: AppColors.rojoInstitucional,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ComposerAction extends StatelessWidget {
  const _ComposerAction({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: color),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.texto,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
