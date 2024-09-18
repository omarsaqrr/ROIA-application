import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String message) {
    setState(() {
      _messages.add({"user": "You", "message": message});
      _messages.add({"user": "Agent", "message": "Thank you for reaching out. How can I assist you today?"});
    });
    _controller.clear();
    // Scroll to the bottom of the list
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final messageIndex = _messages.length - 1 - index; // Reverse the index
                final message = _messages[messageIndex];
                final isUser = message['user'] == "You";

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['user']!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(message['message']!),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Type a message",
                      filled: true,
                      fillColor: Colors.lightBlue[50], // Customize the fill color here
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
