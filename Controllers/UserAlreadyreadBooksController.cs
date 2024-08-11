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
    public class UserAlreadyreadBooksController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserAlreadyreadBooksController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("{userId}/{bookId}")]
        public async Task<IActionResult> AddToAlreadyRead(int userId, int bookId)
        {
            var existingRecord = await _context.UserAlreadyreadBooks
                .FirstOrDefaultAsync(read => read.UserId == userId && read.BookId == bookId);

            if (existingRecord != null)
            {
                return Ok("Ese libro ya está marcado como leído.");
            }

            var userAlreadyReadBook = new UserAlreadyreadBook
            {
                UserId = userId,
                BookId = bookId
            };

            _context.UserAlreadyreadBooks.Add(userAlreadyReadBook);
            await _context.SaveChangesAsync();

            return Ok("Libro marcado como leído con éxito.");
        }

        [HttpGet("{userId}")]
        public async Task<IActionResult> GetAlreadyReadBooks(int userId)
        {
            var alreadyReadBooks = await _context.UserAlreadyreadBooks
                .Where(read => read.UserId == userId)
                .Select(read => new
                {
                    read.Book.Id,
                    read.Book.Title,
                    read.Book.Author,
                    read.Book.Gener,
                    read.Book.PublishedDate,

                })
                .ToListAsync();

            if (alreadyReadBooks == null || !alreadyReadBooks.Any())
            {
                return Content("", "text/plain");
            }

            var result = alreadyReadBooks.Select(book =>
                $"{book.Id};{book.Title};{book.Author};{book.Gener};{book.PublishedDate:yyyy-MM-dd}"
            );

            var plainText = string.Join("|", result);

            return Content(plainText, "text/plain");
        }

        [HttpDelete("{userId}/{bookId}")]
        public async Task<IActionResult> RemoveFromAlreadyRead(int userId, int bookId)
        {
            var existingRecord = await _context.UserAlreadyreadBooks
                .FirstOrDefaultAsync(read => read.UserId == userId && read.BookId == bookId);

            if (existingRecord == null)
            {
                return NotFound("No se encontró el libro en la lista de leídos.");
            }

            _context.UserAlreadyreadBooks.Remove(existingRecord);
            await _context.SaveChangesAsync();

            return Ok("Libro eliminado de la lista de leídos con éxito.");
        }
    }
}
