import 'package:flutter/material.dart';

import '../../shared/CirclePainter.dart';
import '../../shared/appbar.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return appBar(
      context,
      drawer: false,
      titulo: 'Xcard ',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Center(
            heightFactor: 1,
            child: Wrap(
              children: <Widget>[
                ItemMenuPrincipal(
                  icon: Icons.calendar_today,
                  text: 'Cadastrar cliente',
                  onTap: () => Navigator.pushNamed(context, 'CadastroCliente'),
                  isEnable: true,
                ),
                ItemMenuPrincipal(
                  icon: Icons.list,
                  text: 'Cadastrar Usuario',
                  onTap: () => Navigator.pushNamed(context, 'CadastroUsuario'),
                  isEnable: true,
                ),
                ItemMenuPrincipal(
                  // icon: Icons.timelapse, text: 'Resultados: Horas'),
                  icon: Icons.assessment,
                  text: 'criação de modelo PDF',
                  onTap: () =>
                      Navigator.pushNamed(context, 'CadastroModeloPDF'),
                  isEnable: true,
                ),
                ItemMenuPrincipal(
                  icon: Icons.timeline,
                  text: 'Criador de Cartao PDF',
                  onTap: () => Navigator.pushNamed(context, 'geradorPDF'),
                  isEnable: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemMenuPrincipal extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isEnable;
  final Color disabledColor = Colors.grey.withOpacity(0.5);
  final Function()? onTap;

  ItemMenuPrincipal(
      {required this.icon,
      required this.text,
      this.isEnable = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final double containerSize = MediaQuery.of(context).size.width * 0.38;
    double padding;

    if (containerSize > 140)
      padding = 8.0;
    else
      padding = 0;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            // color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomPaint(
                  painter: CirclePainter(
                      completeColor: isEnable
                          ? Theme.of(context).primaryColor
                          : disabledColor,
                      completePercent: 90.0,
                      width: 4.0),
                  child: Container(
                    width: containerSize * 0.6,
                    height: containerSize * 0.6,
                    child: Icon(
                      icon,
                      color: isEnable
                          ? Theme.of(context).colorScheme.secondary
                          : disabledColor,
                      size: containerSize * 7 / 30,
                    ),
                  ),
                ),
                Container(
                  height: containerSize / 3.89,
                  child: Center(
                    child: Text(
                      text,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isEnable
                              ? Theme.of(context).colorScheme.secondary
                              : disabledColor,
                          fontSize: containerSize / 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
