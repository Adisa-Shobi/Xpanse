import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpanse_app/controllers/auth_controller.dart';
import 'package:xpanse_app/routes/route_names.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var profileImageUrl = ''.obs;
  var startOfMonthDay = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  /// Fetches profile data for the currently signed-in user.
  void fetchProfileData() async {
    try {
      isLoading.value = true;
      final User? user = AuthService.currentUser;

      if (user != null) {
        // Fetch user data from Firestore
        final userData =
            await _firestore.collection('users').doc(user.uid).get();
        if (userData.exists) {
          firstName.value = userData.data()?['firstName'] ?? 'Unknown';
          lastName.value = userData.data()?['lastName'] ?? 'Unknown';
          phoneNumber.value = userData.data()?['phoneNumber'] ?? 'N/A';
          email.value = user.email ?? 'N/A';
          profileImageUrl.value = userData.data()?['profileImageUrl'] ?? '';
        }
      } else {
        // Redirect to login if user is not signed in
        Get.offAllNamed(RouteNames.login);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Updates the profile data for the currently signed-in user.
  void updateProfileData({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    String? profileImageUrl,
  }) async {
    try {
      isLoading.value = true;
      final User? user = AuthService.currentUser;

      if (user != null) {
        final docRef = _firestore.collection('users').doc(user.uid);

        // Prepare fields to update
        Map<String, dynamic> updateData = {
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'email': email,
        };

        // If the profile image URL is provided, update it
        if (profileImageUrl != null) {
          updateData['profileImageUrl'] = profileImageUrl;
        }

        await docRef.update(updateData);

        // Update local observable values to reflect changes
        this.firstName.value = firstName;
        this.lastName.value = lastName;
        this.phoneNumber.value = phoneNumber;
        this.email.value = email;
        if (profileImageUrl != null) {
          this.profileImageUrl.value = profileImageUrl;
        }

        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        Get.offAllNamed(RouteNames.login);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateStartOfMonth(String day) async {
    try {
      isLoading.value = true;
      final User? user = AuthService.currentUser;

      if (user != null) {
        final docRef = _firestore.collection('users_data').doc(user.uid);

        await docRef.update({'startOfMonth': day});
        startOfMonthDay.value = day;

        Get.snackbar('Success', 'Start of month updated successfully!');
      } else {
        Get.offAllNamed(RouteNames.login);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update start of month: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Picks a new profile image and uploads it to Firebase Storage.
  Future<void> changeProfileImage() async {
    try {
      // Pick an image from the gallery
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        isLoading.value = true;

        // Upload the image to Firebase Storage
        final file = File(pickedFile.path);
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        UploadTask uploadTask =
            _storage.ref('profile_pictures/$fileName').putFile(file);

        // Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

        // Get the download URL of the uploaded image
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Update the user's profile with the new image URL
        updateProfileData(
          firstName: firstName.value,
          lastName: lastName.value,
          phoneNumber: phoneNumber.value,
          email: email.value,
          profileImageUrl: downloadUrl,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to change profile image: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
