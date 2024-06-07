using DataLayer.Context;
using DataLayer.Entity;
using DataLayer.JwtService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer
{
    public class LoginRepository
    {
        private readonly AppDbContext _appDbContext;
        private readonly JWTService _jwtService;

        public LoginRepository(AppDbContext appDbContext, JWTService jwtService)
        {
            _appDbContext = appDbContext;
            _jwtService = jwtService;
        }
        public void AddUser(User user)
        {
            _appDbContext.Users.Add(user);
            _appDbContext.SaveChanges();
        }
        public User GetUserById(int id)
        {
            return _appDbContext.Users.Where(x => x.Id == id).FirstOrDefault();
        }
        public string GetUserByEmailAndPassword(string email, string password)
        {
            var user = _appDbContext.Users.Where(x => x.Email==email && x.Password==password).FirstOrDefault();
            if(user != null)
            {
                var token = _jwtService.GenerateToken(user.Name, user.Email,user.IsAdmin);
                return token;
            }
            return "";
        }
    }
}
