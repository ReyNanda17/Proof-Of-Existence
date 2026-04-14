// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProofOfExistence {

    struct Document {
        address owner;
        uint256 timestamp;
    }

    // mapping hash dokumen ke data
    mapping(bytes32 => Document) private documents;

    // event untuk log blockchain
    event DocumentRegistered(
        bytes32 documentHash,
        address owner,
        uint256 timestamp
    );

    // fungsi menyimpan hash dokumen
    function registerDocument(bytes32 _hash) public {

        require(
            documents[_hash].timestamp == 0,
            "Dokumen sudah terdaftar"
        );

        documents[_hash] = Document(
            msg.sender,
            block.timestamp
        );

        emit DocumentRegistered(
            _hash,
            msg.sender,
            block.timestamp
        );
    }

    // cek apakah dokumen ada
    function verifyDocument(bytes32 _hash)
        public
        view
        returns(address owner, uint256 timestamp)
    {
        require(
            documents[_hash].timestamp != 0,
            "Dokumen tidak ditemukan"
        );

        Document memory doc = documents[_hash];
        return (doc.owner, doc.timestamp);
    }
}