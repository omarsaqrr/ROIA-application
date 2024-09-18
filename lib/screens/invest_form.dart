import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/endpoints/end_points.dart';

class InvestmentForm extends StatefulWidget {
  final String userId;
  final int unitId;

  const InvestmentForm({Key? key, required this.userId, required this.unitId}) : super(key: key);

  @override
  _InvestmentFormState createState() => _InvestmentFormState();
}

class _InvestmentFormState extends State<InvestmentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _percentageController = TextEditingController();
  String? _feedbackMessage;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _percentageController.dispose();
    super.dispose();
  }

  Future<void> buySharesRequest(String userId, int unitId, int numberOfShares) async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      final url = Uri.parse('${EndPoints.baseUrl}/shared-units/$unitId/buy-shares/$userId/$numberOfShares');

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        // Successful purchase
        String responseBody = response.body.toLowerCase();
        if (responseBody.contains('shares purchased successfully')) {
          _showFeedback('Shares purchased successfully', true);
        } else if (responseBody.contains('not enough shares available')) {
          _showFeedback('Not enough shares available', false);
        } else {
          _showFeedback('Unknown response from server', false);
        }
      } else if (response.statusCode == 404) {
        // Not enough shares available
        _showFeedback('Not enough shares available', false);
      } else {
        // Other errors
        _showFeedback('Failed to buy shares', false);
      }
    } catch (e) {
      _showFeedback('Error: ${e.toString()}', false);
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showFeedback(String message, bool isSuccess) {
    setState(() {
      _feedbackMessage = message;
    });

    // Automatically hide feedback after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _feedbackMessage = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.transparent.withOpacity(0.5),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _percentageController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Investment Percentage',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: paletteBlue),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a percentage';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: _isSubmitting
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        int numberOfShares = int.parse(_percentageController.text);
                        await buySharesRequest(widget.userId, widget.unitId, numberOfShares);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: paletteYellow,
                      onPrimary: paletteBlue,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: paletteBlue.withOpacity(0.4),
                      elevation: 8,
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: _feedbackMessage != null
                      ? Container(
                    key: ValueKey<String>(_feedbackMessage!),
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _feedbackMessage!.startsWith('Shares') ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _feedbackMessage!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
