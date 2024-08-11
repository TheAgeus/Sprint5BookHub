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
    public class UserWishBooksController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserWishBooksController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("{userId}/{bookId}")]
        public async Task<IActionResult> AddToWishList(int userId, int bookId)
        {
            var existingRecord = await _context.UserWishBooks
                .FirstOrDefaultAsync(wish => wish.UserId == userId && wish.BookId == bookId);

            if (existingRecord != null)
            {
                return Ok("Ese libro ya está en tu lista de deseos.");
            }

            var userWishBook = new UserWishBook
            {
                UserId = userId,
                BookId = bookId
            };

            _context.UserWishBooks.Add(userWishBook);
            await _context.SaveChangesAsync();

            return Ok("Libro agregado a la lista de deseos con éxito.");
        }

        [HttpGet("{userId}")]
        public async Task<IActionResult> GetWishListBooks(int userId)
        {
            var wishListBooks = await _context.UserWishBooks
                .Where(wish => wish.UserId == userId)
                .Select(wish => new
                {
                    wish.Book.Id,
                    wish.Book.Title,
                    wish.Book.Author,
                    wish.Book.Gener,
                    wish.Book.PublishedDate,
                })
                .ToListAsync();

            if (wishListBooks == null || !wishListBooks.Any())
            {
                return Content("", "text/plain");
            }

            var result = wishListBooks.Select(book =>
                $"{book.Id};{book.Title};{book.Author};{book.Gener};{book.PublishedDate:yyyy-MM-dd}"
            );

            var plainText = string.Join("|", result);

            return Content(plainText, "text/plain");
        }

        [HttpDelete("{userId}/{bookId}")]
        public async Task<IActionResult> RemoveFromWishList(int userId, int bookId)
        {
            var existingRecord = await _context.UserWishBooks
                .FirstOrDefaultAsync(wish => wish.UserId == userId && wish.BookId == bookId);

            if (existingRecord == null)
            {
                return NotFound("No se encontró el libro en la lista de deseos.");
            }

            _context.UserWishBooks.Remove(existingRecord);
            await _context.SaveChangesAsync();

            return Ok("Libro eliminado de la lista de deseos con éxito.");
        }
    }
}
