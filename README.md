# Social App with Chat, Calls and Live Streaming

A Flutter social app that combines a post feed with real-time communication. Users share text and image posts, chat one-to-one, make voice and video calls and go live, all powered by ZEGOCLOUD and Firebase.

## Features

- Sign up and sign in with Firebase Auth and form validation
- Home feed with text posts and image posts
- User search
- One-to-one chat and chat list with ZEGOCLOUD ZIM (ZIMKit)
- Voice and video calls with ZEGOCLOUD UIKit Prebuilt Call
- Live streaming (host and audience) with ZEGOCLOUD UIKit Prebuilt Live Streaming

## Tech stack

Flutter · Dart · Firebase Auth · Cloud Firestore · ZEGOCLOUD ZIM / ZIMKit · ZEGOCLOUD UIKit Prebuilt Call · ZEGOCLOUD UIKit Prebuilt Live Streaming · form_validator

## Project structure

```
lib/
  views/auth/   sign in and sign up
  views/home/   base screen, feed, posts, search, chat list, chat page
  zim/          ZEGOCLOUD login, chat list, audio call, video call, live streaming
```

## Getting started

1. Install Flutter (3.x) and run `flutter pub get`.
2. Run `flutterfire configure` to connect your own Firebase project.
3. Create a ZEGOCLOUD project, enable ZIM, and put your own App ID and App Sign in `lib/main.dart` and the files in `lib/zim/`.
4. Run `flutter run`.

## License

Released under the [MIT License](LICENSE).
