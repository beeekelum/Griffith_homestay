import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/ui/about_homestay.dart';
import 'package:homestay/ui/coordinator/coodinator_accommodation.dart';
import 'package:homestay/ui/coordinator/coodinator_home_page.dart';
import 'package:homestay/ui/coordinator/coodinator_match_screen.dart';
import 'package:homestay/ui/coordinator/coodinator_signin.dart';
import 'package:homestay/ui/coordinator/coodinator_signup.dart';
import 'package:homestay/ui/coordinator/hostparent_feedbackform.dart';
import 'package:homestay/ui/coordinator/hostparentlistingform.dart';
import 'package:homestay/ui/coordinator/matches_found_history.dart';
import 'package:homestay/ui/coordinator/student_feedbackform.dart';
import 'package:homestay/ui/coordinator/student_n_host_policies_page.dart';
import 'package:homestay/ui/coordinator/student_preference_form.dart';
import 'package:homestay/ui/coordinator/upload_file.dart';
import 'package:homestay/ui/hostparent/hosparent_profile.dart';
import 'package:homestay/ui/hostparent/host_parent_policy.dart';
import 'package:homestay/ui/hostparent/my_host_feedback.dart';
import 'package:homestay/ui/hostparent/my_view_student_feedback.dart';
import 'package:homestay/ui/hostparent/mylistings.dart';
import 'package:homestay/ui/hostparent/parent_accommodation.dart';
import 'package:homestay/ui/hostparent/parent_feedback_form.dart';
import 'package:homestay/ui/hostparent/parent_home_page.dart';
import 'package:homestay/ui/hostparent/parent_listing_form.dart';
import 'package:homestay/ui/hostparent/parent_signin.dart';
import 'package:homestay/ui/hostparent/parent_signup.dart';
import 'package:homestay/ui/hostparent/student_hostp_feedback.dart';
import 'package:homestay/ui/hostparent/students_list_view.dart';
import 'package:homestay/ui/launcher_page.dart';
import 'package:homestay/ui/reset_password.dart';
import 'package:homestay/ui/student/accommodation_list.dart';
import 'package:homestay/ui/student/feedback_page.dart';
import 'package:homestay/ui/student/select_parent_for_feedback.dart';
import 'package:homestay/ui/student/student_home_page.dart';
import 'package:homestay/ui/student/student_policy_page.dart';
import 'package:homestay/ui/student/student_preference_page.dart';
import 'package:homestay/ui/student/student_profile.dart';
import 'package:homestay/ui/student/student_signin.dart';
import 'package:homestay/ui/student/student_signup.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Homestay',
        theme: ThemeData(
          fontFamily: 'Muli',
          primarySwatch: Colors.teal,
          primaryTextTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
            ),
          ),
          primaryIconTheme: IconThemeData(
            color: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            hintStyle: TextStyle(fontFamily: 'Muli', color: Colors.white70),
          ),
          hintColor: Colors.teal,
        ),
        home: LauncherPage(),
        routes: <String, WidgetBuilder>{
          '/launcherpage': (BuildContext context) => LauncherPage(),
          '/studentsigninpage': (BuildContext context) => StudentSignIn(),
          '/coodinatorsigninpage': (BuildContext context) => CoodinatorSignIn(),
          '/parentsigninpage': (BuildContext context) => ParentSignIn(),
          '/studentsignuppage': (BuildContext context) => StudentSignUp(),
          '/coodinatorsignuppage': (BuildContext context) => CoodinatorSignUp(),
          '/parentsignuppage': (BuildContext context) => ParentSignUp(),
          '/passwordreset': (BuildContext context) => PasswordReset(),

          //student screens
          '/studenthomepage': (BuildContext context) => StudentHomePage(),
          '/accommodation': (BuildContext context) => AccommodationList(),
          '/stdntpreferenceform': (BuildContext context) =>
              StudentPreferencePge(),
          '/feedbackform': (BuildContext context) => FeedbackForm(),
          '/studentprofile': (BuildContext context) => StudentProfile(),
          '/studentpolicy': (BuildContext context) => StudentPolicy(),
          '/sendfeedbacktoparent': (BuildContext context) =>
              SelectParentForFeedback(),

          //host parent screens
          '/parenthomepage': (BuildContext context) => ParentHomePage(),
          '/parentprofile': (BuildContext context) => HostPProfile(),
          '/parentpolicy': (BuildContext context) => HostPPolicy(),
          '/ViewfeedbackFromStudent': (BuildContext context) =>
              ViewFeedbackFromStudent(),
          '/parentaccommodation': (BuildContext context) =>
              HostPAccommodation(),
          '/parentstudentfeedback': (BuildContext context) =>
              HostPStudentFeedback(),
          '/parentfeedbackform': (BuildContext context) => HostPFeedbackForm(),
          '/parentlistingform': (BuildContext context) => HostPListingForm(),
          '/mylistings': (BuildContext context) => MyListings(),
          '/myfeedback': (BuildContext context) => MyFeedbackHost(),
          '/studentsListforfeedback': (BuildContext context) => StudentsList(),

          //Co-odinator screens
          '/coodinatorhomepage': (BuildContext context) => CoodinatorHomePage(),
          '/coodinatorbrowseaccommodation': (BuildContext context) =>
              CoodinatorBrowseAccomodation(),
          '/hostparentlistingform': (BuildContext context) =>
              HostParentListingForm(),
          '/studentpreferenceform': (BuildContext context) =>
              StudentPreferenceForm(),
          '/matchnandnotify': (BuildContext context) => MatchScreen(),
          '/uploaddocs': (BuildContext context) => UploadDocuments(),
          '/studentfeedback': (BuildContext context) => StudentFeedBackForm(),
          '/about': (BuildContext context) => AboutHomestay(),
          '/matchesfoundhistory': (BuildContext context) =>
              MatchesFoundHistory(),
          '/studnhostpoliciesuploadpage': (BuildContext context) =>
              StudentNHostPoliciesPage(),
          '/hostparentfeedbackform': (BuildContext context) =>
              HostParentFeedbackForm(),
        },
      ),
    );
  }
}
