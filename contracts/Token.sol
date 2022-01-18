
   
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract SunflowerLandToken is ERC20Pausable, Ownable {
  mapping (address => bool) gameRoles;

  address private team;

  constructor(address _game, address _team) payable ERC20("Sunflower Land", "SFL") {
        gameRoles[msg.sender] = true;

      _team = team;
  }

  function addGameRole(address _game) public onlyOwner {
      gameRoles[_game] = true;
  }

  function removeGameRole(address _game) public onlyOwner {
      gameRoles[_game] = false;
  }

  function passTeamRole(address _team) public onlyOwner returns (bool) {
    team = _team;

    return true;
  }
  
  function gameMint(address account, uint256 amount) public {
    require(gameRoles[_msgSender()] == true, "SunflowerLandToken: You are not the game");
	_mint(account, amount);
 }

  function gameBurn(address account, uint256 amount) public {
    require(gameRoles[_msgSender()] == true, "SunflowerLandToken: You are not the game");
	_burn(account, amount);
  }

  function gameTransfer(address from, address to, uint256 amount) public {
    require(gameRoles[_msgSender()] == true , "SunflowerLandToken: You are not the game");
	_transfer(from, to, amount);
  }

  function gameApprove(address spender, uint256 amount) public returns (bool) {
    require(gameRoles[_msgSender()] == true , "SunflowerLandToken: You are not the game");
    _approve(_msgSender(), spender, amount);
    return true;
  }

  // TODO: Taxation Fee on transferFrom
}
