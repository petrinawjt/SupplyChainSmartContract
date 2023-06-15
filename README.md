# Supply Chain Smart Contract

This smart contract facilitates transparency between the consumers and companies by providing information about the products ordered every step of the way. The smart contract records and stores transactions in a transparent and tamper-evident manner. 

For the instance of this code, the brief flow of the supply chain would be:
Order is placed
Processing Center updates that order has been received and is in process
Delivery updates that order is in the midst of delivery

Optional Steps:
Order cancelled


## Features

#### orderItem
    - Function takes in the item ID and item name
    - It generates a unique ID for each order that is placed, this unique ID will have to be stored for reference later on
    - Once an order is placed, the variables of the package is also updated
    - This function returns the unique ID for the order placed

#### cancelOrder
    - Function takes in the unique ID of the order that was placed
    - Functions checks for 3 requirements:
        - Unique ID has been generated for the order places
        - The person cancelling the order is the qualified operator in charge
        - The package status can be anything but in delivery
    - If requirements have been passed, order and transit status will be edited
    - Returns a string confirming that the order has been cancelled

#### manageProcessingCenter
    - Function takes in the address of the processing center
    - Only the operator is able to use this function
    - This function grants the process center access to update the status of the package
    - Returns a string to show that access has been allowed to the respective processing center’s account

#### manageDelivery
    - Function takes in the address of the deliverer
    - Only the operator is able to use this function
    - This function grants the deliverer access to update the status of the package
    - Returns a string to show that access has been allowed to the respective deliverer’s account

#### processingCenterReport
    - Function can only be accessed by the processing center and their address that has been authorised earlier on
    - Function takes in the unique ID of the package and a string of transit status from the processing center
    - Function checks for 3 requirements:
        - Unique ID has been generated for the order places
        - The processing center has been authorised
        - The package status has to have been ‘1’ which is that the order has been placed
    - The function updates the status of the package

#### deliveryReport
    - Function can only be accessed by the deliverer and their address that has been authorised earlier on
    - Function takes in the unique ID of the package and a string of transit status from the deliverer
    - Function checks for 3 requirements:
        - Unique ID has been generated for the order places
        - The deliverer has been authorised
        - The package status has to have been ‘2’ which is that the order has been processed at the processing center
    - The function updates the status of the package

## Remarks
  - Order can be cancelled when order is just placed or when the order is in process, however it cannot be cancelled once it has reached the delivery stage
  - Only the operator will be able to process order cancellations
  - Only the operator will be able authorise the specific Processing Centers and Delivery addresses
  - This smart contract does not take into account the amount of items placed in an order

## Testing
**Account addresses given are examples**
Operator Account/Address: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
Processing Center Account/Address: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
Delivery Account/Address: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

#### Test #1: Order goes through all stages of the supply chain smoothly

  - Use a different account for each stage and store the addresses. 3 account addresses are needed for operator, processing center and delivery respectively.
  - Using the Operator’s account, order an item (itemID: 111, itemName: milk).
  - The transaction will produce an address as an output, store the address (unique ID: 0x4aD93116D0c151e75a56f6b1721828e72c076cEc).
  - To check the contents and the status of the package we just ordered, paste the unique ID address into package_mapping to call the data. Order status should be 1 which stands for order is placed and item ID and name should be what was entered previously.
  - Using the Operator’s account, authorise the Processing Center’s address. Paste the previously stored Processing Center’s address into the ‘manageProcessingCenter’ function
  - To check if the Processing Center’s address is authorised, paste the Processing Center’s address into carriers and the boolean returned should be true
  - For the Processing Center to update the status of the package, use the Processing Center’s account, use the ‘processingCenterReport’ function by putting in the unique ID and a string to describe the status.
  - To check if the status has been updated, switch back to the Operator’s account and call package_mapping. You will observe that the order status and transit status has been altered. 
Repeat steps 5-8 for the Deliverer.


#### Test #2: Order gets cancelled at the first stage

  - Use a different account for each stage and store the addresses. 3 account addresses are needed for operator, processing center and delivery respectively.
  - Using the Operator’s account, order an item (itemID: 111, itemName: milk).
  - The transaction will produce an address as an output, store the address (unique ID: 0x4aD93116D0c151e75a56f6b1721828e72c076cEc).
  - To check the contents and the status of the package we just ordered, paste the unique ID address into package_mapping to call the data. Order status should be 1 which stands for order is placed and item ID and name should be what was entered previously.
  - Still using the Operator’s Account, cancel the order by pasting the unique ID. Transaction should be successful because cancellation is still allowed at the first stage.
  - To check if the order has been successfully cancelled, call package_mapping and the order and transit status should have been altered.


#### Test #3: Order gets cancelled at second stage

  - Use a different account for each stage and store the addresses. 3 account addresses are needed for operator, processing center and delivery respectively.
  - Using the Operator’s account, order an item (itemID: 111, itemName: milk).
  - The transaction will produce an address as an output, store the address (unique ID: 0x4aD93116D0c151e75a56f6b1721828e72c076cEc).
  - To check the contents and the status of the package we just ordered, paste the unique ID address into package_mapping to call the data. Order status should be 1 which stands for order is placed and item ID and name should be what was entered previously.
  - Using the Operator’s account, authorise the Processing Center’s address. Paste the previously stored Processing Center’s address into the ‘manageProcessingCenter’ function
  - To check if the Processing Center’s address is authorised, paste the Processing Center’s address into carriers and the boolean returned should be true
  - For the Processing Center to update the status of the package, use the Processing Center’s account, use the ‘processingCenterReport’ function by putting in the unique ID and a string to describe the status.
  - To check if the status has been updated, switch back to the Operator’s account and call package_mapping. You will observe that the order status and transit status has been altered. 
  - Still using the Operator’s Account, cancel the order by pasting the unique ID. Transaction should be successful because cancellation is still allowed at the second stage.
  - To check if the order has been successfully cancelled, call package_mapping and the order and transit status should have been altered.


#### Test #4: Order gets cancelled at third stage

  - Use a different account for each stage and store the addresses. 3 account addresses are needed for operator, processing center and delivery respectively.
  - Using the Operator’s account, order an item (itemID: 111, itemName: milk).
  - The transaction will produce an address as an output, store the address (unique ID: 0x4aD93116D0c151e75a56f6b1721828e72c076cEc).
  - To check the contents and the status of the package we just ordered, paste the unique ID address into package_mapping to call the data. Order status should be 1 which stands for order is placed and item ID and name should be what was entered previously.
  - Using the Operator’s account, authorise the Processing Center’s address. Paste the previously stored Processing Center’s address into the ‘manageProcessingCenter’ function
  - To check if the Processing Center’s address is authorised, paste the Processing Center’s address into carriers and the boolean returned should be true
  - For the Processing Center to update the status of the package, use the Processing Center’s account, use the ‘processingCenterReport’ function by putting in the unique ID and a string to describe the status.
  - To check if the status has been updated, switch back to the Operator’s account and call package_mapping. You will observe that the order status and transit status has been altered. 
  - Repeat steps 5-8 for the Deliverer.
  - Still using the Operator’s Account, cancel the order by pasting the unique ID. Transaction should not be successful because cancellation is not allowed at the third stage (delivery stage).


