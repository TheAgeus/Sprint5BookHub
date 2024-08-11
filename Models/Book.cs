namespace LibrosApi.Models
{
    public class Book
    {
        public int Id { get; set; }
        public required string Title { get; set; }
        public required string Author { get; set; }
        public required string Gener { get; set; }
        public required string PublishedDate { get; set; }
    }
}
