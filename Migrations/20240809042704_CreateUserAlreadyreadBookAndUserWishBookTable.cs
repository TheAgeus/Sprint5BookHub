using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LibrosApi.Migrations
{
    /// <inheritdoc />
    public partial class CreateUserAlreadyreadBookAndUserWishBookTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "UserAlreadyreadBooks",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    BookId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserAlreadyreadBooks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserAlreadyreadBooks_Books_BookId",
                        column: x => x.BookId,
                        principalTable: "Books",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserAlreadyreadBooks_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserWishBooks",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    BookId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserWishBooks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserWishBooks_Books_BookId",
                        column: x => x.BookId,
                        principalTable: "Books",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserWishBooks_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserAlreadyreadBooks_BookId",
                table: "UserAlreadyreadBooks",
                column: "BookId");

            migrationBuilder.CreateIndex(
                name: "IX_UserAlreadyreadBooks_UserId",
                table: "UserAlreadyreadBooks",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserWishBooks_BookId",
                table: "UserWishBooks",
                column: "BookId");

            migrationBuilder.CreateIndex(
                name: "IX_UserWishBooks_UserId",
                table: "UserWishBooks",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UserAlreadyreadBooks");

            migrationBuilder.DropTable(
                name: "UserWishBooks");
        }
    }
}
