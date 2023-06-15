//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract logistics{

    //declare variables
    address owner;

    //variables of each package
    struct package{
        bool ID_generated;
        uint item_ID;
        string item_name;
        string transit_status;
        uint order_status; // 1 - ordered; 2 - in processing center; 3 - delivering; 4 - cancelled
        address operator;
        uint ordertime;

        //first step of the supply chain
        address processingCenter;
        uint processingCenter_time;

        //second step of the supply chain
        address delivery;
        uint delivery_time;

    }

    //map that links each unique order address to a package
    //package contains details of the order
    mapping (address => package) public package_mapping;    

    //map that sets a boolean to the addresses of the carriers
    //only the operator address is able to authorise processing center and delivery addresses
    mapping (address => bool) public carriers;

    //Constructor
    constructor(){
        owner = msg.sender;
    }

    //Modifier
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }

    //Function: orderItem
    function orderItem(uint itemID, string memory itemName) public returns (address){
        //generate a uniqueID for each order that is placed
        bytes32 hash = keccak256(abi.encodePacked(msg.sender, block.timestamp));
        address uniqueID = address(uint160(uint256(hash) & 0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF));

        //using the uniqueID we set the variables of the package that was ordered
        package_mapping[uniqueID].ID_generated = true;
        package_mapping[uniqueID].item_ID = itemID;
        package_mapping[uniqueID].item_name = itemName;
        package_mapping[uniqueID].transit_status = "Order for package has been placed.";
        package_mapping[uniqueID].order_status = 1;
        package_mapping[uniqueID].operator = msg.sender;
        package_mapping[uniqueID].ordertime = block.timestamp;

        return uniqueID;
    }

    //Function: cancelOrder
    function cancelOrder(address unique_ID) public returns (string memory){
        require(package_mapping[unique_ID].ID_generated);
        require(package_mapping[unique_ID].operator == msg.sender);
        require(package_mapping[unique_ID].order_status != 3);

        package_mapping[unique_ID].order_status = 4;
        package_mapping[unique_ID].transit_status = "Your order has been cancelled";

        return "Your order has been cancelled";
    }

    //Function: manageProcessingCenter
    function manageProcessingCenter(address processingCenterAddress) onlyOwner public returns (string memory){

        //authorise the carriers
        if(!carriers[processingCenterAddress]){
            carriers[processingCenterAddress] = true;
        } else {
            carriers[processingCenterAddress] = false;
        }

        return "Status at Processing Center Updated";
    }

    //Function: manageDelivery
    function manageDelivery(address deliveryAddress) onlyOwner public returns (string memory){

        //authorise the carriers
        if(!carriers[deliveryAddress]){
            carriers[deliveryAddress] = true;
        } else {
            carriers[deliveryAddress] = false;
        }

        return "Status at Delivery Updated";
    }

    //Function: ProcessingCenterReport
    function processingCenterReport(address uniqueID, string memory transitStatus) public {
        require(package_mapping[uniqueID].ID_generated);
        require(carriers[msg.sender]);
        require(package_mapping[uniqueID].order_status == 1);

        package_mapping[uniqueID].transit_status = transitStatus;
        package_mapping[uniqueID].processingCenter = msg.sender;
        package_mapping[uniqueID].processingCenter_time = block.timestamp;
        package_mapping[uniqueID].order_status = 2;
    }

        //Function: DeliveryReport
    function deliveryReport(address uniqueID, string memory transitStatus) public {
        require(package_mapping[uniqueID].ID_generated);
        require(carriers[msg.sender]);
        require(package_mapping[uniqueID].order_status == 2);

        package_mapping[uniqueID].transit_status = transitStatus;
        package_mapping[uniqueID].processingCenter = msg.sender;
        package_mapping[uniqueID].processingCenter_time = block.timestamp;
        package_mapping[uniqueID].order_status = 3;
    }
}