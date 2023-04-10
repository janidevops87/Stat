using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.Collections.Generic;

namespace Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef.Migrations
{
    public partial class MakeUserTenantOptional : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "TenantId",
                table: "Users",
                nullable: true,
                oldClrType: typeof(int));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "TenantId",
                table: "Users",
                nullable: false,
                oldClrType: typeof(int),
                oldNullable: true);
        }
    }
}
