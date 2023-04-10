﻿using System;
using System.Collections.Generic;

namespace Stattrac.Services.Donor.Registry.Model
{
    public sealed class DonorRegistryInfo : IEquatable<DonorRegistryInfo>
    {
        public DonorRegistryInfo(
            DonorRegistryType registryType,
            string? registryState,
            string? registryOwnerState)
        {
            Type = registryType;
            State = registryState;
            OwnerState = registryOwnerState;
        }

        public DonorRegistryType Type { get; }
        public string? State { get; }
        public string? OwnerState { get; }

        public override bool Equals(object obj)
        {
            return Equals(obj as DonorRegistryInfo);
        }

        public bool Equals(DonorRegistryInfo? other)
        {
            return !(other is null) &&
                   Type == other.Type &&
                   State == other.State &&
                   OwnerState == other.OwnerState;
        }

        public override int GetHashCode()
        {
            // Generated by VS
            int hashCode = -1701762928;
            hashCode = hashCode * -1521134295 + EqualityComparer<DonorRegistryType>.Default.GetHashCode(Type);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(State!);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(OwnerState!);
            return hashCode;
        }

        public static bool operator ==(DonorRegistryInfo left, DonorRegistryInfo right)
        {
            return EqualityComparer<DonorRegistryInfo>.Default.Equals(left, right);
        }

        public static bool operator !=(DonorRegistryInfo left, DonorRegistryInfo right)
        {
            return !(left == right);
        }
        public override string ToString()
        {
            return $"Type: {Type}, State: {State}, Owner state: {OwnerState}";
        }
    }
}
