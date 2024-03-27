let priceFunc = ifaceOR.encodeFunctionData("balanceOf", ["0adas"]);
let prevblock = (currentBlock - 1).toString(16);
let current = currentBlock.toString(16);

let priceQueries = [];

priceQueries.push({
    method: 'eth_call',
    params: [{
        to: oracleCon.address,
        data: priceFunc,
    }, "0x" + prevblock],
    id: 0,
    jsonrpc: '2.0',
});
priceQueries.push({
    method: 'eth_call',
    params: [{
        to: oracleCon.address,
        data: priceFunc,
    }, "0x" + current], // Corrected this line
    id: 1, // Corrected this line (changed id to 1)
    jsonrpc: '2.0',
});
let priceData = await batchCall(priceQueries, localhost);
let prevPrice = abi.decode(["uint256"], priceData[0].result);
let currentPrice = abi.decode(["uint256"], priceData[1].result);

if (prevPrice < currentPrice) {
    return true;
} else if (prevPrice > currentPrice) {
    return false;
} else {
    return "NC";
}