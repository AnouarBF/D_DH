// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DH_Token} from "./DH_Token.sol";

contract MAD_Engine {
    error MAD_Engine__InvalidTokenAddress();
    error MAD_Engine__Invalid_Amount();

    modifier checkValidToken(address tokenAddress) {
        if (tokenAddress == address(0)) {
            revert MAD_Engine__InvalidTokenAddress();
        }
        _;
    }

    modifier checkValidAmount(uint amount) {
        if (amount == 0) {
            revert MAD_Engine__Invalid_Amount();
        }
        _;
    }

    function depositCollateralAndMint() external {}
    /**
     * @param tokenCollateralAddress, the user should choose his prefered collateral and deposit some amount of it
     * @param amount, the amount of the chosen collateral
     */
    function depositCollateral(
        address tokenCollateralAddress,
        uint amount
    )
        external
        checkValidToken(tokenCollateralAddress)
        checkValidAmount(amount)
    {}

    function redeemCollateralAndBurn() external {}

    function redeemCollateral() external {}

    function mintMAD() external {}

    function burnMAD() external {}

    function liquidate() external {}

    function get_HealthIndex() external view {}
}
