import 'package:ESPP_Rewards_App_Portador/screens/terms/terms_screen.dart';
import 'package:ESPP_Rewards_App_Portador/widgets/custom_appBar.dart';
import 'package:ESPP_Rewards_App_Portador/widgets/custom_carousel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../blocs/home_bloc.dart';
import '../../widgets/container_box_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = BlocProvider.getBloc<HomeBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String titleHeader = 'Olá, Usuário';

  @override
  void initState() {
    super.initState();
    _getToken();

    _homeBloc.outState.listen((state) {
      print(state);
      if (state == BlockState.TermosOfUse) {
        Route route = MaterialPageRoute(builder: (context) => TermsScreen());
        Navigator.push(context, route);
      } else {}
    });
  }

  Future _getToken() async {
    var decodedToken = await authBloc.getTokenDecoded();
    print('decodedToken $decodedToken');
    ////////////////////////     PRECISA SER REFATORADO     //////////////////////////
    setState(() {
      if (decodedToken != null) {
        titleHeader = '${decodedToken['given_name']}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBard.getAppBar(title: titleHeader),
      body: Container(
        color: Color.fromRGBO(108, 201, 229, 0.5),
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            CustomCarousel(),
            ContainerCardBox(),
          ],
        ),
      ),
    );
  }
}
