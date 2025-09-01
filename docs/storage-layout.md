# Storage Layout & Gas Notes

## Proxy storage collision
When using proxies, always reserve storage slots or use unstructured storage (EIP-1967).
If implementation and proxy share storage variable names in the same slots, delegatecall may corrupt state.

## Packing
- Two uint128 in a single slot saves gas vs two uint256.
- Use storage layout docs when upgrading contracts.

## Gas tips
- Use unchecked for non-risky arithmetic to save gas.
- Favor external over public for large structs arrays.
- Keep hot paths as pure/view where possible.
