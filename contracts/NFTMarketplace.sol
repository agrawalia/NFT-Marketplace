//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract NFTMarketplace is ERC721URIStorage{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _itemssold;
    uint256 listingPrice = 0.0025 ether;

    address payable owner;
    mapping(uint256 => MarketItem) private idMarketItem;

    struct MarketItem {
        uint256 tokenid;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    event marketItemCreated(
        uint256 indexed tokenid,
        address payable seller,
        address payable owner,
        uint256 price,
        bool sold
    );

    modifier onlyOwner{
        require(msg.sender == owner, 
        "Only owner of the marketplace can change the listing price"
        );
        _;
    }

    constructor() ERC721("NFT MetaverseToken", "META"){
        owner =payable (msg.sender);
    }

    function updateListingPrice(uint256 _listingPrice)public payable onlyOwner{
        listingPrice = _listingPrice;
    }

    function getListingPrice() public view returns(uint256){
        return listingPrice;
    }

    // Let create "Create NFt Token Function"
    function CreateToken(string memory tokenURI, uint256 price) public {
        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();
        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);


    }



}
