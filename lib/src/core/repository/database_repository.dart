import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DatabaseRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function for Google Sign-In
  Future<(User? user, bool isNew)> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return (null, false);
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      if (userCredential.additionalUserInfo?.isNewUser == true) {
        return (user, true);
      } else {
        return (user, false);
      }
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return (null, false);
    }
  }

  /// Login with Email and Password
  Future<User?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Log the specific Firebase error
      print('FirebaseAuthException: ${e.message}');
      return null; // Return null for authentication errors
    } catch (e) {
      // Log any other unexpected errors
      print('An unknown error occurred: $e');
      return null; // Return null for other exceptions
    }
  }

  /// Sign Up with Email and Password
  Future<User?> signupWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Log the specific Firebase error
      print('FirebaseAuthException: ${e.message}');
      return null; // Return null for authentication errors
    } catch (e) {
      // Log any other unexpected errors
      print('An unknown error occurred: $e');
      return null; // Return null for other exceptions
    }
  }

  /// Forget Password
  Future<void> forgetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception("Failed to send reset email: $e");
    }
  }

  /// Delete User Account
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Delete FireStore document
        await _firestore.collection('users').doc(user.uid).delete();
        // Delete Firebase Authentication user
        await user.delete();
      } else {
        throw Exception("No user is currently logged in.");
      }
    } catch (e) {
      throw Exception("Failed to delete account: $e");
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception("Failed to sign out: $e");
    }
  }

  /// Check if User Exists in FireStore
  Future<bool> doesUserExist(String userId) async {
    try {
      final snapshot = await _firestore.collection('users').doc(userId).get();
      return snapshot.exists;
    } catch (e) {
      throw Exception("Failed to check user existence: $e");
    }
  }

  /// Get User by ID
  Future<Map<String, dynamic>?> getDocumentById({
    required String userId,
    required String collectionPath,
  }) async {
    try {
      final snapshot =
          await _firestore.collection(collectionPath).doc(userId).get();
      if (snapshot.exists) {
        return snapshot.data();
      }
      return null;
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }

  // add user on with specific document id
  Future<void> addDataOnSpecificId({
    required String collectionPath,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).set(data);
    } on Exception catch (e, stackTrace) {
      debugPrint("Error : ${e.toString()}");
      debugPrint("stackTrace : ${stackTrace}");
    }

    print("Data has been added");
  }

  /// Add Data to FireStore
  Future<void> addDataToFirebase({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).add(data);
    } catch (e) {
      throw Exception("Failed to add data: $e");
    }
  }

  /// Update Data in FireStore
  Future<void> updateDataInFirebase({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> updatedData,
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .update(updatedData);
    } catch (e) {
      throw Exception("Failed to update data: $e");
    }
  }

  /// Delete Document from FireStore
  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      throw Exception("Failed to delete document: $e");
    }
  }

  /// Get All Documents from a Collection
  Future<List<Map<String, dynamic>>> getSpecificUserDocument({
    required String collectionPath,
    bool isSecond = false,
    String secondFieldName = '',
    String secondFieldValue = '',
    bool isSecondBoolField = false,
    bool secondBoolFieldValue = false,
    String fieldValue = "",
    bool isBool = false,
    bool booleanFieldValue = false,
    required String fieldName,
  }) async {
    try {
      if (isSecond) {
        final snapshot =
            await _firestore
                .collection(collectionPath)
                .where(
                  fieldName,
                  isEqualTo: isBool ? booleanFieldValue : fieldValue,
                )
                .where(
                  secondFieldName,
                  isEqualTo:
                      isSecondBoolField
                          ? secondBoolFieldValue
                          : secondFieldValue,
                )
                .get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      } else {
        final snapshot =
            await _firestore
                .collection(collectionPath)
                .where(
                  fieldName,
                  isEqualTo: isBool ? booleanFieldValue : fieldValue,
                )
                .get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      }
    } catch (e) {
      throw Exception("Failed to fetch documents: $e");
    }
  }

  /// Get All Documents from a Collection
  Future<List<Map<String, dynamic>>> getAllDocuments({
    required String collectionPath,
  }) async {
    try {
      final snapshot = await _firestore.collection(collectionPath).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception("Failed to fetch documents: $e");
    }
  }

  /// Get Paginated Data from FireStore
  Future<List<Object?>> getPaginatedDocuments({
    required String collectionPath,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      Query query = _firestore.collection(collectionPath).limit(limit);
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception("Failed to fetch paginated data: $e");
    }
  }

  /// Search in FireStore by Field
  Future<List<Map<String, dynamic>>> searchDocuments({
    required String collectionPath,
    required String field,
    required String queryText,
  }) async {
    try {
      final snapshot =
          await _firestore
              .collection(collectionPath)
              .where(field, isEqualTo: queryText)
              .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception("Failed to search documents: $e");
    }
  }

  Future<String?> uploadImageToFirebase({required File file}) async {
    try {
      // Create a reference to the Firebase Storage location
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref(
        'user_uploads/pictures/$fileName',
      );

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(file);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded file
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
