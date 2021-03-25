pragma solidity ^0.5.0;


contract DeferredEquityPlan {
    address human_resources;
    address payable employee; 
    bool active = true;


    uint total_shares = 1000;
    uint annual_distribution = 250;
    uint start_time = now; 

    // @TODO: Set the `unlock_time` to be 365 days from now
    // Your code here!
    uint public unlock_time = now + 365 days;
    uint public distributed_shares; // starts at 0

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, 'You are not authorised!');
        require(active == true, 'Contract is not active.');

        require(unlock_time <= now);
        require(distributed_shares < total_shares);


        unlock_time += 365 days;
        
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, 'You are not authorised!');
        active = false;
    }

    function() external payable {
        revert('Wrong contract to send Ether!');
    }
}
