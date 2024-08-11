namespace LibrosApi.Models
{
    public class UserAlreadyreadBook
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int BookId { get; set; }

        public User User { get; set; } // Navigation property
        public Book Book { get; set; } // Navigation property
    }
}
