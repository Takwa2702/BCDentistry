// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PatientRegistry {
    struct Patient {
        string name;
        uint256 age;
        string dentalInfo;
    }

    mapping(uint256 => Patient) public patients;
    uint256 public patientCount;

    event PatientRegistered(uint256 indexed patientId, string name);
    event PatientInfoUpdated(uint256 indexed patientId, string  _name, uint256 _age, string  _dentalInfo);

    function registerPatient(string memory _name, uint256 _age, string memory _dentalInfo) public {
        // Increment the patientCount to get the next patient ID
        uint256 patientId = patientCount;
        patientCount++;

        // Create a new Patient struct and store it in the mapping
        patients[patientId] = Patient(_name, _age, _dentalInfo);
        // Emit an event to log the registration
        emit PatientRegistered(patientId, _name);
    }

    function getPatient(uint256 _patientId) public view returns (string memory, uint256, string memory) {
        Patient memory patient = patients[_patientId];
        require(bytes(patient.name).length > 0, "Patient not found");
        return (patient.name, patient.age, patient.dentalInfo);
    }

    function getAllPatients() public view returns (uint256[] memory) {
        uint256[] memory patientIds = new uint256[](patientCount);
        for (uint256 i = 0; i < patientCount; i++) {
            patientIds[i] = i;
        }
        return patientIds;
    }

    // Function to update patient information by authorized users
    function updatePatientInfo(uint256 _patientId, string memory _name, uint256 _age, string memory _dentalInfo) public {
    require(_patientId < patientCount, "Patient not found");
    
    // Only authorized users (dentists or medical staff) can update patient information.
    // You would need to implement a proper access control mechanism for this check.
    // For simplicity, we assume anyone can update the data in this example.

    Patient storage patient = patients[_patientId];
    patient.name = _name;
    patient.age = _age;
    patient.dentalInfo = _dentalInfo;

    // Emit an event to log the update
    emit PatientInfoUpdated(_patientId, _name, _age, _dentalInfo);
    }

}
