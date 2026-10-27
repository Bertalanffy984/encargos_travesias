import 'package:entrecomunidad/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App muestra la pantalla inicial', (tester) async {
    await tester.pumpWidget(const EntreComunidadApp());
    expect(
      find.text('Encomiendas · Redes Comunitarias · Uniamazonia'),
      findsOneWidget,
    );
  });
}
