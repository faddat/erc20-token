// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "erc-payable-token/contracts/token/ERC1363/IERC1363Receiver.sol";

// mock class using IERC1363Receiver
contract ERC1363ReceiverMock is IERC1363Receiver {
    bytes4 private _retval;
    bool private _reverts;

    event Received(address operator, address from, uint256 value, bytes data, uint256 gas);

    constructor(bytes4 retval, bool reverts) public {
        _retval = retval;
        _reverts = reverts;
    }

    function onTransferReceived(address operator, address from, uint256 value, bytes memory data) public override returns (bytes4) { // solhint-disable-line max-line-length
        require(!_reverts, "ERC1363ReceiverMock: throwing");
        emit Received(operator, from, value, data, gasleft());
        return _retval;
    }
}
