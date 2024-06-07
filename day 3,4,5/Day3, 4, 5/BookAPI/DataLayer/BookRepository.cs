using DataLayer.Context;
using DataLayer.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//interacting with database using LINQ queries
namespace DataLayer
{
    public class BookRepository
    {
        private AppDbContext _appDbContext;
        public BookRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }
        public async Task InsertBook(BookDetails bookDetails)
        {
            await _appDbContext.AddAsync(bookDetails);
            await _appDbContext.SaveChangesAsync();
        }
        public BookDetails GetBookDetailsById(int id)
        {
            var bookDetails = _appDbContext.BookDetails.Where(x => x.Id == id).FirstOrDefault();
            return bookDetails;
        }
    }
}
