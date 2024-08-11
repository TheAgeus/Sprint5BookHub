using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LibrosApi.Migrations
{
    /// <inheritdoc />
    public partial class CreateUserFavBookTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "UserFavBooks",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    BookId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserFavBooks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserFavBooks_Books_BookId",
                        column: x => x.BookId,
                        principalTable: "Books",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserFavBooks_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserFavBooks_BookId",
                table: "UserFavBooks",
                column: "BookId");

            migrationBuilder.CreateIndex(
                name: "IX_UserFavBooks_UserId",
                table: "UserFavBooks",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UserFavBooks");
        }
    }
}
