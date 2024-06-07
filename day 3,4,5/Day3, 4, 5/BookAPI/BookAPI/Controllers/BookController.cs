using DataLayer.Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ServiceLayer;// using reference of ServiceLayer bcz that is different project.
using ServiceLayer.Model;         

namespace BookAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookController : ControllerBase
    {

        private readonly BookService _bookService;

        public BookController(BookService bookService)
        {
            _bookService = bookService;
        }

        /*[HttpGet]
        public IActionResult GetAllBooks()
        {
            var result = _bookService.GetAllBooks();
            return Ok(result);
        }

        [HttpGet("GetBookById")]
        public IActionResult GetBookByQueryId([FromQuery]int id)  // [FromQuery] annotation to take value from query
        {
            var book = _bookService.GetBookById(id);
            if(book == null)
            {
                return NotFound();
            }
            return Ok(book);
        }

        [HttpGet("{id}")]
        public IActionResult GetBookByParamId(int id)
        {
            var book = _bookService.GetBookById(id);
            if (book == null)
            {
                return NotFound();
            }
            return Ok(book);
        }

        [HttpPost]
        public IActionResult InsertBook(Book book)
        {
            var insertedBook = _bookService.InsertBook(book);
            //return Ok(result);
            return CreatedAtAction(nameof(InsertBook), new { id = insertedBook.Id }, insertedBook);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateBook(int id,Book book)
        {
            if (id != book.Id)
            {
                return BadRequest();
            }
            Book result = _bookService.UpdateBook(book);
            if(result == null)
            {
                return NotFound();
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteBook(int id)
        {
            var book = _bookService.GetBookById(id);
            if(book == null)
            {
                return NotFound();
            }
            Book deletedBook = _bookService.DeleteBook(id);
            if (deletedBook == null)
            {
                return StatusCode(500);
            }
            return Ok("Book data Deleted Successfully of bookId : " + id);
        }
        */

















        // day 4
        [Authorize(Roles = "Admin")]
        [HttpPost("BookDetails")]
        public async Task<IActionResult> InsertBookDetails(BookDetails bookDetails)
        {
            await _bookService.InsertBookDetails(bookDetails);
            //return Ok();
            return CreatedAtAction(nameof(InsertBookDetails),bookDetails);
        }
        [Authorize]
        [HttpGet("BookDetails/{id}")]
        public IActionResult GetBookDetailsById(int id)
        {
            var book = _bookService.GetBookDetailsById(id);
            if (book == null)
            {
                return NotFound();
            }
            return Ok(book);
        }
    }
}
