import 'package:flutter/material.dart';
import 'bebida.dart';

class MiniaturaBebida extends StatelessWidget {
  final Bebida bebida;
  final VoidCallback onTap;

  const MiniaturaBebida({super.key, required this.bebida, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  bebida.urlImagen,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 4,),
            Center(
              child: Text(
                bebida.nombre,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
