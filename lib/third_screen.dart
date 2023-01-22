import 'package:flutter/material.dart';
import 'api_service.dart';
import 'list_provider_1.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'second_screen.dart';
var page=1;

class ThirdScreen extends StatefulWidget {
  final String name;
  final String selectedNameFirst;
  final String selectedNameSecond;
  const ThirdScreen({Key? key, required this.name, required this.selectedNameFirst, required this.selectedNameSecond})
      : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Third Screen",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white),
      body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            setState(() {
              page = page + 1;
            });
            setState(() {
              
            });
          },
          child: ChangeNotifierProvider(
            create: (_) =>
                ListUser1Provider(apiService: ApiService(), page: page),
            child: Consumer<ListUser1Provider>(
              builder: (context, state, _) {
                if (state.state == ResultState1.loading) {
                  return Center(
                    child: Column(
                      children: const [
                        SizedBox(height: 10),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                } else if (state.state == ResultState1.hasData) {
                  return ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    //shrinkWrap: true,
                    itemCount: state.result.data.length,
                    itemBuilder: (context, index) {
                      var listUser = state.result.data[index];
                      return UserItem(
                          user: listUser,
                          name: widget.name,
                          selectedNameFirst: listUser.firstName,
                          selectedNameSecond: listUser.lastName,);
                    },
                  );
                } else if (state.state == ResultState1.noData) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else if (state.state == ResultState1.error) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Center(
                    child: Material(
                      child: Text(''),
                    ),
                  );
                }
              },
            ),
          )),
    );
  }
}

class UserItem extends StatefulWidget {
  final Datum user;
  final String name;
  final String selectedNameFirst;
  final String selectedNameSecond;

  const UserItem(
      {Key? key,
      required this.user,
      required this.name,
      required this.selectedNameFirst,
      required this.selectedNameSecond})
      : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Image.network(widget.user.avatar),
            title: Text(
              widget.user.firstName + widget.user.lastName,
            ),
            subtitle: Text(widget.user.email),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SecondScreen(
                      name: widget.name,
                      selectedNameFirst: widget.selectedNameFirst,
                      selectedNameSecond: widget.selectedNameSecond,
                    )))),
      ),
    );
  }
}
