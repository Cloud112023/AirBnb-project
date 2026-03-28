import 'package:flutter/material.dart';

import '../constant/styles/style.dart';
import '../models/posting_object.dart';

class CreateUpdatePostingPage extends StatefulWidget {
  const CreateUpdatePostingPage({super.key, this.posting});

  final Posting? posting;

  @override
  State<CreateUpdatePostingPage> createState() =>
      _CreateUpdatePostingPageState();
}

class _CreateUpdatePostingPageState extends State<CreateUpdatePostingPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _amenitiesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _propertyTypes = [
    'detached house',
    'villa',
    'apartment',
    'condo',
    'flat',
    'town house',
    'studio',
    'room',
  ];

  String? _selectedProperty;
  Map<String, int>? _beds;
  Map<String, int>? _bathrooms;
  List<MemoryImage>? _images;
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.posting == null
            ? Text('Create Posting')
            : Text('Update Posting'),
        actions: [
          _isloading
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.upload_file_outlined,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Post to Online Marketplace',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child: Theme(
                    data: ThemeData.dark().copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        //Posting Name
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Posting Name',
                          ),
                          style: TextStyle(fontSize: 22, color: Colors.white),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Valid  Name';
                            }
                            return null;
                          },
                        ),

                        //Dropdown
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: InputDecorator(
                            decoration: TStyles.inputDecoration,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: _propertyTypes.map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedProperty = value;
                                  });
                                },
                                isExpanded: true,
                                value: _selectedProperty,
                                hint: Text(
                                  'Select Property',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Price
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _priceController,
                                  decoration: InputDecoration(
                                    labelText: 'Price',
                                  ),
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please Enter valid price';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  '💲 / night',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Description
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: _descriptionController,
                            maxLines: 3,
                            maxLength: 500,
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white70,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Valid  Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        //Address
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Address',
                              ),
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Valid  Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        //Beds

                        //Bathrooms

                        //Amenities

                        //Photos
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
