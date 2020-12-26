unit Unit_TBlockHeader;

interface

type
	{** Nodes collect new transactions into a block, hash them into a hash tree,
	 * and scan through nonce values to make the block's hash satisfy proof-of-work
	 * requirements.  When they solve the proof-of-work, they broadcast the block
	 * to everyone and the block is added to the block chain.  The first transaction
	 * in the block is a special one that creates a new coin owned by the creator
	 * of the block.
	 *}
	TBlockHeader = class
	public:
		// header
		nVersion: int32_t;
		hashPrevBlock: uint256;
		hashMerkleRoot: uint256;
		nTime: uint32_t;
		nBits: uint32_t;
		nNonce: uint32_t;

		SERIALIZE_METHODS(CBlockHeader, obj) { READWRITE(obj.nVersion, obj.hashPrevBlock, obj.hashMerkleRoot, obj.nTime, obj.nBits, obj.nNonce); }

		procedure TBlockHeader.SetNull();
		function TBlockHeader.IsNull() : boolean;
		function TBlockHeader.GetHash() : uint256;
		function TBlockHeader.GetBlockTime() : int64_t;
	end;


implementation

// #include <hash.h>
// #include <tinyformat.h>


constructor TBlockHeader.Create;
begin
	SetNull();
end;

procedure TBlockHeader.SetNull();
begin
	nVersion := 0;
	hashPrevBlock.SetNull();
	hashMerkleRoot.SetNull();
	nTime := 0;
	nBits := 0;
	nNonce := 0;
end;

function TBlockHeader.IsNull() : boolean;
begin
	result := (nBits == 0);
end;

function TBlockHeader.GetHash() : uint256;
begin
	return SerializeHash( *this);
end;

function TBlockHeader.GetBlockTime() : int64_t;
begin
	result := (int64_t) nTime;
end;




end.
