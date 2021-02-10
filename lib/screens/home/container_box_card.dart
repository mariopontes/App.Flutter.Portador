import 'package:flutter/material.dart';
import '../../screens/home/box_card.dart';

class ContainerCardBox extends StatelessWidget {
  const ContainerCardBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        shrinkWrap: true,
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 10 / 8,
              children: <Widget>[
                BoxCard(title: 'Bloquear Cartão'),
                BoxCard(title: 'Desbloquear Cartão'),
                BoxCard(title: 'Consultar Extrato'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
