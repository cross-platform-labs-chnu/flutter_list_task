# Flutter List Task

This project is a small Flutter application that loads a mixed feed of posts
and advertisements from a backend. It contains:

- **Post cards** displaying the author and post content.
- **Ad cards** displaying the advertiser, content, and target URL.
- **Cursor pagination** that appends additional feed items while scrolling.
- **Loading, empty, and error states** with retry support.

The app uses Dio for HTTP requests. The Dio client is created in `main.dart`
and injected into the feed service. Feed items are parsed into distinct typed
`Post` and `Ad` models.

## Requirements

- Flutter SDK installed and available in `PATH`.
- Android SDK installed and Android licenses accepted for Android builds.
- For Linux desktop: Flutter's Linux desktop build dependencies installed.
- For Android phone testing: USB debugging enabled and this computer authorized
  on the phone.
- A backend serving `GET /api/v1/feed`.

## API configuration

The default API base URL is `http://localhost:8080`. Override it at run or
build time with `--dart-define`:

```bash
flutter run -d chrome \
  --dart-define=API_BASE_URL=http://localhost:8080

flutter build apk \
  --dart-define=API_BASE_URL=https://api.example.com
```

The app requests `${API_BASE_URL}/api/v1/feed`. The initial request does not
include a cursor. Later requests send the returned `nextCursor` as the
`cursor` query parameter when `hasMore` is `true`.

The backend response should contain `items`, `nextCursor`, and `hasMore`. Each
item must have a `type` of `post` or `ad` and a corresponding `data` object.

## Check available devices

From the project directory, run:

```bash
flutter devices
```

Example devices:

```text
SM S711B (mobile) • RZCX90XERJT • android-arm64 • Android 16 (API 36)
Linux (desktop)   • linux       • linux-x64     • Fedora Linux
Chrome (web)      • chrome      • web-javascript • Google Chrome
```

## Run on Linux desktop

Make sure the backend is reachable at the configured API URL, then run:

```bash
flutter run -d linux \
  --dart-define=API_BASE_URL=http://localhost:8080
```

## Run on an Android phone

Connect the phone by USB, enable **Developer options → USB debugging**, unlock
it, and accept the **Allow USB debugging?** prompt. Confirm that
`flutter devices` lists the phone, then run:

```bash
flutter run -d RZCX90XERJT \
  --dart-define=API_BASE_URL=https://api.example.com
```

Replace `RZCX90XERJT` with the device ID shown by `flutter devices` if it
differs. If `adb devices` shows `unauthorized`, accept the authorization prompt
on the phone and check again.

## Run in a web browser

For Chrome, run:

```bash
flutter run -d chrome \
  --dart-define=API_BASE_URL=http://localhost:8080
```

Alternatively, start Flutter's web server:

```bash
flutter run -d web-server \
  --dart-define=API_BASE_URL=http://localhost:8080
```

Flutter prints a local URL in the terminal. Open that URL in a browser, such as
Firefox. The `web-server` device has limited debugging support compared with
Chrome, but it can be used to view and test the app.

To stop the running app, press `q` in the terminal where `flutter run` is
running.
