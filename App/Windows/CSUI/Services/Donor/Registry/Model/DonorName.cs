﻿using System;
using System.Collections.Generic;

namespace Stattrac.Services.Donor.Registry.Model
{
    public class DonorName : IEquatable<DonorName>
    {
        public DonorName(string? firstName, string? middleName, string? lastName)
        {
            // TODO: Decide which parameter is required.
            FirstName = firstName;
            MiddleName = middleName;
            LastName = lastName;
        }

        public string? FirstName { get; }
        public string? MiddleName { get; }
        public string? LastName { get; }

        public override bool Equals(object obj)
        {
            return Equals(obj as DonorName);
        }

        public bool Equals(DonorName? other)
        {
            // TODO: Possibly do case-insensitive comparison.
            return !(other is null) &&
                   FirstName == other.FirstName &&
                   MiddleName == other.MiddleName &&
                   LastName == other.LastName;
        }

        public override int GetHashCode()
        {
            // Generated by VS
            int hashCode = 1391740223;
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(FirstName!);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(MiddleName!);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(LastName!);
            return hashCode;
        }

        public static bool operator ==(DonorName? left, DonorName? right)
        {
            return EqualityComparer<DonorName>.Default.Equals(left!, right!);
        }

        public static bool operator !=(DonorName? left, DonorName? right)
        {
            return !(left == right);
        }

        public override string ToString()
        {
            return $"First: {FirstName}, Middle: {MiddleName}, Last: {LastName}";
        }
    }
}