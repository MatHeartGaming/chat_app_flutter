// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  List<ChateMessage> _messages = [];
  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[400],
              maxRadius: 14,
              child: Text('Te', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Melissa Flores",
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (context, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              height: 100,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration.collapsed(
                  hintText: "Mensaje",
                ),
                focusNode: _focusNode,
                onSubmitted: _handleSumbit,
                onChanged: (texto) {
                  if (texto.trim().isNotEmpty) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                  setState(() {});
                },
              ),
            ),

            // Boton de enviar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: (Platform.isIOS || Platform.isMacOS)
                  ? CupertinoButton(
                      onPressed: _estaEscribiendo
                          ? () => _handleSumbit(_textController.text)
                          : null,
                      child: Text("Enviar"),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                            color: _estaEscribiendo
                                ? Colors.blue[400]
                                : Colors.grey,
                          ),
                          onPressed: _estaEscribiendo
                              ? () => _handleSumbit(_textController.text)
                              : null,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSumbit(String texto) {
    if (texto.isEmpty) {
      return;
    }
    _textController.clear();
    _focusNode.requestFocus();
    _estaEscribiendo = false;

    final newMessage = ChateMessage(
      texto: texto,
      uid: "123",
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Off del socket
    for (ChateMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
