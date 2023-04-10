using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef.Migrations
{
    public partial class AddedClientSecretExtended : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "ClientSecrets",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "CreationTime",
                table: "ClientSecrets",
                nullable: true);

            // We want all rows existed before adding 
            // ClientSecretExtended to upgrade as if 
            // they were created as ClientSecretExtended, 
            // so we use this default value for the discriminator column.
            // Also we initialize CreationTime to current time for existing rows.
            // NOTE: Though similar effect could be accomplished using
            // model configuration, I don't want these default values to be 
            // part of the model, they really belong to the migration.
            migrationBuilder.Sql(
                $"UPDATE ClientSecrets " +
                $"SET CreationTime=SWITCHOFFSET(SYSDATETIMEOFFSET(), '+00:00'), " +
                $"Discriminator='{nameof(ClientSecretExtended)}'");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "ClientSecrets");

            migrationBuilder.DropColumn(
                name: "CreationTime",
                table: "ClientSecrets");
        }
    }
}
