// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface MAD_Engine {
    function depositCollateralAndMint() external;

    function depositCollateral() external;

    function redeemCollateralAndBurn() external;

    function redeemCollateral() external;

    function mintMAD() external;

    function burnMAD() external;

    function liquidate() external;

    function get_HealthIndex() external;
}
