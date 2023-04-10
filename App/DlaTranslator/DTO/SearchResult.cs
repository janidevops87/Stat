﻿using System;

namespace Registry.Common.DTO
{
    public class SearchResult
    {
        public string SourceName { get; set; }
        public string SourceState { get; set; }
        public string SourceOwnerState { get; set; }
        public string SourceID { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string VerificationForm { get; set; }
        public string DOB { get; set; }
        public string SID { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public DateTime? DonorDate { get; set; }
        public string DonorDateType { get; set; }
        public string DonorStatus { get; set; }
        public string DonorConfirmed { get; set; }
        public string SSN { get; set; }
    }
}
