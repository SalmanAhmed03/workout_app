import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGPTScreen extends StatefulWidget {
  @override
  _ChatGPTScreenState createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();
//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
  Future<String> sendMessageToChatGpt(String message) async {
    final apiKey = "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"; // Replace with your OpenAI GPT-3.5 API key
    final uri = Uri.https('api.openai.com','/v1/completions');

    final body = {
      'model':'text-davinci-003',
      "prompt": message,
      'temperature':1,
      "max_tokens": 4000,
      'top_p':1,
      'frequency_penalty':0.0,
      'presence_penalty':0.0, // Adjust as needed
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: json.encode(body),
    );

    final parsedResponse = json.decode(response.body);

    if (parsedResponse.containsKey('choices')) {
      final reply = parsedResponse['choices'][0]['text'];
      return reply;
    } else {
      print(parsedResponse);
      return 'Error: Unexpected response format';
    }
  }

  void _handleSendMessage() async {
    final userMessage = _textEditingController.text;

    // Clear the text input field
    _textEditingController.clear();

    final userChatMessage = Message(
      text: userMessage,
      isUser: true,
    );

    setState(() {
      _messages.add(userChatMessage);
    });

    final gptReply = await sendMessageToChatGpt(userMessage);

    final gptChatMessage = Message(
      text: gptReply,
      isUser: false,
    );

    setState(() {
      _messages.add(gptChatMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: (_) => _handleSendMessage(),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _handleSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: message.isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isUser ? 'You' : 'GPT-3.5',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message.text),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({
    required this.text,
    required this.isUser,
  });
}
