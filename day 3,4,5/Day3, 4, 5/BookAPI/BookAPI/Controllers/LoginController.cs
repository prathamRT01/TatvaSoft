using DataLayer.Entity;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ServiceLayer;

namespace BookAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly LoginService _loginService;
        public LoginController(LoginService loginService)
        {
            _loginService = loginService;
        }

        [HttpPost]
        public IActionResult RegisterUser(User user)
        {
            if (user==null)
            {
                return BadRequest("Something Went Wrong!!!");
            }
            _loginService.AddUser(user);
            return Ok("User Added Successfully");
        }

        [HttpGet("{id}")]
        public IActionResult GetUser(int id)
        {
            var result = _loginService.GetUserById(id);
            if (result == null)
            {
                return NotFound();
            }
            return Ok(result);
        }

        [HttpPost]
        public IActionResult Login(string email, string password)
        {
            var result = _loginService.GetUserByEmailAndPassword(email, password);
            if (result != "")
            {
                return Ok(result);
            }
            return BadRequest("Please check your email and password");
        }
    }
}
