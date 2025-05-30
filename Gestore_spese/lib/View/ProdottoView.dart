import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/Prodotto.dart';

class ProdottoView extends StatelessWidget {
  final Prodotto prodotto;
  final IconData icona;
  final VoidCallback? onTap;
  final double? height;

  const ProdottoView({
    Key? key,
    required this.prodotto,
    required this.icona,
    this.onTap,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final widgetHeight = height ?? 84;

    return SizedBox(
      width: double.infinity,
      height: widgetHeight,
      child: Card(
        color:Colors.white,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: (widgetHeight - 24) / 2,
                  backgroundColor:Color(0xFFFE6D73).withOpacity(0.1),
                  child: Icon(
                    icona,
                    size: widgetHeight * 0.35,
                    color: Color(0xFFFE6D73),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prodotto.nomeprodotto,
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFCB77),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          prodotto.c.nomeCategoria,
                          style: textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '€${prodotto.prezzo.toStringAsFixed(2)}',
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


