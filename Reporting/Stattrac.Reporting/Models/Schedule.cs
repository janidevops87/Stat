﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;

namespace Stattrac.Reporting.Models
{
    public partial class Schedule
    {
        public int ScheduleItemID { get; set; }
        public int ScheduleGroupID { get; set; }
        public string ScheduleItemName { get; set; }
        public DateTime ShiftStart { get; set; }
        public DateTime ShiftEnd { get; set; }
        public int? PersonId1 { get; set; }
        public string Person1 { get; set; }
        public int? PersonId2 { get; set; }
        public string Person2 { get; set; }
        public int? PersonId3 { get; set; }
        public string Person3 { get; set; }
        public int? PersonId4 { get; set; }
        public string Person4 { get; set; }
        public int? PersonId5 { get; set; }
        public string Person5 { get; set; }
        public int ShiftStatus { get; set; }

    }
}