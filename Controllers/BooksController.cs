using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LibrosApi.Context;
using LibrosApi.Models;

namespace LibrosApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BooksController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BooksController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Books
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Book>>> GetBooks()
        {
            var books = await _context.Books.ToListAsync();

            if (books == null || !books.Any())
            {
                return NotFound("No books found.");
            }

            // Build the plain text response
            var result = books.Select(book =>
                $"{book.Id};{book.Title};{book.Author};{book.Gener};{book.PublishedDate:yyyy-MM-dd}"
            );

            var plainText = string.Join("|", result);

            return Content(plainText, "text/plain");
        }


        [HttpGet("user/{userId}")]
        public async Task<IActionResult> GetBookStatuses(int userId)
        {
            var booksWithStatus = await _context.Books
                .Select(book => new
                {
                    book.Id,
                    book.Title,
                    book.Author,
                    book.Gener,
                    book.PublishedDate,
                    IsFav = _context.UserFavBooks.Any(fav => fav.UserId == userId && fav.BookId == book.Id),
                    IsAlreadyRead = _context.UserAlreadyreadBooks.Any(read => read.UserId == userId && read.BookId == book.Id),
                    IsWished = _context.UserWishBooks.Any(wish => wish.UserId == userId && wish.BookId == book.Id)
                })
                .ToListAsync();

            if (booksWithStatus == null || !booksWithStatus.Any())
            {
                return Content("", "text/plain");
            }

            var result = booksWithStatus.Select(book =>
                $"{book.Id};{book.Title};{book.Author};{book.Gener};{book.PublishedDate:yyyy-MM-dd};{book.IsFav};{book.IsAlreadyRead};{book.IsWished}"
            );

            var plainText = string.Join("|", result);

            return Content(plainText, "text/plain");
        }

        // GET: api/Books/5
        [HttpGet("{id}/{userId}")]
        public async Task<ActionResult<string>> GetBook(int id, int userId)
        {
            var book = await _context.Books
                .Where(b => b.Id == id)
                .Select(b => new
                {
                    b.Id,
                    b.Title,
                    b.Author,
                    b.Gener,
                    b.PublishedDate,
                    IsFav = _context.UserFavBooks.Any(fav => fav.UserId == userId && fav.BookId == b.Id),
                    IsAlreadyRead = _context.UserAlreadyreadBooks.Any(read => read.UserId == userId && read.BookId == b.Id),
                    IsWished = _context.UserWishBooks.Any(wish => wish.UserId == userId && wish.BookId == b.Id)
                })
                .FirstOrDefaultAsync();

            if (book == null)
            {
                return NotFound();
            }

            // Formatear la respuesta como texto plano
            var result = $"{book.Id};{book.Title};{book.Author};{book.Gener};{book.PublishedDate:yyyy-MM-dd};{book.IsFav};{book.IsAlreadyRead};{book.IsWished}";

            return Content(result, "text/plain");
        }

        // PUT: api/Books/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBook(int id, Book book)
        {
            if (id != book.Id)
            {
                return BadRequest();
            }

            _context.Entry(book).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BookExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        [HttpPost]
        public async Task<IActionResult> AddBook([FromForm] string title, [FromForm] string author, [FromForm] string gener, [FromForm] string publishedDate, [FromForm] bool isFav, [FromForm] bool isAlreadyRead, [FromForm] bool isWished)
        {
            // Verificar si ya existe un libro con el mismo título y autor
            var existingBook = await _context.Books
                .FirstOrDefaultAsync(b => b.Title == title && b.Author == author);

            if (existingBook != null)
            {
                return Ok("Ese libro ya está registrado");
            }

            // Crear un nuevo libro
            var book = new Book
            {
                Title = title,
                Author = author,
                Gener = gener,
                PublishedDate = publishedDate
            };

            // Agregar el libro a la base de datos
            _context.Books.Add(book);
            await _context.SaveChangesAsync();

            return Ok("Libro agregado con éxito.");
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBook(int id)
        {
            // Check if the book is marked as favorite, already read, or wished by any user
            var isInUse = await _context.UserFavBooks.AnyAsync(fav => fav.BookId == id) ||
                        await _context.UserAlreadyreadBooks.AnyAsync(read => read.BookId == id) ||
                        await _context.UserWishBooks.AnyAsync(wish => wish.BookId == id);

            if (isInUse)
            {
                return BadRequest("El libro no puede ser eliminado porque está asociado a un usuario.");
            }

            var book = await _context.Books.FindAsync(id);
            if (book == null)
            {
                return NotFound("El libro no fue encontrado.");
            }

            _context.Books.Remove(book);
            await _context.SaveChangesAsync();

            return Ok("Libro eliminado con éxito.");
}

        private bool BookExists(int id)
        {
            return _context.Books.Any(e => e.Id == id);
        }


        [HttpGet("user/{userId}/favorite-genre")]
        public async Task<IActionResult> GetFavoriteGenre(int userId)
        {
            // Group user's favorite books by genre and count the occurrences
            var favoriteGenre = await _context.UserFavBooks
                .Where(fav => fav.UserId == userId)
                .GroupBy(fav => fav.Book.Gener)
                .OrderByDescending(group => group.Count())
                .Select(group => group.Key)
                .FirstOrDefaultAsync();

            // Check if a favorite genre was found
            if (string.IsNullOrEmpty(favoriteGenre))
            {
                return NotFound("No se encontró un género favorito.");
            }

            return Ok(favoriteGenre);
        }

        [HttpGet("user/{userId}/random-books")]
        public async Task<IActionResult> GetRandomBooksFromFavoriteGenre(int userId)
        {
            // Identify the user's favorite genre
            var favoriteGenre = await _context.UserFavBooks
                .Where(fav => fav.UserId == userId)
                .GroupBy(fav => fav.Book.Gener)
                .OrderByDescending(group => group.Count())
                .Select(group => group.Key)
                .FirstOrDefaultAsync();

            // If no favorite genre is found, return an empty string
            if (string.IsNullOrEmpty(favoriteGenre))
            {
                return Content("", "text/plain");
            }

            // Fetch random books from the favorite genre
            var randomBooks = await _context.Books
                .Where(book => book.Gener == favoriteGenre)
                .OrderBy(r => Guid.NewGuid())  // Randomize the order
                .Take(5)  // Limit the number of books returned (for example, 5 random books)
                .ToListAsync();

            // Format the books as a single string
            var result = randomBooks.Select(book =>
                $"{book.Id};{book.Title};{book.Author};{book.Gener};{book.PublishedDate:yyyy-MM-dd}"
            );

            var formattedString = string.Join("|", result);

            // Return the plain text content
            return Content(formattedString, "text/plain");
        }
    }
}
