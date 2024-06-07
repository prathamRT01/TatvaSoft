using DataLayer;
using DataLayer.Entity;
using ServiceLayer.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServiceLayer
{
    public class BookService
    {
        private readonly List<Book> _book;
        public BookService()
        {
            _book = new List<Book>()
            {
                new Book() { Id = 1,Title="Book1",Author="pratham",Genre="Entertainment" },
                new Book() { Id = 2,Title="Book2",Author="pratham",Genre="History" }
            };
        }

        public List<Book> GetAllBooks()
        {
            return _book;
        }
        public Book GetBookById(int id)
        {
            return _book.FirstOrDefault(b=>b.Id==id);
        }
        public Book InsertBook(Book book)
        {
            _book.Add(book);
            return book;
        }
        public Book UpdateBook(Book book)
        {
            var index = _book.FindIndex(b=>b.Id==book.Id);
            if(index != -1)
            {
                _book[index] = book;
                return book;
            }
            return null;
        }
        public Book DeleteBook(int id)
        {
            var book = _book.FirstOrDefault(b=>b.Id==id);
            if (book != null) 
            {
                _book.Remove(book);
                return book;
            }
            return null;
        }













        // day 4
        private readonly BookRepository _bookRepository;
        public BookService(BookRepository bookRepository)
        {
            _bookRepository = bookRepository; 
        }

        public async Task InsertBookDetails(BookDetails bookDetails)
        {
            await _bookRepository.InsertBook(bookDetails);
        }
        public BookDetails GetBookDetailsById(int id)
        {
            return _bookRepository.GetBookDetailsById(id);
        }

    }
}
