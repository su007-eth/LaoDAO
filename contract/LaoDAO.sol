// SPDX-License-Identifier: GPL-3.0

// LaoDAO OG NFT CONTRACT
/**
    LaoDAO is the first DAO focusing on historical NFT collections, striving to be the largest one.
    https://laodao.io
  */

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LaoDAO is ERC721Enumerable, Ownable {
  using Strings for uint256;
  string public baseURI;
  string public baseExtension = ".json";
  uint256 public cost = 0.2 ether;
  uint256 public maxBlackSupply = 80;
  uint256 public maxGoldSupply = 120;
  uint256 public maxPublicSupply=800;
  uint256 public maxMintPublic = 20;
  uint256 public maxMintBlack = 1;
  uint256 public maxMintGold = 3;
  address public daoAddress = 0xf988143Eb8500C5115784fF57839e84A2A5C86Db;
  bool public paused = false;
    
  address[] public whitelisted1;
  address[] public whitelisted2;
  mapping(address => uint256) public addressMintedBalance1;
  mapping(address => uint256) public addressMintedBalance2;
   
  using Counters for Counters.Counter;
  Counters.Counter private _totalBlackSupply;
  Counters.Counter private _totalGoldSupply;
  Counters.Counter private _totalPublicSupply;

  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
    mintBlack(msg.sender, 1);
  }

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public
  function mint(address _to, uint256 _mintAmount) public payable {
    uint256 supply = _totalPublicSupply.current();
    require(!paused);
    require(_mintAmount > 0);
    require(supply + _mintAmount <= maxPublicSupply);
    if (msg.sender != owner()) {
        require(_mintAmount <= maxMintPublic);
        require(msg.value >= cost * _mintAmount);        
    }
    for (uint256 i = 0; i < _mintAmount; i++) {
        _totalPublicSupply.increment();
        _safeMint(_to, maxBlackSupply + maxGoldSupply + supply + i);
    }
  }

  function mintBlack(address _to, uint256 _mintAmount) public payable {
    uint256 supply = _totalBlackSupply.current();
    require(!paused);
    require(_mintAmount > 0);
    require(supply + _mintAmount <= maxBlackSupply);
    if (msg.sender != owner()) {
        require(_mintAmount <= maxMintBlack);
        require(isWhitelisted1(msg.sender));
        uint256 ownerMintedCount = addressMintedBalance1[msg.sender];
        require(ownerMintedCount + _mintAmount <= maxMintBlack);
    }
    for (uint256 i = 0; i < _mintAmount; i++) {
        addressMintedBalance1[msg.sender]++;
        _totalBlackSupply.increment();
        _safeMint(_to, supply + i);
    }
  }

  function mintGold(address _to, uint256 _mintAmount) public payable {
    uint256 supply = _totalGoldSupply.current();
    require(!paused);
    require(_mintAmount > 0);
    require(supply + _mintAmount <= maxGoldSupply);
    if (msg.sender != owner()) {
      require(_mintAmount <= maxMintGold);
      require(isWhitelisted2(msg.sender));
      uint256 ownerMintedCount = addressMintedBalance2[msg.sender];
      require(ownerMintedCount + _mintAmount <= maxMintGold);
    }
    for (uint256 i = 0; i < _mintAmount; i++) {
      addressMintedBalance2[msg.sender]++;
      _totalGoldSupply.increment();
      _safeMint(_to, maxBlackSupply + supply + i);
    }
  }

  function isWhitelisted1(address _user) public view returns (bool) {
    for (uint i = 0; i < whitelisted1.length; i++) {
      if (whitelisted1[i] == _user) {
        return true;
      }
    }
    return false;
  }

  function isWhitelisted2(address _user) public view returns (bool) {
    for (uint i = 0; i < whitelisted2.length; i++) {
      if (whitelisted2[i] == _user) {
          return true;
      }
    }
    return false;
  }

  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

  //only owner
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  function setmaxMintGold(uint256 _newmaxMintAmount) public onlyOwner {
    maxMintGold = _newmaxMintAmount;
  }

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

  function pause(bool _state) public onlyOwner {
    paused = _state;
  }
 
  function whitelistUsers1(address[] calldata _users) public onlyOwner {
    delete whitelisted1;
    whitelisted1 = _users;
  }

  function whitelistUsers2(address[] calldata _users) public onlyOwner {
    delete whitelisted2;
    whitelisted2 = _users;
  }

  function withdraw() public payable onlyOwner {
    (bool os, ) = payable(daoAddress).call{value: address(this).balance}("");
    require(os);
  }
}