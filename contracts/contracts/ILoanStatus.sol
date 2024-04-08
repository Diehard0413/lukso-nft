// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface ILoanStatus {    
    enum StatusType {
        NOT_EXISTS,
        NEW,
        RESOLVED
    }    
    
    struct LoanState {
        address lender;
        StatusType status;
    }
    
    function getLoanState(uint32 _loanId)
        external
        view
        returns (LoanState memory);
}
