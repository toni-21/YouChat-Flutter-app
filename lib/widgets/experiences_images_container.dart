import 'package:flutter/material.dart';
import '../scoped_models/demo_model.dart';

class ExperiencesImagesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: demoExperiencesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: Column(children: <Widget>[
                          CircleAvatar(
                            //backgroundColor: Colors.amber,
                            backgroundImage: AssetImage(
                                demoExperiencesList[index].imagePosted),
                            radius: 30,
                          ),
                          SizedBox(height: 6),
                          Text(
                            demoExperiencesList[index].name,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          )
                        ]));
                  }),
            );
  }
}
