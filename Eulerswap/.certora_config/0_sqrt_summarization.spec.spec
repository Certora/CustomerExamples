// gives the floor of sqrt via implicit specification
// written by Roy and Yoav from Certora
function floorSqrtSummarization(uint256 x) returns uint256 {
    mathint SQRT;
    require SQRT*SQRT <= x && (SQRT + 1)*(SQRT + 1) > x;
    return to_uint256(SQRT);
}