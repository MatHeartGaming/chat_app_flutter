// ignore_for_file: prefer_const_constructors

import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        uid: '1', nombre: 'Matteo', email: 'matteo@gmail.com', online: true),
    Usuario(
        uid: '2', nombre: 'Michele', email: 'michele@gmail.com', online: true),
    Usuario(
        uid: '3', nombre: 'Raffaello', email: 'raff@gmail.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ),
            //Icon(Icons.check_circle, color: Colors.blue[400],),
          ),
        ],
        title: Text(
          "Mi Nombre",
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
          onPressed: () {},
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue[400] as Color,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: ((context, i) => _usuarioListTile(usuarios[i])),
      separatorBuilder: ((context, index) => Divider()),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario u) {
    return ListTile(
      title: Text(u.nombre),
      subtitle: Text(u.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(u.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: u.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) {
      setState(() {});
    }
    //_refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }
}
