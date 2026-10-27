import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_store.dart';
import 'package:entrecomunidad/features/encomiendas/domain/encomienda.dart';
import 'package:entrecomunidad/features/encomiendas/presentation/encomienda_detail_screen.dart';
import 'package:entrecomunidad/features/encomiendas/presentation/widgets/encomienda_card.dart';
import 'package:flutter/material.dart';

/// Encomiendas que publiqué o que voy a cumplir.
class MyEncomiendasScreen extends StatelessWidget {
  const MyEncomiendasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = EncargosScope.of(context);

    return ColoredBox(
      color: InstitutionalPalette.pageBackground,
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mis encomiendas',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Publicas como habitante ${ApiConfig.solicitanteId}. '
                    'Aceptas como habitante ${ApiConfig.domiciliarioId}.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textoSecundario,
                        ),
                  ),
                ],
              ),
            ),
            const TabBar(
              labelColor: AppColors.verdeAmazonia,
              unselectedLabelColor: AppColors.textoSecundario,
              indicatorColor: AppColors.verdeAmazonia,
              tabs: [
                Tab(text: 'Publiqué'),
                Tab(text: 'Voy a llevar'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _List(
                    items: store.publicadas,
                    mode: DetailMode.publicador,
                    onRefresh: () => store.refresh(silencioso: true),
                  ),
                  _List(
                    items: store.asignadas,
                    mode: DetailMode.cumplidor,
                    onRefresh: () => store.refresh(silencioso: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.items,
    required this.mode,
    required this.onRefresh,
  });

  final List<Encomienda> items;
  final DetailMode mode;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'Aún no hay encomiendas aquí',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textoSecundario,
              ),
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.verdeAmazonia,
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return EncomiendaCard(
            encomienda: item,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => EncomiendaDetailScreen(
                    encomienda: item,
                    mode: mode,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
