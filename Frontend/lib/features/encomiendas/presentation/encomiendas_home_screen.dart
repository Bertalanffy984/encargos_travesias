import 'package:entrecomunidad/core/theme/app_colors.dart';
import 'package:entrecomunidad/core/theme/institutional_palette.dart';
import 'package:entrecomunidad/features/encomiendas/data/encargos_store.dart';
import 'package:entrecomunidad/features/encomiendas/presentation/encomienda_detail_screen.dart';
import 'package:entrecomunidad/features/encomiendas/presentation/widgets/encomienda_card.dart';
import 'package:flutter/material.dart';

/// Listado de encomiendas abiertas — rol cumplidor (quien lleva el paquete).
class EncomiendasHomeScreen extends StatefulWidget {
  const EncomiendasHomeScreen({super.key});

  @override
  State<EncomiendasHomeScreen> createState() => _EncomiendasHomeScreenState();
}

class _EncomiendasHomeScreenState extends State<EncomiendasHomeScreen> {
  int _filter = 0;
  static const _filters = ['Recientes', 'Mejor pago'];

  @override
  Widget build(BuildContext context) {
    final store = EncargosScope.of(context);
    final items = [...store.disponibles];
    if (_filter == 1) {
      items.sort((a, b) => b.pagoOfertado.compareTo(a.pagoOfertado));
    }

    return ColoredBox(
      color: InstitutionalPalette.pageBackground,
      child: RefreshIndicator(
        color: AppColors.verdeAmazonia,
        onRefresh: () => store.refresh(silencioso: true),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solicitudes · Travecias',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Encargos disponibles en la base. Ábrelos para aceptarlos.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textoSecundario,
                          ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filters.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final selected = _filter == index;
                          return FilterChip(
                            label: Text(_filters[index]),
                            selected: selected,
                            showCheckmark: false,
                            onSelected: (_) => setState(() => _filter = index),
                            labelStyle: TextStyle(
                              fontWeight:
                                  selected ? FontWeight.w600 : FontWeight.w500,
                              color: selected
                                  ? AppColors.verdeAmazonia
                                  : AppColors.textoSecundario,
                            ),
                            backgroundColor: AppColors.blanco,
                            selectedColor:
                                AppColors.verdeAmazonia.withValues(alpha: 0.12),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (store.error != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(
                    store.error!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.rojoInstitucional,
                        ),
                  ),
                ),
              ),
            if (store.cargando && items.isEmpty)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (items.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No hay solicitudes disponibles',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textoSecundario,
                        ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                sliver: SliverList.separated(
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
                              mode: DetailMode.cumplidor,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
