﻿using System;
using System.Collections.Generic;

namespace Stattrac.Services.Donor.Registry.Model
{
    public sealed class DonorSearchRequest 
        : IEquatable<DonorSearchRequest>
    {
        public static readonly DonorSearchRequest Empty = 
            new DonorSearchRequest(null, null, null);

        public string? DonorFirstName { get; }
        public string? DonorLastName { get; }
        public DateTime? DateOfBirth { get; }

        public bool IsFull =>
            !(String.IsNullOrEmpty(DonorFirstName) ||
            String.IsNullOrEmpty(DonorLastName) ||
            DateOfBirth is null);

        public bool IsEmpty =>
            String.IsNullOrEmpty(DonorFirstName) &&
            String.IsNullOrEmpty(DonorLastName) &&
            DateOfBirth is null;

        public DonorSearchRequest(
            string? donorFirstName,
            string? donorLastName,
            DateTime? dateOfBirth)
        {
            DonorFirstName = donorFirstName;
            DonorLastName = donorLastName;
            DateOfBirth = dateOfBirth;
        }

        public override bool Equals(object obj)
        {
            return Equals(obj as DonorSearchRequest);
        }

        public bool Equals(DonorSearchRequest? other)
        {
            return !(other is null) &&
                   DonorFirstName == other.DonorFirstName &&
                   DonorLastName == other.DonorLastName &&
                   DateOfBirth == other.DateOfBirth;
        }

        public override int GetHashCode()
        {
            // Generated by VS
            int hashCode = 1230103825;
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(DonorFirstName!);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(DonorLastName!);
            hashCode = hashCode * -1521134295 + DateOfBirth.GetHashCode();
            return hashCode;
        }


        public static bool operator ==(DonorSearchRequest? left, DonorSearchRequest? right)
        {
            return EqualityComparer<DonorSearchRequest>.Default.Equals(left!, right!);
        }

        public static bool operator !=(DonorSearchRequest? left, DonorSearchRequest? right)
        {
            return !(left == right);
        }

        public override string ToString()
        {
            return $"First name: '{DonorFirstName}', Last name: '{DonorLastName}', Date of birth: '{DateOfBirth}'";
        }
    }
}
