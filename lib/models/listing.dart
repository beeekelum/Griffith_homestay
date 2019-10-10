class Listing {
  //host parent personal details
  final String listingId;
  final String hostMaritalStatus;
  final String hostLanguage;
  final String hostNationality;
  final String hostReligion;
  final String hostingExperience;

  //accommodation details
  final String accommodationDuration;
  final String startDate;
  final String endDate;
  final String noOfRooms;
  final String noOfRoomsAvailable;
  final String noOfBathrooms;
  final String noOfBathroomsAvailable;
  final String location;
  final String facilitiesOffered;
  final String familyPets;
  final String noOfFamilyPets;
  final String transportProximity;
  final String otherAmenities;
  final String status;

  //host parents Preferences
  final String preferredStudentGender;
  final String preferredLevelOfStudy;
  final String smokingStudent;
  final String studentsWithPets;

  Listing(
      {this.listingId,
      this.hostMaritalStatus,
      this.hostLanguage,
      this.hostNationality,
      this.hostReligion,
      this.hostingExperience,
      this.accommodationDuration,
      this.startDate,
      this.endDate,
      this.noOfRooms,
      this.noOfRoomsAvailable,
      this.noOfBathrooms,
      this.noOfBathroomsAvailable,
      this.location,
      this.facilitiesOffered,
      this.familyPets,
      this.noOfFamilyPets,
      this.transportProximity,
      this.otherAmenities,
      this.status,
      this.preferredStudentGender,
      this.preferredLevelOfStudy,
      this.smokingStudent,
      this.studentsWithPets});
}
