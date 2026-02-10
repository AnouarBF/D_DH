// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DH_Token} from "./DH_Token.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

contract MAD_Engine is ReentrancyGuard, IERC20 {
    // Errors:
    error MAD_Engine__InvalidTokenAddress();
    error MAD_Engine__Invalid_Amount();
    error MAD_Engine__TokenList_priceFeedList_mismatch();
    error MAD_Engine__FailedDeposit();

    // Events:
    event CollateralDepositted(
        address indexed user,
        address indexed tokenContract,
        uint amount
    );

    // States:
    DH_Token private immutable i_DMAD;
    mapping(address => address) private s_TokenPriceFeed;
    mapping(address => mapping(address => uint)) private s_collateralDeposited;

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

    constructor(
        address[] memory _tokenAddress,
        address[] memory _priceFeed,
        address _dh_token
    ) {
        uint tokenList_length = _tokenAddress.length;
        uint priceFeedList_length = _priceFeed.length;
        if (tokenList_length != priceFeedList_length) {
            revert MAD_Engine__TokenList_priceFeedList_mismatch();
        }
        for (uint i = 0; i < tokenList_length; i++) {
            s_TokenPriceFeed[_tokenAddress[i]] = _priceFeed[i];
        }
        i_DMAD = DH_Token(_dh_token);
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
        nonReentrant
    {
        s_collateralDeposited[msg.sender][tokenCollateralAddress] += amount;
        emit CollateralDepositted(msg.sender, tokenCollateralAddress, amount);
        bool success = IERC20(tokenCollateralAddress).transferFrom(
            msg.sender,
            address(this),
            amount
        );
        if (!success) revert MAD_Engine__FailedDeposit();
    }

    function redeemCollateralAndBurn() external {}

    function redeemCollateral() external {}

    function mintMAD() external {}

    function burnMAD() external {}

    function liquidate() external {}

    function get_HealthIndex() external view {}
}
