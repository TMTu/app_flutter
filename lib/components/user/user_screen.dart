import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:app_flutter/routes.dart';

import 'package:app_flutter/models/app_state.dart';

import 'package:app_flutter/models/user/user.dart';
import 'package:app_flutter/models/user/user_state.dart';

import 'package:app_flutter/actions/user_action.dart';

class UsersScreen extends StatelessWidget {
  void handleInitialBuild(UsersScreenProps props) {
    props.getUsers();
  }

  TextEditingController idCont = new TextEditingController();
  TextEditingController userCont = new TextEditingController();
  TextEditingController emailCont = new TextEditingController();
  TextEditingController firstNameCont = new TextEditingController();
  TextEditingController lastNameCont = new TextEditingController();
  TextEditingController descriptionCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, UsersScreenProps>(
      converter: (store) => mapStateToProps(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        List<User> data = props.listResponse.data;
        bool loading = props.listResponse.loading;

        Widget body;
        if (loading) {
          body = Center(
            child: CircularProgressIndicator(),
          );
        } else {

          body = Column(
              children:[
                Row(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Text('ID', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Text('Username', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Text('Email', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Text('First Name', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Text('Last Name', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Text('Description ', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                  ),
                ]),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(0, 15 ,0 ,15),
                    itemCount: data.length,
                    separatorBuilder: (context, index) => Divider(color: Colors.grey,),
                    itemBuilder: (context, i) {
                      User user = data[i];

                      return InkWell(
                        onLongPress: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('Delete user with id : ' +user.id),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  ),
                                  actions: [
                                    RaisedButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }
                                    ),
                                    RaisedButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          props.deleteUser(user.id, i);
                                          Navigator.pop(context);
                                        }
                                    ),
                                  ],
                                );
                              });
                        },
                        onTap: () {
                          idCont.text = user.id;
                          userCont.text = user.username;
                          emailCont.text = user.email;
                          firstNameCont.text = user.firstName;
                          lastNameCont.text = user.lastName;
                          descriptionCont.text = user.description;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('Update Form'),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: idCont,
                                            decoration: InputDecoration(
                                              labelText: 'ID',
                                              icon: Icon(Icons.account_box),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: userCont,
                                            decoration: InputDecoration(
                                              labelText: 'Username',
                                              icon: Icon(Icons.text_fields),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: emailCont,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              icon: Icon(Icons.email),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: firstNameCont,
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              icon: Icon(Icons.text_fields),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: lastNameCont,
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              icon: Icon(Icons.text_fields),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: descriptionCont,
                                            decoration: InputDecoration(
                                              labelText: 'Description',
                                              icon: Icon(Icons.text_fields),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    RaisedButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }
                                    ),
                                    RaisedButton(
                                        child: Text("Update"),
                                        onPressed: () {
                                          var user = User(
                                              id : idCont.text,
                                              username: userCont.text,
                                              email: emailCont.text,
                                              firstName: firstNameCont.text,
                                              lastName: lastNameCont.text,
                                              description: descriptionCont.text
                                          );
                                          props.updateUser(user, i);
                                          Navigator.pop(context);
                                        }
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Row(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text(user.id, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text(user.username, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text(user.email, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text(user.firstName, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text(user.lastName, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text(user.description, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                        ),
                      ],));

                        // onTap: () {
                        //   props.getUserDetails(user.id);
                        //   Navigator.pushNamed(context, AppRoutes.userDetails);
                        // },
                      // );
                    },
                  )
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: const EdgeInsets.all(20),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    props.getUsers();
                  },
                  child: Text('Reload list'),
                )
              ]);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Users list'),
          ),
          body: Container(
              padding: const EdgeInsets.fromLTRB(0, 15 ,0 ,15),
              child:body
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text('Create Form'),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: idCont,
                                decoration: InputDecoration(
                                  labelText: 'ID',
                                  icon: Icon(Icons.account_box),
                                ),
                              ),
                              TextFormField(
                                controller: userCont,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  icon: Icon(Icons.text_fields),
                                ),
                              ),
                              TextFormField(
                                controller: emailCont,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(Icons.email),
                                ),
                              ),
                              TextFormField(
                                controller: firstNameCont,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  icon: Icon(Icons.text_fields),
                                ),
                              ),
                              TextFormField(
                                controller: lastNameCont,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  icon: Icon(Icons.text_fields),
                                ),
                              ),
                              TextFormField(
                                controller: descriptionCont,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  icon: Icon(Icons.text_fields),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        RaisedButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                        ),
                        RaisedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            var user = User(
                              id : idCont.text,
                              username: userCont.text,
                              email: emailCont.text,
                              firstName: firstNameCont.text,
                              lastName: lastNameCont.text,
                              description: descriptionCont.text
                            );
                            props.addUser(user);
                            Navigator.pop(context);
                          }
                        ),
                      ],
                    );
                  });
            }
          )
        );
      },
    );
  }
}

class UsersScreenProps {
  final Function getUsers;
  final Function getUserDetails;
  final Function addUser;
  final Function updateUser;
  final Function deleteUser;
  final ListUsersState listResponse;

  UsersScreenProps({
    this.getUsers,
    this.listResponse,
    this.getUserDetails,
    this.addUser,
    this.updateUser,
    this.deleteUser
  });
}

UsersScreenProps mapStateToProps(Store<AppState> store) {
  return UsersScreenProps(
    listResponse: store.state.user.list,
    getUsers: () => store.dispatch(getUsers()),
    getUserDetails: (String id) => store.dispatch(getUserDetails(id)),
    addUser: (User user) => store.dispatch(addUser(user)),
    updateUser: (User user, int i) => store.dispatch(updateUser(user, i)),
    deleteUser: (String id, int i) => store.dispatch(deleteUser(id, i))
  );
}