// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./ILoanStatus.sol";

contract LoanStatus is ILoanStatus {
    event UpdateStatus(
        uint32 indexed loanId,
        address indexed lender,
        StatusType newStatus
    );

    uint32 public totalNumLoans = 0;
    mapping(uint32 => LoanState) private loanStatus;

    function createLoan(address _lender) internal returns (uint32) {
        
        totalNumLoans += 1;

        LoanState memory newLoan = LoanState({
            status: StatusType.NEW,
            lender: _lender
        });


        loanStatus[totalNumLoans] = newLoan;
        emit UpdateStatus(totalNumLoans, _lender, StatusType.NEW);

        return totalNumLoans;
    }
    
    function resolveLoan(uint32 _loanId) internal {
        LoanState storage loan = loanStatus[_loanId];
        require(loan.status == StatusType.NEW, "Loan is not a new one");

        loan.status = StatusType.RESOLVED;

        emit UpdateStatus(_loanId, loan.lender, StatusType.RESOLVED);
    }
    
    function getLoanState(uint32 _loanId)
        public
        view
        override
        returns (LoanState memory)
    {
        return loanStatus[_loanId];
    }
}
