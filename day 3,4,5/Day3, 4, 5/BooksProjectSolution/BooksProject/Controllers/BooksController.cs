using BooksProject.Models;
using BooksProject.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BooksProject.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BooksController : ControllerBase
    {
        private readonly BookService _bookService;
        public BooksController(BookService bookService)
        {
            _bookService = bookService;
        }

        [HttpGet]
        public ActionResult<List<Book>> Get() => _bookService.GetAll();
        [HttpGet("{id}")]
        public ActionResult<Book> Get(int id)
        {
            var book = _bookService.GetById(id); 
            if (book == null)
            {
                return NotFound();
            }
            //return book;
            //return Ok();
            return Ok(book);

        }

        [HttpPost]
        public ActionResult<Book> Post(Book book)
        {
            if (book == null)
                return null;
            _bookService.Add(book);
            //return book;
            return CreatedAtAction(nameof(Get),new {id=book.Id},book);
        }

        [HttpPut("{id}")]
        public ActionResult<string> Put(int id,Book book)
        {
            if(id != book.Id)
            {
                return BadRequest();
            }
            var existingBook = _bookService.GetById(id);
            if(existingBook == null)
            {
                return NotFound();
            }
            _bookService.Update(book);
            return "Book data updated successfully";
        }

        [HttpDelete("{id}")]
        public ActionResult<string> Delete(int id)
        {
            var book = _bookService.GetById(id);
            if (book == null)
            {
                return NotFound();
            }
            _bookService.Delete(id);
            return "Book deleted successfully with id: " + id;
        }
        /*public IActionResult Delete(int id)
        {
            var book = _bookService.GetById(id);
            if (book == null)
            {
                return NotFound();
            }
            _bookService.Delete(id);
            return NoContent();
        }*/
        
        
    }
}
