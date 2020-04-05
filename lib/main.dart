import 'package:flutter/material.dart';
import 'models/row_data.dart';
import 'controllers/form_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController dataController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController batimentosController = TextEditingController();
  TextEditingController quandoController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      RowData feedbackForm = RowData(
        dataController.text, 
        maxController.text, 
        minController.text, 
        batimentosController.text, 
        minController.text
      );

      FormController formController = FormController((String response) {
          print("Response: $response");
          if (response == FormController.STATUS_SUCCESS) {
            // Feedback is saved succesfully in Google Sheets.
            _showSnackbar("Feedback Submitted");
          } else {
            // Error Occurred while saving data in Google Sheets.
            _showSnackbar("Error Occurred!");
          }
        }
      );
     
      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
      final snackBar = SnackBar(content: Text(message));
      _scaffoldKey.currentState.showSnackBar(snackBar); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child:
                  Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: dataController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Data';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Data'
                        ),
                      ),
                      TextFormField(
                        controller: maxController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Max';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Max'
                        ),
                      ),
                      TextFormField(
                        controller: minController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Min';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Min',
                        ),
                      ),
                      TextFormField(
                        controller: batimentosController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Batimentos';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Batimentos'
                        ),
                      ),
                      TextFormField(
                        controller: quandoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Quando';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Quando'
                        ),
                      ),
                    ],
                  ),
                ) 
              ),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed:_submitForm,
                child: Text('Submit Feedback'),
              ),
            ],
          ),
        ),
    );
  }
}
