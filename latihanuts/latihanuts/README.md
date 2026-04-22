# latihanuts

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


1. Firebase Setup
    Buka Firebase Console
    Create Project: latihanuts
    Realtime Database → Create Database
    Pilih: Start in test mode --> klik enable

2. Ubah Rules
    Masuk tab Rules --> ubah jadi:
    {
  "rules": {
    ".read": true,
    ".write": true
  }
}
    klik publish

#################
- npm install -g firebase-tools / firebase tools : Install firebase

- firebase -v = untuk mengecek versi firebase atau melihat apakah firebase sudah terinstall atau belum.

- where firebase = untuk mengecek apakah kita pake binur mandiri atau npm

- node -v = untuk mengecek apakah nodejs sudah terinstall (karna disini diperlukan)

    🚀 1. Download Node.js

    Buka website resmi:
    👉 https://nodejs.org

    Pilih:
    LTS (Recommended) ✔ (WAJIB pilih ini)
    💻 2. Install
    Klik file .msi
    Next → Next → Finish
    👉 biarkan default saja (tidak perlu ubah)


<!-- - npm install -g firebase-tools = menginstall alat Firebase agar kamu bisa mengelola project lewat terminal. --> Sekali saja installnya -->
 
- firebase login = untuk login ke dalam firebase / digunakan untuk login (masuk) ke akun Firebase kamu lewat terminal.

<!-- - firebase logout = untuk keluar dari firebase / keluar dari akun Firebase yang sedang terhubung di terminal. -->

<!-- - firebase projects:list = untuk melihat berapa project yang kita bikin di firebase. -->

- firebase projects:create = untuk membuat project baru

DI VSCODE --> ada didokumentasi di materi pertemuan 10

- dart pub global activate flutterfire_cli = menginstall tool agar Flutter bisa terhubung ke Firebase dengan mudah. --> Sekali saja installnya

= flutterfire configure = menghubungkan dan mengkonfigurasi Firebase ke project Flutter secara otomatis / bisa dapat melihat kita mau koding di project yg mana atau membuat baruu.

- flutter pub add firebase_core = menginstall package inti agar Flutter bisa terhubung dan menggunakan Firebase. --> kalo buat project baru perlu dilakukan lagi. --> dibutuhkan di pubs.yaml / depencies

- flutter pub add firebase_database = untuk menambahkan fitur database Firebase (Realtime Database) ke project Flutter kamu. -->  dibutuhkan di pubs.yaml / depencies

- flutter pub get
