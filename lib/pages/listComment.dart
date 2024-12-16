import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wise2/components/globals.dart'; // Ensure baseUrl and token retrieval are defined here
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _storage = FlutterSecureStorage();

Future<String?> getAccessToken() async {
  String? token = await _storage.read(key: 'accessToken');
  print('Access Token: $token');
  return token;
}
class CommentsPage extends StatefulWidget {
  final String placeId; // The place_id for fetching comments

  const CommentsPage({Key? key, required this.placeId}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<dynamic> comments = []; // List to store comments
  bool isLoading = true; // To handle loading state
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchComments(); // Fetch comments when the page loads
  }

Future<void> fetchComments() async {
  final String url = '$baseUrl/comments/${widget.placeId}/';
  final String? token = await getAccessToken();

  setState(() {
    isLoading = true;
    errorMessage = '';
  });

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      // Normalize the response: Wrap single object into a list
      setState(() {
        if (responseBody is Map<String, dynamic>) {
          comments = [responseBody]; // Wrap single object in a list
        } else if (responseBody is List<dynamic>) {
          comments = responseBody;
        } else {
          errorMessage = 'Unexpected response format.';
        }
      });
    } else {
      setState(() {
        errorMessage = 'Failed to load comments: ${response.statusCode}';
      });
    }
  } catch (e) {
    setState(() {
      errorMessage = 'An error occurred: $e';
    });
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: const Color(0xFF7541B0),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage)) // Show error message
              : comments.isEmpty
                  ? Center(child: Text('No comments available for this place.'))
                  : ListView.builder(
                      padding: EdgeInsets.all(12.0),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.person, color: Color(0xFF7541B0)),
                            title: Text(
                              comment['username'] ?? 'Unknown User',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans'),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  comment['content'] ?? 'No content available',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Posted on: ${comment['date_posted']}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
