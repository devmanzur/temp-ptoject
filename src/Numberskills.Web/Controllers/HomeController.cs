using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Numberskills.Web.Models;

namespace Numberskills.Web.Controllers;

public class HomeController : Controller
{
    public HomeController()
    {
    }

    public IActionResult Index()
    {
        return View();
    }

    public IActionResult GetImages()
    {
        var images = new List<object>()
        {
            new
            {
                Id = 1,
                Url = "https://images.pexels.com/photos/1156507/pexels-photo-1156507.jpeg?auto=compress&cs=tinysrgb",
            },
            new
            {
                Id = 2,
                Url = "https://images.pexels.com/photos/416179/pexels-photo-416179.jpeg?auto=compress&cs=tinysrgb",
            },
            new
            {
                Id = 3,
                Url = "https://images.pexels.com/photos/326900/pexels-photo-326900.jpeg?auto=compress&cs=tinysrgb",
            },
            new
            {
                Id = 4,
                Url = "https://images.pexels.com/photos/37833/rainbow-lorikeet-parrots-australia-rainbow-37833.jpeg?auto=compress&cs=tinysrgb",
            },
        };

        return Json(ResponseViewModel.Ok(images));
    }
}