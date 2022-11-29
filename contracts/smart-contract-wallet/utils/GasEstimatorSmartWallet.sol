// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "../WalletFactory.sol";

// Contract for estimating gas on undeployed smart account
// Deploys a smart account and then calls the appropriate method
contract GasEstimatorSmartWallet {
    function estimate(
        address _actualWallet,
        address _factory,
        address _owner,
        address _entryPoint,
        address _handler,
        uint256 _index,
        bytes calldata _data // execTransaction data // counterFactual wallet should have assets if required
    )
        external
        returns (
            bool success,
            bytes memory result,
            uint256 gas
        )
    {
        // solhint-disable
        uint256 initialGas = gasleft();
        address _wallet = WalletFactory(_factory).deployCounterFactualWallet(
            _owner,
            _entryPoint,
            _handler,
            _index
        );
        (success, result) = _actualWallet.call(_data);
        gas = initialGas - gasleft();
        // solhint-enable
    }
}
