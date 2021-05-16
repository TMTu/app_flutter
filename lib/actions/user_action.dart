import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_flutter/models/user/user.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter/models/app_state.dart';
import 'dart:convert' as convert;

const LIST_USERS_REQUEST = 'LIST_USERS_REQUEST';
const LIST_USERS_SUCCESS = 'LIST_USERS_SUCCESS';
const LIST_USERS_FAILURE = 'LIST_USERS_FAILURE';

ThunkAction<AppState> getUsers() => (Store<AppState> store) async {
      store.dispatch({'type': LIST_USERS_REQUEST, 'data': null});

      try {
        var url = Uri.http(
            '10.0.2.2:3000', '/user/list', {'limit': '10', 'page': '1'});

        // Await the http get response, then decode the json-formatted response.
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var jsonResponse =
              await convert.jsonDecode(response.body) as Map<String, dynamic>;
          print(jsonResponse);
          List<User> users = [];

          for (var data in jsonResponse['data']) {
            users.add(User(
              id: data['id'],
              username: data['username'],
              email: data['email'],
              firstName: data['firstName'],
              lastName: data['lastName'],
              description: data['description'],
            ));
          }

          store.dispatch({'type': LIST_USERS_SUCCESS, 'data': users});
        } else {
          print(response.statusCode);
          store.dispatch({'type': LIST_USERS_FAILURE, 'data': []});
        }
      } catch (error) {
        print("getUsers Error " + error);
        store.dispatch({'type': LIST_USERS_FAILURE, 'data': []});
      }
    };

const GET_USER_DETAILS_REQUEST = 'GET_USER_DETAILS_REQUEST';
const GET_USER_DETAILS_SUCCESS = 'GET_USER_DETAILS_SUCCESS';
const GET_USER_DETAILS_FAILURE = 'GET_USER_DETAILS_FAILURE';

ThunkAction<AppState> getUserDetails(String id) =>
    (Store<AppState> store) async {
      store.dispatch({'type': GET_USER_DETAILS_REQUEST, 'data': null});

      try {
        var url = Uri.http('10.0.2.2:3000', '/user/info', {'id': id});
        // Await the http get response, then decode the json-formatted response.
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var jsonResponse = await convert.jsonDecode(response.body) as Map<String, dynamic>;

          var user = UserDetails(
            id: jsonResponse['id'],
            username: jsonResponse['username'],
            email: jsonResponse['email'],
            firstName: jsonResponse['firstName'],
            lastName: jsonResponse['lastName'],
            description: jsonResponse['description'],
          );
          store.dispatch({'type': GET_USER_DETAILS_SUCCESS, 'data': user});
        } else {
          store.dispatch({'type': GET_USER_DETAILS_FAILURE, 'data': null});
        }
      } catch (error) {
        print(error);
        store.dispatch({'type': GET_USER_DETAILS_FAILURE, 'data': null});
      }
    };

const ADD_USER_REQUEST = 'ADD_USER_REQUEST';
const ADD_USER_SUCCESS = 'ADD_USER_SUCCESS';
const ADD_USER_FAILURE = 'ADD_USER_FAILURE';

ThunkAction<AppState> addUser(User user) => (Store<AppState> store) async {
  try {
    var url = Uri.http(
        '10.0.2.2:3000', '/user', {"Content-Type": "application/json"});
    // Await the http get response, then decode the json-formatted response.
    final json = {
      "id": user.id,
      "username": user.username,
      "email": user.email,
      "firstName": user.firstName,
      "lastName": user.lastName,
      "description": user.description,
    };

    var response = await http.post(url, body: json);
    if (response.statusCode == 201) {
      // var jsonResponse = await convert.jsonDecode(response.body) as Map<String, dynamic>;

      store.dispatch({'type': ADD_USER_SUCCESS, 'data': user});
    } else {
      print(response.statusCode);
    }
  } catch (error) {
    print(error);
  }
};

const UPDATE_USER_SUCCESS = "UPDATE_USER_SUCCESS";

ThunkAction<AppState> updateUser(User user, int i) => (Store<AppState> store) async {
  try {
    var url = Uri.http('10.0.2.2:3000', '/user/info', {'id': user.id});
    // Await the http get response, then decode the json-formatted response.
    final json = {
      "email": user.email,
      "firstName": user.firstName,
      "lastName": user.lastName,
      "description": user.description,
    };

    var response = await http.put(url, body: json);
    if (response.statusCode == 200) {
      // var jsonResponse = await convert.jsonDecode(response.body) as Map<String, dynamic>;

      store.dispatch({'type': UPDATE_USER_SUCCESS, 'data': user, 'index': i});
    } else {
      print(response.statusCode);
    }
  } catch (error) {
    print(error);
  }
};

const DELETE_USER_SUCCESS = 'DELETE_USER_SUCCESS';

ThunkAction<AppState> deleteUser(String id, int i) => (Store<AppState> store) async {
  try {
    var url = Uri.http('10.0.2.2:3000', '/user', {'id': id});
    // Await the http get response, then decode the json-formatted response.

    var response = await http.delete(url);
    if (response.statusCode == 200) {
      // var jsonResponse = await convert.jsonDecode(response.body) as Map<String, dynamic>;

      store.dispatch({'type': DELETE_USER_SUCCESS, 'data': null, 'index': i});
    } else {
      print(response.statusCode);
    }
  } catch (error) {
    print(error);
  }
};
