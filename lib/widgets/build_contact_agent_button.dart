import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../screens/chat_box.dart';

class ContactAgentButton extends StatelessWidget {
  const ContactAgentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(child: ChatBox()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: paletteBlue,
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ],
          color: paletteYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "Contact Agent",
            style: TextStyle(
              fontSize: 20,
              color: paletteBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
