# My Bank
This Project basically have a contract of Bank in which we can deposit, withdraw, transfer and can see balance funds in Blockchain. Program is written in Solidity version >=0.8.2 and have mapping between address and amount named balances have 3 events for updation of deposit,transfer and withdraw operations in blockchain and have 4 functions for deposit, transfer, withdraw and getBalance operations.

## Description
So, as mentioned before code has mapping, 3 events and 4 helper functions now get into its depth and know how the code is working.
Firstly, mapping balances is mapping the account holder's address with it's funds amount present in his/her account. After that 3 events are defined which update the operations deposit, withdraw and tranfer in the blockchain. 
# In last 4 helper functions:
1). deposit => It adds the deposited fund into the sender's address and emit it using Deposit event.
2). withdraw => It withdraws the fund from the sender's address and emit it using Withdraw event.
3). transfer => It adds the deposited fund into the reciever's address and withdraws it from sender's address and emit it using Transfer event.
4). getBalance => It returns the funds available at the provided address.

## Getting Started

For the execution of our code we will be using VSCode ,

After cloning the repositry provided for environment create a new .sol file and start writing the project code.

### Executing program

```
code blocks for commands

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

```
After writing the code it's time to compile and deploy it. Run provided steps in different terminal.

## Steps for compiling and deployment of program Code:
Command 1:
npm i -> Run it in the first terminal

Command 2:
npx hardhat node -> Run it in the second terminal

Command 3:
npx hardhat run --network localhost scripts/deploy.js -> run it in the third terminal

Command 4:
npx hardhat console --network localhost ->run this and upcoming steps in first terminal

Command 5:
const bank = await (await ethers.getContractFactory("Bank")).attach("0x5FbDB2315678afecb367f032d93F642f64180aa3") -> link the blockchain to program code

After performing these steps we can call helper functions in program code and can perform tranfer, deposit, withdraw and getBalance.
# Example for function calling : 
await bank.deposit("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", 1)

### Thanks for Reading
I hope you Understand the program Code and functioning well.
#Have a Nice Day !!!
