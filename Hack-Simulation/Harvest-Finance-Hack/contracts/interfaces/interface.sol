pragma solidity ^0.8.1;


interface IUniswapV2Pair {
    function swap(uint256 amount0Out, uint256 amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint256);
    function price1CumulativeLast() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

interface IcurveYSwap {
    function exchange(int128 i, int128 j, uint256 dx, uint256 min_dy) external;

    function exchange_underlying(int128 i, int128 j, uint256 dx, uint256 min_dy) external;
}

interface IHarvestUsdcVault {
    function deposit(uint256 amountWei) external;

    function withdraw(uint256 numberOfShares) external;

    function balanceOf(address account) external view returns (uint256);
}

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function withdraw(uint256 wad) external;
    function deposit(uint256 wad) external returns (bool);
    function owner() external view virtual returns (address);
}

interface IUSDT {
    function approve(address _spender, uint256 _value) external;

    function balanceOf(address owner) external view returns (uint256);

    function transfer(address _to, uint256 _value) external;
}