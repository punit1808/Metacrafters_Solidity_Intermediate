// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;

contract Bank {
    mapping(address => uint) private balances;

    event Deposit(address indexed owner, uint amount);
    event Withdraw(address indexed owner, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);

    // Deposit Funds Function
    function deposit(address _account, uint _number) public payable {

        require(_account != address(0), "Invalid account address"); 
        // require() -> revert if condition fails and display text we want to display as error
        balances[_account] += _number;
        emit Deposit(_account, _number);
    }

    // Withdraw Funds Function
    function withdraw(address _account, uint _number) public {

        require(_account != address(0), "Invalid account address");
        // require() -> revert if condition fails and display custom error message.

        if (balances[_account] < _number) {
            revert("Withdrawal failed: Insufficient balance");
            // revert() -> revert the transaction and trigger an error with custom error message.
        }

        uint oldBalance = balances[_account];
        balances[_account] -= _number;

        assert(balances[_account] == oldBalance - _number);
        // assert() -> If condition fails it will indicate a bug in the contract.

        emit Withdraw(_account, _number);
    }

    // Transfer Funds Function
    function transfer(address _from, address _to, uint _number) public {
        require(_from != address(0), "Invalid Sender's Address");
        require(_to != address(0), "Invalid Receiver's Address");
        require(_from != _to, "Transfer to himself is not Allowed");
        require(balances[_from] >= _number, "Insufficient funds");

        uint oldBalance_from = balances[_from];
        uint oldBalance_to = balances[_to];
        balances[_from] -= _number;
        balances[_to] += _number;

        assert(balances[_from] + _number == oldBalance_from);
        assert(balances[_to] - _number == oldBalance_to);

        emit Transfer(_from, _to, _number);
    }

    // Balance Check Function
    function getBalance(address _address) public view returns (uint) {
        return balances[_address];
    }

}
