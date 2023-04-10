using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef.SqlServer.Migrations
{
    public partial class Initial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ReferralUploads",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Referral_Id = table.Column<int>(type: "int", nullable: true),
                    Referral_CallId = table.Column<int>(type: "int", nullable: true),
                    Referral_IsUpdate = table.Column<bool>(type: "bit", nullable: false),
                    Referral_CallerSourceCode = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Referral_CallReceivedOn = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: false),
                    Referral_CoordinatorName_FirstName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_CoordinatorName_LastName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_CallerInformation_PhoneNumber_AreaCode = table.Column<string>(type: "char(3)", nullable: false),
                    Referral_CallerInformation_PhoneNumber_Prefix = table.Column<string>(type: "char(3)", nullable: false),
                    Referral_CallerInformation_PhoneNumber_Number = table.Column<string>(type: "char(4)", nullable: false),
                    Referral_CallerInformation_Extension_Value = table.Column<string>(type: "varchar(10)", nullable: true),
                    Referral_CallerInformation_HospitalName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Referral_CallerInformation_CallerName_FirstName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_CallerInformation_CallerName_LastName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_CallerInformation_Unit = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_CallerInformation_Floor = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_Heartbeat = table.Column<bool>(type: "bit", nullable: false),
                    Referral_Vent = table.Column<byte>(type: "tinyint", nullable: false),
                    Referral_ExtubationAt = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    Referral_DonorPerson_Name_FirstName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_DonorPerson_Name_LastName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_DonorPerson_DateOfBirth = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    Referral_DonorPerson_Age_Value = table.Column<int>(type: "int", nullable: true),
                    Referral_DonorPerson_Age_Unit = table.Column<byte>(type: "tinyint", nullable: true),
                    Referral_DonorPerson_Race = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_DonorPerson_Gender = table.Column<byte>(type: "tinyint", nullable: true),
                    Referral_DonorPerson_Weight_Value = table.Column<float>(type: "real", nullable: true),
                    Referral_DonorPerson_Weight_Unit = table.Column<byte>(type: "tinyint", nullable: true),
                    Referral_DonorPerson_MedicalRecordNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_DeclaredCardiacTimeOfDeath = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Referral_AdmittedOn = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Referral_CauseOfDeath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_MedicalHistory = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_PagingInformation_PagedToClient = table.Column<bool>(type: "bit", nullable: true),
                    Referral_PagingInformation_PagedToClientOn = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    Referral_PagingInformation_RePagedToClientOn = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    Referral_PagingInformation_ReceivedBy = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_PagingInformation_PagedBy = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Referral_PagingInformation_ReferralPagedToHospital = table.Column<bool>(type: "bit", nullable: true),
                    Referral_ReferralNumer = table.Column<int>(type: "int", nullable: true),
                    Referral_EnteredOn = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    AddedToSystemOn = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: false),
                    SourceFileName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ProcessingStatus_Status = table.Column<byte>(type: "tinyint", nullable: false),
                    ProcessingStatus_ErrorMessage = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ReferralUploads", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ReferralUploads");
        }
    }
}
