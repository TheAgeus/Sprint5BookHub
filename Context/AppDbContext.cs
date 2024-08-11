using LibrosApi.Models;
using Microsoft.EntityFrameworkCore;

namespace LibrosApi.Context
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
            
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Book> Books { get; set; }
        public DbSet<UserFavBook> UserFavBooks { get; set; }
        public DbSet<UserAlreadyreadBook> UserAlreadyreadBooks { get; set; }
        public DbSet<UserWishBook> UserWishBooks { get; set; }

    }
}
