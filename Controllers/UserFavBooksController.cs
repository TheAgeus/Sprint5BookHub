using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LibrosApi.Context;
using LibrosApi.Models;
using Microsoft.CodeAnalysis.Elfie.Serialization;

namespace LibrosApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserFavBooksController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserFavBooksController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("{userId}/{bookId}")]
        public async Task<IActionResult> AddToFavorites(int userId, int bookId)
        {
            var existingRecord = await _context.UserFavBooks
                .FirstOrDefaultAsync(fav => fav.UserId == userId && fav.BookId == bookId);

            if (existingRecord != null)
            {
                return Ok("Ese libro ya es tu favorito");
            }

            var userFavBook = new UserFavBook
            {
                UserId = userId,
                BookId = bookId
            };

            _context.UserFavBooks.Add(userFavBook);
            await _context.SaveChangesAsync();

            return Ok("Libro agregado a favoritos con éxito.");
        }

        [HttpGet("{userId}")]
        public async Task<IActionResult> GetFavoriteBooks(int userId)
        {
            // Fetch favorite books for the user
            var favoriteBooks = await _context.UserFavBooks
                .Where(fav => fav.UserId == userId)
                .Select(fav => new
                {
                    fav.Book.Id,
                    fav.Book.Title,
                    fav.Book.Author,
                    fav.Book.Gener,
                    fav.Book.PublishedDate,
                })
                .ToListAsync();

            // Check if there are any favorite books
            if (favoriteBooks == null || !favoriteBooks.Any())
            {
                // Return an empty response if no favorite books found
                return Content("", "text/plain");
            }

            // Format the response as plain text
            var result = favoriteBooks.Select(book =>
                $"{book.Id};{book.Title};{book.Author};{book.Gener};{book.PublishedDate:yyyy-MM-dd}"
            );

            var plainText = string.Join("|", result);

            // Return the plain text content
            return Content(plainText, "text/plain");
        }


        [HttpDelete("{userId}/{bookId}")]
        public async Task<IActionResult> RemoveFromFavorites(int userId, int bookId)
        {
            // Find the existing record in the UserFavBooks table
            var existingRecord = await _context.UserFavBooks
                .FirstOrDefaultAsync(fav => fav.UserId == userId && fav.BookId == bookId);

            // Check if the record exists
            if (existingRecord == null)
            {
                return NotFound("No se encontró el libro en tus favoritos.");
            }

            // Remove the record from the UserFavBooks table
            _context.UserFavBooks.Remove(existingRecord);
            await _context.SaveChangesAsync();

            return Ok("Libro eliminado de favoritos con éxito.");
        }
    }
}
