import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphql/GraphQLConfig.dart';
import '../graphql/QueryMutation.dart';
import '../model/user_model.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtRocket = TextEditingController();
  TextEditingController txtTwitter = TextEditingController();

  _insertNewUser(String name, String rocket, String twitter) async {
    QueryMutation queryMutation = QueryMutation();
    print(queryMutation.insertUser(name, rocket, twitter));

    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(queryMutation.insertUser(name, rocket, twitter))),
    );

    if (!result.hasException) {
      txtName.clear();
      txtRocket.clear();
      txtTwitter.clear();
      Navigator.of(context).pop();
    }else{
      print(result.exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Insert User"),
      content: Container(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: TextField(
                    maxLength: 40,
                    controller: txtName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.text_format),
                      labelText: "Name",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtRocket,
                    decoration: InputDecoration(
                      icon: Icon(Icons.text_decrease),
                      labelText: "Rocket",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 160.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtTwitter,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Twitter", icon: Icon(Icons.person_add)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        MaterialButton(
          child: Text("Insert"),
          onPressed: () async {
            var name = txtName.text.toString().trim();
            var rocket = txtRocket.text.toString().trim();
            var twitter = txtTwitter.text.toString().trim();
            _insertNewUser(name, rocket, twitter);
          },
        )
      ],
    );
  }
}
